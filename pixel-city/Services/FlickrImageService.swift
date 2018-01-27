//
//  FlickrImageService.swift
//  pixel-city
//
//  Created by Иван on 27.01.2018.
//  Copyright © 2018 iSOKOL DEV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FlickrImageService {
    static let instance = FlickrImageService()
    private init() {}
    
    var imageUrls = [String]()
    
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
}
