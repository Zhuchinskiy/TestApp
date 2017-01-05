//
//  AlbumCollectionViewCell.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/5/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var albumImageView: UIImageView!
    
    class func identifier() -> String {
        return "AlbumCollectionViewCellIdentifier"
    }
    
}
