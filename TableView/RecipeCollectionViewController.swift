//
//  RecipeCollectionViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 17/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "Cell"

class RecipeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    var recipePhotos : Array<Array<String>>?
    var shareEnabled : Bool = false
    var selectedRecipes : Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        
        let mainDishImages : Array = ["egg_benedict.jpg", "full_breakfast.jpg", "ham_and_cheese_panini.jpg", "ham_and_egg_sandwich.jpg", "hamburger.jpg", "instant_noodle_with_egg.jpg", "japanese_noodle_with_pork.jpg", "mushroom_risotto.jpg", "noodle_with_bbq_pork.jpg", "thai_shrimp_cake.jpg", "vegetable_curry.jpg"]
        
        let drinkDessertImages : Array = ["angry_birds_cake.jpg", "creme_brelee.jpg", "green_tea.jpg", "starbucks_coffee.jpg", "white_chocolate_donut.jpg"]
        recipePhotos = [mainDishImages,drinkDessertImages]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let collcViewLayout : UICollectionViewFlowLayout = (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)!
        collcViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return recipePhotos!.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipePhotos![section].count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipePhotoCell", forIndexPath: indexPath)
        let recipeImageView : UIImageView = (cell.viewWithTag(100) as? UIImageView)!
        recipeImageView.image = UIImage(named: recipePhotos![indexPath.section][indexPath.row])
        cell.backgroundView = UIImageView(image: UIImage(named:"pic-frame.png"))
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: "pic_frame_selected.png"))
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView?
        if(kind == UICollectionElementKindSectionHeader){
            let headerView : RecipeCollectionHeaderView = (collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as? RecipeCollectionHeaderView)!
            headerView.title1.text = "Recipe Group \(indexPath.section + 1)"
            headerView.backgroundImage.image = UIImage(named: "header_banner.png")
            reusableview = headerView;
        }
        if(kind == UICollectionElementKindSectionFooter){
            let footerview : UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterView", forIndexPath: indexPath)
                reusableview = footerview
        }
        return reusableview!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showRecipePhoto"){
            let indexPaths:Array = (collectionView?.indexPathsForSelectedItems())!
            let destViewController:RecipeViewController = (segue.destinationViewController as? RecipeViewController)!;
            let indexPath = indexPaths[0]
            destViewController.recipeImageName = recipePhotos![indexPath.section][indexPath.row]
            collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if shareEnabled{
            let selectedRecipe : String = recipePhotos![indexPath.section][indexPath.row]
            selectedRecipes.append(selectedRecipe)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if shareEnabled{
            let deselectedRecipe : String = recipePhotos![indexPath.section][indexPath.row]
            for i in 0 ..< selectedRecipes.count{
                if deselectedRecipe == selectedRecipes[i]{
                    selectedRecipes.removeAtIndex(i)
                }
            }
        }
    }

    @IBAction func shareButtonTouched(sender: AnyObject) {
        if shareEnabled {
            if selectedRecipes.count > 0{
                if SLComposeViewController .isAvailableForServiceType(SLServiceTypeFacebook){
                    let controller : SLComposeViewController = SLComposeViewController.init(forServiceType: SLServiceTypeFacebook)
                    controller.setInitialText("My Recepe from Swift Code :)")
                    for recipePhoto in selectedRecipes{
                        controller.addImage(UIImage(named: recipePhoto))
                    }
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            }
            
            for indexPath in (self.collectionView?.indexPathsForSelectedItems())!{
                self.collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
            }
            
            selectedRecipes.removeAll()
            
            shareEnabled = false
            self.collectionView?.allowsMultipleSelection = false
            self.shareButton.title = "Share"
            self.shareButton.style = .Plain
        }else{
            shareEnabled = true
            self.collectionView?.allowsMultipleSelection = true
            self.shareButton.title = "Upload"
            self.shareButton.style = .Done
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if shareEnabled{
            return false
        }else{
            return true
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
