//
//  FeedVC.swift
//  SocialApp
//
//  Created by Richard Cuico on 6/7/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    static var imageCache = NSCache()
    // Static makes one instance of it globally available
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 358
     
        DataService.ds.REF_POSTS.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            // This is a closure so even if it's in viewDidLoad it'll still update everytime data is changed
            print(snapshot.value)
            
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            
            // Anytime we create a new cell we want to cancel the request right off the bat
            cell.request?.cancel()
            // If there's nothing, nothing will happen due to the question mark
            // But if there is it'll cancel the request
            
            var img: UIImage?
            // This makes an empty image
            
            if let url = post.imageUrl {
                img = FeedVC.imageCache.objectForKey(url) as? UIImage
                // This fills up the img with an image
                // If this doesn't work then it'll just pass an empty image
            }
            
            cell.configureCell(post, img: img)
            
            return cell
        } else {
            return PostCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let post = posts[indexPath.row]
        
        if post.imageUrl == nil {
            return 150
        } else {
            return tableView.estimatedRowHeight
        }
        
    }
}
