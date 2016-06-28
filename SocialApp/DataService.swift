//
//  DataService.swift
//  SocialApp
//
//  Created by Richard Cuico on 6/1/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

// This is a singleton
// A singleton is a single instance of an object class that you have access to

let URL_BASE = "https://socialapp-c56e3.firebaseio.com"

    class DataService {
        static let ds = DataService()
    
        // Static variable means there's only one instance of it in memory
        // Here we're creating a static variable and make is globally accessible
        
        private var _REF_BASE = FIRDatabase.database().reference()
        private var _REF_POSTS = FIRDatabase.database().referenceFromURL("\(URL_BASE)/posts")
        private var _REF_USERS = FIRDatabase.database().referenceFromURL("\(URL_BASE)/users")

        
        var REF_BASE: FIRDatabaseReference {
            return _REF_BASE
        }
        
        var REF_POSTS: FIRDatabaseReference {
            return _REF_POSTS
        }
        
        var REF_USERS: FIRDatabaseReference {
            return _REF_USERS
        }
        
        func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
            //Here is gets the uid from a specific user
            //However if there isn't a uid it will create one
            
            REF_USERS.child(uid).setValue(user)
        }
        
        var REF_USER_CURRENT: FIRDatabaseReference {
            let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
            let user = FIRDatabase.database().referenceFromURL("\(URL_BASE)").child("users").child(uid)
            return user
        }
        
    }