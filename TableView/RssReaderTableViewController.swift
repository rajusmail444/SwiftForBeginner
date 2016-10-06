//
//  RssReaderTableViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 23/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class RssReaderTableViewController: UITableViewController,NSXMLParserDelegate{
    var parser:NSXMLParser?
    var feeds = [Dictionary<String, String>]()
    var item = Dictionary<String, String>()
    var feedTitle:String = ""
    var link:String = ""
    var element:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")
        parser = NSXMLParser(contentsOfURL: url!)
        parser?.delegate = self
        parser?.parse()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RssReaderCell", forIndexPath: indexPath)
        cell.textLabel?.text = feeds[indexPath.row]["title"]
        return cell
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        print("element:\(element)")
        if element == "item" {
            feedTitle = ""
            link = ""
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print("element1:\(element)")
        if element == "title" {
            feedTitle += string
            item[element] = feedTitle
            print("element1:feedTitle:\(feedTitle)")
        }else if element == "link" {
            link += string
            item[element] = link
            print("element1:link:\(link)")
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("element2:\(elementName)")
        if elementName == "item" {
            /*if element == "title" {
                item[element] = feedTitle
            }else if element == "link" {
                item[element] = link
            }*/
            print("element2:item:\(item)")
            feeds.append(item)
            print("element2:feeds:\(feeds)")
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            if let destViewController = segue.destinationViewController as? RssReaderDetailViewController {
                let string = feeds[(indexPath?.row)!]["link"]
                destViewController.url = string
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
