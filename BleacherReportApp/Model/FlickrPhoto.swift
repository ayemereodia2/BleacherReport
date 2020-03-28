//
//  FlickrPhoto.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

struct Flickr: Codable {
    let photos: Photos?
    let stat: String?
}

struct Photos: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: String?
    let photo: [FlickrPhoto]?
}

struct FlickrPhoto:Codable {
    
      let url: String?
      let id: String?
      let owner: String?
      let secret: String?
      let server: String?
      let farm: Int?
      let title: String?
      let ispublic: Int?
      let isfriend: Int?
      let isfamily: Int?
      let height: Int?
      let width: Int?
      
      enum CodingKeys: String, CodingKey {
          case id, owner, secret, server, farm, title
          case ispublic, isfriend, isfamily
          case url = "url_m"
         case height = "height_m"
         case width = "width_m"
      }
}
