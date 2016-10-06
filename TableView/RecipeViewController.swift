//
//  RecipeViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 17/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeImageView: UIImageView!
    var recipeImageName : String?
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeImageView.image = UIImage(named: recipeImageName!)
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
