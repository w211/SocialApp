//
//  MaterialTextField.swift
//  SocialApp
//
//  Created by Richard Cuico on 5/31/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import Foundation
import UIKit

class MaterialTextField: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
        
    }
    
    // For placeholder
    // This is so that the text isn't running along the left edge
    // Here we'll give an indentation to the text
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    // This gets the texting you're actually typing in the field to also be indented
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
}