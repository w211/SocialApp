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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Segues dont work in viewDidLoad
        // They only work after all the views have appeared on the screen
        
        // Here we're seeing if there is a Key_UID
        // If there is it'll log us right into the app since we signed in before
        // So if KEY_UID is equal to something it'll log us in
        
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
                        print("Logged In! \(authData?.providerID)")
                        
                        
                        let user: [String: String] = ["provider": accessToken.provider, "blah": "test"]
                        
                        DataService.ds.createFirebaseUser(authData!.uid, user: user)
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        })
    }
    
    
    @IBOutlet weak var emailField: MaterialTextField!
    
    @IBOutlet weak var passwordField: MaterialTextField!
    
    @IBAction func attemptLogin(sender: UIButton!) {
    
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error: NSError?) in
                
                if error != nil {
                    print("ACCOUNT HAS BEEN FOUND \(error)")
                    self.login()
                } else {
                    print("USER CREATED \(user)")
                    self.login()
                }
            })
            
        } else {
            showErrorAlert("Email and Password Required", msg: "Please check if you entered in an email and password")
        }
    }
  
    
    func login() {
        
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion: { (authData: FIRUser?, error:NSError?) in
            
            if error != nil {
                print("PASSWORD IS WRONG \(error)")
                self.showErrorAlert("Incorrect Password", msg: "Please check if you have entered the correct password")
            } else {
                print("LOGGED IN \(authData)")
                
                let user: [String: String] = ["provider": "email", "blah2": "test2"]
                DataService.ds.createFirebaseUser(authData!.uid, user: user)
                
                NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: KEY_UID)
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            }
        })
    }
    
    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    
}
