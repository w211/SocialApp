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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
     
        DataService.ds.REF_POSTS.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            // This is a closure so even if it's in viewDidLoad it'll still update everytime data is changed
            print(snapshot.value)
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
    }
    
}
