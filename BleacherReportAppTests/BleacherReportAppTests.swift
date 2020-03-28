//
//  BleacherReportAppTests.swift
//  BleacherReportAppTests
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import BleacherReportApp

class BleacherReportAppTests: XCTestCase {

   //var sut = ServiceAPI
    
    var output: [FlickrPhoto] = []

   func test_Get_25_Item_In_Table(){
    
    guard let searchUrl = FlickrAPI.shared.searchUrl(with: "goose") else { return }
    
           
    FlickrAPI.shared.flickrSearch(with: searchUrl) { [weak self] (photos, err) in
               if let err = err {
                   print("Failed to fetch flickr data: \(err.localizedDescription)")
                   return
               }
               guard
                   let self = self,
                   let photos = photos else { return }
        
        self.output = photos
    }
       
    
    XCTAssertEqual(self.output.count,25)
   }


}
