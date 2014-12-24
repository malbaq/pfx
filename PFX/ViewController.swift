//
//  ViewController.swift
//  PFX
//
//  Created by Tom Malary on 12/22/14.
//  Copyright (c) 2014 ProFreX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var loginCancelledLabel: UILabel!
    
    //the var below suddenly appeared at #120 at 07:40
    var fbLoginView: FBLoginView = FBLoginView(readPermissions: ["email", "public_profile"])
    
    @IBAction func fbSignInButtonPressed(sender: AnyObject) {
        
        self.loginCancelledLabel.alpha = 0
        
        //Facebook auth and get back public profile and email
        var permissions = ["email", "public_profile"]
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
                
                self.loginCancelledLabel.alpha = 1
                
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                
                self.performSegueWithIdentifier("signUp", sender: self)
                
            } else {
                NSLog("User logged in through Facebook!")
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if PFUser.currentUser() != nil {
            println("The user is logged in")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

