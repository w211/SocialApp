//
//  PostCell.swift
//  SocialApp
//
//  Created by Richard Cuico on 6/7/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import UIKit
import Alamofire

// We're using Cooca Touch class since this is a view not a controller

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    var request: Request?
    
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

    func configureCell(post: Post, img: UIImage?) {
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
        if post.imageUrl != nil {
            
            if img != nil {
                self.showcaseImg.image = img
            } else {
                
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.showcaseImg.image = img
                        FeedVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                    }
                    
                })
            }
            
        } else {
            self.showcaseImg.hidden = true
        }
        
    }

}
