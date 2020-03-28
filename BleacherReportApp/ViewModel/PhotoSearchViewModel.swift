//
//  PhotoSearchViewModel.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation


class PhotoSearchViewModel {
    // MARK:- Properties
    private let photos: [FlickrPhoto]
    
    // MARK:- Dependency Injection (DI)
    init(photos: [FlickrPhoto] = []) {
        self.photos = photos
    }
    
    // MARK:- Handling methods
    func photo(for indexPath: IndexPath) -> FlickrPhoto {
        return photos[indexPath.row]
    }
    
    func numberOfItems() -> Int {
        return photos.count
    }
    
    func imageUrl(for indexPath: IndexPath) -> String {
        let photo = self.photo(for: indexPath)
        return photo.url ?? ""
    }
    
    func imageTitle(for indexPath: IndexPath) -> String {
        let photo = self.photo(for: indexPath)
        return photo.title ?? ""
    }
    
}
