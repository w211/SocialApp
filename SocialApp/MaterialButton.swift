//
//  MaterialButton.swift
//  SocialApp
//
//  Created by Richard Cuico on 5/31/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import Foundation
import UIKit

class MaterialButton: UIButton {
    
    override func awakeFromNib() {
        // Called when the user-interface is loaded from the storyboard
        // Here we're making shadows for the views and slightly round the corners
        
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        // Here we create the color and then you grab the CGColor property out of it
        // Thats how you create your shadow color.
        // shadowColor is a CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
    
}