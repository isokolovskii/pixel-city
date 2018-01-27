//
//  FlickrImageService.swift
//  pixel-city
//
//  Created by Иван on 27.01.2018.
//  Copyright © 2018 iSOKOL DEV. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class FlickrImageService {
    static let instance = FlickrImageService()
    private init() {}
    
    var imageUrls = [String]()
    var images = [UIImage]()
    
    func retrieveUrls(forAnnotation annotation: DroppablePin, completion: @escaping
        CompletionHandler) {
        imageUrls = []
        
        Alamofire.request(flickrUrl(withAnnotation: annotation, andNumberOfPhotos: 40))
            .responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    let json = JSON(data)
                    if let photos = json["photos"]["photo"].array {
                        for photo in photos {
                            let postUrl = "https://farm\(photo["farm"].intValue).staticflickr.com/\(photo["server"].intValue)/\(photo["id"].stringValue)_\(photo["secret"].stringValue)_h_d.jpg"
                            self.imageUrls.append(postUrl)
                        }
                        completion(true)
                    }
                } else {
                    debugPrint(response.result.error as Any)
                    completion(false)
                }
        }
    }
    
    func retrieveImages(completion: @escaping CompletionHandler, downloadHandler: @escaping
        (_ numberOfDownloadedImages: Int) -> ()) {
        images = []
        
        for url in imageUrls {
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                if response.result.error == nil {
                    guard let image = response.result.value else { return }
                    self.images.append(image)
                    downloadHandler(self.images.count)
                    if self.images.count == self.imageUrls.count {
                        completion(true)
                    }
                } else {
                    debugPrint(response.result.error as Any)
                    completion(false)
                }
            })
        }
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask,
            uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
            self.images = []
            self.imageUrls = []
        }
    }
}
