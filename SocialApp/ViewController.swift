//
//  ViewController.swift
//  SocialApp
//
//  Created by Richard Cuico on 5/31/16.
//  Copyright © 2016 Richard Cuico. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        
        let facebookLogin =  FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")

            }
        }
        
    }


}

