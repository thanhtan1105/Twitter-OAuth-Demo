//
//  ViewController.swift
//  Twitter OAuth Demo
//
//  Created by USER on 11/27/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogIn(sender: UIButton) {
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil {
                //perform segue
                
                self.performSegueWithIdentifier("lofinSeguw", sender: self)
            } else {
                //handle login error
            }
            
            }
        
       }

}