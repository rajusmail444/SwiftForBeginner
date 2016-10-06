//
//  RssReaderDetailViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 23/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class RssReaderDetailViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    var url:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = NSURL(string: self.url!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        let request = NSURLRequest(URL: myURL!)
        self.webView.loadRequest(request)
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
