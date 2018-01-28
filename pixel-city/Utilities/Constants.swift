//
//  Constants.swift
//  pixel-city
//
//  Created by Иван on 27.01.2018.
//  Copyright © 2018 iSOKOL DEV. All rights reserved.
//

import Foundation

typealias CompletionHandler = (Bool) -> ()

// Identifiers
let DROPPABLE_PIN = "droppablePin"
let PHOTO_CELL = "photoCell"
let POP_VC = "popVC"

// Fonts
let AVENIR_NEXT = "Avenir Next"

// Flickr API
let API_KEY = "258ecf4104ce822e80ddb16255b0bae9"
let BASE_URL = "https://api.flickr.com/services/rest"
let PHOTOS_SEARCH = "\(BASE_URL)?method=flickr.photos.search"
let RADIUS = 0.5
let RADIUS_UNITS = "km"
let RESPONSE_FORMAT = "format=json&nojsoncallback=1"

func flickrUrl(withAnnotation annotation: DroppablePin, andNumberOfPhotos
    number: Int) -> String {
    return "\(PHOTOS_SEARCH)&api_key=\(API_KEY)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=\(RADIUS)&radius_units=\(RADIUS_UNITS)&per_page=\(number)&\(RESPONSE_FORMAT)"
}
