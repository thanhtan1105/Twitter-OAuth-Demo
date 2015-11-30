//
//  TwitterClient.swift
//  Twitter OAuth Demo
//
//  Created by USER on 11/27/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

let twitterConsumerKey = "eL7lXT1Un0YH8wwNzGEevLm2A"
let twitterConsumerSecret = "NrkMudK0Gh3q08PFEgKpLiryh4gF6WWQYxKOrM45DC4LDUGheV"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            
        }
        return Static.instance
    }
    func loginWithCompletion(completion: (user: User?, error: NSError) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to authourization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil , success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            })
            { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion!(user: nil, error: error)
        }
        
    }
    
    func openURL(url: NSURL) {
       fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: {
            (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access tokenn!")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // print("user: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as UIViewController
                UIApplication.sharedApplication().keyWindow?.rootViewController = vc

                
                }, failure: {(operation: AFHTTPRequestOperation?, error: NSError?) -> Void in
                    print("error getting current user")
                    self.loginCompletion!(user: nil, error: error!)
                    
            })
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // print("home timeline: \(response)")
                
                let tweets = Tweet.tweetWithArray(response as! [NSDictionary])
                
                for tweet in tweets{
                    
                    print("text: \(tweet.text), creat: \(tweet.createdAt)")
                    
                }
                
                }, failure: {(operation: AFHTTPRequestOperation?, error: NSError?) -> Void in
                    print("error getting home timeline")
                    
            })
            
            
            }) { (error: NSError?) -> Void in
                print("Failed to recive access token")
        }
        

    }
    
    }


