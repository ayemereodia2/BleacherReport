//
//  PhotoCell2.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

class PhotoCell2: UICollectionViewCell {

    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrl: String? {
           didSet {
               guard let imageUrl = imageUrl else { return }
               imageView?.loadImageUsingCache(with: imageUrl)
           }
       }
       
       // MARK:- Screen properties
       var imageTitle: String?{
           didSet{
               guard let title = imageTitle else { return }
               imageLabel?.text = title
           }
       }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }

    
}
