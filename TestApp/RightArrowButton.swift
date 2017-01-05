//
//  RightArrowbutton.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/5/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class RightArrowButton: UIButton {

    fileprivate let labelRightOffset: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    fileprivate func customInit() {
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byClipping
        
        setTitleColor(UIColor.black, for: UIControlState())
        setTitleColor(UIColor.lightGray, for: .highlighted)
        
        setupImage()
    }
    
    fileprivate func setupImage() {
        let image = UIImage(named: "arrow-down-small-24")
        setImage(image, for: UIControlState())
        setImage(image, for: .highlighted)
        imageView?.contentMode = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let imageView = imageView {
            let imageViewWitdh = imageView.frame.width
            let imageViewHeight = imageView.frame.height
            
            var labelFrame = frame
            labelFrame.size.width = frame.width - imageViewWitdh - labelRightOffset
            labelFrame.origin = CGPoint(x: 0, y: 0)
            titleLabel?.frame = labelFrame
            
            imageView.frame = CGRect(x: frame.size.width - imageViewWitdh, y: imageView.frame.origin.y, width: imageViewWitdh, height: imageViewHeight)
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + labelRightOffset, height: size.height)
    }
    
}
