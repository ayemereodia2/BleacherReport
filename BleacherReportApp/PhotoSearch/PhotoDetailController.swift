//
//  PhotoDetailController.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

class PhotoDetailController: UIViewController {
    
    // MARK:- Properties
    var viewModel: ProPhotoDetailViewModel?
    
    // MARK:- Screen Properties
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentMode = .scaleToFill
        sv.clipsToBounds = true
        
        sv.alwaysBounceVertical = false
        sv.alwaysBounceHorizontal = false
        sv.showsVerticalScrollIndicator = true
        sv.showsHorizontalScrollIndicator = true
        sv.autoresizesSubviews = false
        
        sv.maximumZoomScale = 3.0
        sv.minimumZoomScale = 1.0
        sv.delegate = self
        return sv
    }()
    
    private let photoDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Detail"
        view.backgroundColor = .black
        
        setupSubviews()
        

        guard let viewModel = viewModel else { return }
        photoDetailImageView.loadImageUsingCache(with: viewModel.imageUrl)
    }
    
    deinit {
        print("DetailController \(#function)")
    }
    
    // MARK:- Screen layout methods
    fileprivate func setupSubviews() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(scrollView)
        
        scrollView.anchor(top: guide.topAnchor,
                          leading: guide.leadingAnchor,
                          bottom: guide.bottomAnchor,
                          trailing: guide.trailingAnchor)
        
        scrollView.addSubview(photoDetailImageView)
        
        photoDetailImageView.centerInSuperview()
    }
    
 
}

// MARK:- Regarding UIScrollViewDelegate methods
extension PhotoDetailController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoDetailImageView
    }
}
