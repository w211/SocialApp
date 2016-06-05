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
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        
        let facebookLogin =  FBSDKLoginManager()
        
            
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
                    
            if facebookError != nil {
                        print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")
            
                DataService.ds.REF_BASE
            
            }
        })
     
    }
    
    @IBOutlet weak var userName: MaterialTextField!
    
    @IBOutlet weak var passWord: MaterialTextField!
    
    @IBAction func createAccount(sender: AnyObject) {
    
        FIRAuth.auth()?.createUserWithEmail(userName.text!, password: passWord.text!, completion: { (user: FIRUser?, error: NSError?) in
            
            if error != nil {
                
                print("account has been found")
                self.login()
                
            } else {
             
                print("user created")
                self.login()
                
            }
            
        })
    
    
    }
    
    func login() {
        
        FIRAuth.auth()?.signInWithEmail(userName.text!, password: passWord.text!, completion: { (user: FIRUser?, error:NSError?) in
            
            if error != nil {
                
                print("password or email is wrong")
                
            } else {
                
                print("Logged in")
                
            }
            
        })
        
    }
    
    
}

