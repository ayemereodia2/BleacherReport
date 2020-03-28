//
//  PhotoCell.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var imageUrl: String? {
        didSet {
            guard let imageUrl = imageUrl else { return }
            photoImageView.loadImageUsingCache(with: imageUrl)
        }
    }
    
    var imageTitle: String?{
        didSet{
            guard let title = imageTitle else { return }
            imageUILabel.text = title
        }
    }
    
    
    // MARK:- Screen properties
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image =  #imageLiteral(resourceName: "image_placeholder")
        return iv
    }()
    
    private let imageUILabel: UILabel = {
        let iv = UILabel()
        
        return iv
    }()
    
    // MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //addSubview(imageUILabel)

        addSubview(photoImageView)
        photoImageView.fillSuperview()
        //imageUILabel.centerInSuperview(size: .init(width: 150, height: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
