//
//  RecipesDetailViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 09/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {
    var recipes : Recipes?
    @IBOutlet weak var recipePhoto : UIImageView?
    @IBOutlet weak var prepTimeLabel : UILabel?
    @IBOutlet weak var ingredientTextView : UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = recipes!.name;
        self.recipePhoto?.image = UIImage(named: recipes!.thumbnails)
        self.prepTimeLabel?.text = recipes!.prepTime
        
        var ingredientText : String=""
        for ingredient in recipes!.ingredients {
            ingredientText.appendContentsOf(ingredient)
            ingredientText = ingredientText + "\n"
        }
        self.ingredientTextView?.text = ingredientText
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
