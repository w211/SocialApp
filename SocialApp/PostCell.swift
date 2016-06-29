//
//  PostCell.swift
//  SocialApp
//
//  Created by Richard Cuico on 6/7/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase

// We're using Cooca Touch class since this is a view not a controller

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var post: Post!
    var request: Request?
    var likeRef: FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        likeImage.userInteractionEnabled = true
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
        
        likeRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
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
        
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let doesNotExist = snapshot.value as? NSNull {
                // In Firebase, data that doesnt exist is a NSNull
                // This is a Firebase thing
                // In Firebase, if there isnt data in ".value" you will get a NSNull
                // So dont check against nil or null
                // This means when we get to this portion of the code we havent liked this specific post
                
                self.likeImage.image = UIImage(named: "heart-empty")
            } else {
                self.likeImage.image = UIImage(named: "heart-full")
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let doesNotExist = snapshot.value as? NSNull {
                // In Firebase, data that doesnt exist is a NSNull
                // This is a Firebase thing
                // In Firebase, if there isnt data in ".value" you will get a NSNull
                // So dont check against nil or null
                // This means when we get to this portion of the code we havent liked this specific post
                
                self.likeImage.image = UIImage(named: "heart-full")
                self.post.adjustLikes(true)
                self.likeRef.setValue(true)
                
            } else {
                self.likeImage.image = UIImage(named: "heart-empty")
                self.post.adjustLikes(false)
                self.likeRef.removeValue()
            }
        })
    }
}
