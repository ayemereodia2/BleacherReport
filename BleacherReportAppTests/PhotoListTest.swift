//
//  PhotoListTest.swift
//  BleacherReportAppTests
//
//  Created by Ayemere  Odia  on 29/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

import XCTest
@testable import BleacherReportApp

class PhotoListViewControllerTest:XCTestCase{

    //to test view controllers,
    //you need to load the view
    //you need to start the view life cycle
    
    func test_viewDidLoad_PhotoSearchController(){
        //let dataSource = RestaurantDataSource()

        let spyViewModel = PhotoSearchViewModel()

        let sut = makeSUT(options: spyViewModel)
        
        let nib = UINib(nibName: "PhotoCell2", bundle: nil)

        sut.thecollectionView.register(nib, forCellWithReuseIdentifier: "photoCell2Id")
        
        
        XCTAssertEqual(sut.thecollectionView.numberOfItems(inSection: 0), 0)
    }
    

}



// MARK :- Refactoring

func makeSUT(options:PhotoSearchViewModel
, selection: @escaping ([String])->Void = {_ in})->PhotoSearchController{
    
    let sut = PhotoSearchController.create(with: options) as! PhotoSearchController
    let nib = UINib(nibName: "PhotoCell2", bundle: nil)

    sut.thecollectionView.register(nib, forCellWithReuseIdentifier: "photoCell2Id")

    _ = sut.view //load view
    
    return sut
}
