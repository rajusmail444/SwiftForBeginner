//
//  RecipesTableViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 07/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
//    var recipes = ["Egg Benedict", "Mushroom Risotto", "Full Breakfast", "Hamburger", "Ham and Egg Sandwich", "Creme Brelee", "White Chocolate Donut", "Starbucks Coffee", "Vegetable Curry", "Instant Noodle with Egg", "Noodle with BBQ Pork", "Japanese Noodle with Pork", "Green Tea", "Thai Shrimp Cake", "Angry Birds Cake", "Ham and Cheese Panini"]
//    var thumbnails = ["egg_benedict.jpg", "mushroom_risotto.jpg", "full_breakfast.jpg", "hamburger.jpg", "ham_and_egg_sandwich.jpg", "creme_brelee.jpg", "white_chocolate_donut.jpg", "starbucks_coffee.jpg", "vegetable_curry.jpg", "instant_noodle_with_egg.jpg", "noodle_with_bbq_pork.jpg", "japanese_noodle_with_pork.jpg", "green_tea.jpg", "thai_shrimp_cake.jpg", "angry_birds_cake.jpg", "ham_and_cheese_panini.jpg"]
    let searchController = UISearchController(searchResultsController:nil)
    var recipesList = [Recipes]()
    var filteredRecipes = [Recipes]()
//    var recipes:[String] = [];
//    var thumbnails:[String]  = [];
//    var prepTime:[String]  = [];
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        
        if let path = self.nibBundle!.pathForResource("recipes", ofType: "plist") {
            if var dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {                let recipesArray : [String] = (dict["RecipeName"] as? [String])!
                for i in 0 ..< recipesArray.count  {
                    recipesList.append(Recipes(
                        name:(dict["RecipeName"]![i] as? String)! ,
                        thumbnails:(dict["Thumbnail"]![i] as? String)!,
                        prepTime:(dict["PrepTime"]![i] as? String)!,
                        ingredients:(dict["Ingredients"]![i] as? Array<String>)!
                    ))
                }
                
                
//                recipes = (dict["RecipeName"] as? [String])!
//                thumbnails = (dict["Thumbnail"] as? [String])!
//                prepTime = (dict["PrepTime"] as? [String])!
            }
        }
        
        /*if let path = NSBundle.mainBundle().pathForResource("recipes", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                recipes = (dict["RecipeName"] as? [String])!
                thumbnails = (dict["Thumbnail"] as? [String])!
                prepTime = (dict["PrepTime"] as? [String])!
            }
        }*/
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredRecipes = recipesList.filter { recipe in
            return recipe.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredRecipes.count
        }
        return recipesList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipesCell", forIndexPath: indexPath)
        let recipe:Recipes
        if searchController.active && searchController.searchBar.text != "" {
            recipe = filteredRecipes[indexPath.row]
        }else{
            recipe = recipesList[indexPath.row]
        }
        cell.textLabel?.text=recipe.name
        cell.detailTextLabel?.text = "Prep time: "+recipe.prepTime
        cell.imageView?.image=UIImage(named: recipe.thumbnails)

        // Configure the cell...

        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 78;
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let recipeTitle = recipes[indexPath.row]
        let cell:UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        let alertController = UIAlertController(title: recipeTitle, message: recipeTitle+" is soo tasty", preferredStyle: UIAlertControllerStyle.Alert);
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in cell?.accessoryType = UITableViewCellAccessoryType.None}))
        self.presentViewController(alertController, animated: true, completion: nil)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }*/
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if searchController.active && searchController.searchBar.text != "" {
            let recipeRemoved = filteredRecipes.removeAtIndex(indexPath.row)
            print("recipeRemoved: \(recipeRemoved)")
            print("recipesList: \(recipesList)")
        }else{
            recipesList.removeAtIndex(indexPath.row)
        }
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showRecipeDetail"){
            let indexPath = self.tableView.indexPathForSelectedRow
            if let destViewController = segue.destinationViewController as? RecipesDetailViewController {
                let recipe:Recipes
                if searchController.active && searchController.searchBar.text != "" {
                    recipe = filteredRecipes[(indexPath?.row)!]
                }else{
                    recipe = recipesList[(indexPath?.row)!]
                }
                destViewController.recipes = recipe
            }
            
        }
    }
}
extension RecipesTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

