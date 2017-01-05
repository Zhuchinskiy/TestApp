//
//  TopArtistTableViewCell.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/5/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class TopArtistTableViewCell: UITableViewCell {

    @IBOutlet var artistImageView: UIImageView!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var artistListener: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func identifier() -> String {
        return "TopArtistCellIdentifier"
    }
    
}
