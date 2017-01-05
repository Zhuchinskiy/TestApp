//
//  NavigationItemView.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/5/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class NavigationItemView: UIView {
    
    @IBOutlet var countryButton: RightArrowButton!

    class func itemView() -> NavigationItemView? {
        let nib = UINib(nibName: "NavigationItemView", bundle: nil)
        let itemView = nib.instantiate(withOwner: self, options: nil).first as! NavigationItemView?
        itemView?.backgroundColor = UIColor.clear
        return itemView
    }
    
}
