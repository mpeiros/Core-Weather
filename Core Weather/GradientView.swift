//
//  GradientView.swift
//  Core Weather
//
//  Created by Max Peiros on 11/2/16.
//  Copyright © 2016 Max Peiros. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {

    @IBInspectable var topColor: UIColor = UIColor.cyanColor()
    @IBInspectable var bottomColor: UIColor = UIColor.whiteColor()

    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.CGColor, bottomColor.CGColor]
    }
    
}
