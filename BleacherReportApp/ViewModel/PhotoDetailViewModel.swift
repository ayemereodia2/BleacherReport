//
//  PhotoDetailViewModel.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

class PhotoDetailViewModel {
    
    private let photo: FlickrPhoto
    
    var imageUrl: String {
        return photo.url ?? ""
    }
    
    init(photo: FlickrPhoto) {
        self.photo = photo
    }
}
