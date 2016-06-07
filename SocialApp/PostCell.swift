//
//  PostCell.swift
//  SocialApp
//
//  Created by Richard Cuico on 6/7/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import UIKit

// We're using Cooca Touch class since this is a view not a controller

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func drawRect(rect: CGRect) {
        //This is place here instead of awakeFromNib since the sizes and contraints havent been put together yet
        //for the profileImg
        //We put it into drawRect since this will happen after a profileImg is put inside
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        
        //ClipToBounds make sures the image doesnt go outside of where it's supposed to go
        profileImg.clipsToBounds = true
        showcaseImg.clipsToBounds = true
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
