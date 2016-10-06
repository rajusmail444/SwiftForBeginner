//
//  AboutViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 09/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView : UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = self.nibBundle!.pathForResource("about.html", ofType: nil) {
            let url : NSURL = NSURL(fileURLWithPath: path)
            let request : NSURLRequest = NSURLRequest(URL: url)
            webView?.loadRequest(request)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
