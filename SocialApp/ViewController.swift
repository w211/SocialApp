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
import FirebaseAuth

class ViewController: UIViewController {
    
    // Segues dont work in viewDidLoad
    // They only work after all the views have appeared on the screen
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        
        let facebookLogin =  FBSDKLoginManager()
        
            
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
                    
            if facebookError != nil {
                        print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString);
                let printableAccessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    print("Successfully logged in with facebook. \(printableAccessToken)")
                
            
                FIRAuth.auth()?.signInWithCredential(accessToken, completion: { (authData: FIRUser?, error: NSError?) in
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged In! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
                })

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
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                
            }
            
        })
        
    }
    
    
}

