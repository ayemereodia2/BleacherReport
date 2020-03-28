//
//  FlickrConstants.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

struct Constants {
    
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
    static let APIPath = "/services/rest"
    
    static let APIparameters = [
        "method" : "flickr.photos.search",
        "api_key" : FlickrConfig.apiKey,
        "sort" : "relevance",
        "per_page" : "20",
        "format" : "json",
        "nojsoncallback" : "1",
        "extras" : "url_m"
    ]
}


