//
//  SocialSharingViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 17/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit
import Social

class SocialSharingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func postToTwitter(sender: AnyObject) {
        print("inside postToTwitter")
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)){
            print("postToTwitter if")
            let tweetSheet:SLComposeViewController = SLComposeViewController.init(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText("Sample from my code :)")
            print("postToTwitter tweetSheet: \(tweetSheet)")
            self.presentViewController(tweetSheet, animated: true, completion: nil)
        }
    }
    @IBAction func postToFacebook(sender: AnyObject) {
        print("inside postToFacebook")
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)){
            print("postToFacebook if")
            let controller:SLComposeViewController = SLComposeViewController.init(forServiceType: SLServiceTypeFacebook)
            controller.setInitialText("From my Swift Code !!!")
            controller.addURL(NSURL(string: "http://www.appcoda.com"))
            controller.addImage(UIImage(named: "white_chocolate_donut.jpg"))
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
