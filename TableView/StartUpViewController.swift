//
//  StartUpViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 01/10/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = []
    var pageImages : Array<String>  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitles = ["Over 200 Tips and Tricks", "Discover Hidden Features", "Bookmark Favorite Tip", "Free Regular Update"];
        pageImages = ["page1.png", "page2.png", "page3.png", "page4.png"];
        
        
        self.pageViewController = UIStoryboard(name: "StartUp", bundle: nil).instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        self.pageViewController?.dataSource = self
        
        let startingViewController : PageContentViewController = self.viewControllerAtIndex(0)
        let viewControllers : Array = [startingViewController]
        self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.pageViewController?.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-70)
        self.addChildViewController(pageViewController!)
        self.view.addSubview((pageViewController?.view)!)
        self.pageViewController?.didMoveToParentViewController(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        guard var index = (viewController as! PageContentViewController).pageIndex else{
            return nil;
        }
        
        if index == 0{
            return nil
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! PageContentViewController).pageIndex else{
            return nil;
        }
        
        index += 1
        
        if index == pageTitles.count{
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index : Int) -> PageContentViewController{
        let pageContentViewController : PageContentViewController = UIStoryboard(name: "StartUp", bundle: nil).instantiateViewControllerWithIdentifier("PageContentController") as! PageContentViewController
        pageContentViewController.imageFile = self.pageImages[index]
        pageContentViewController.titleText = self.pageTitles[index]
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController)->Int{
        return pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    @IBAction func startWalkthrough(sender: AnyObject) {
        let startingViewController : PageContentViewController = self.viewControllerAtIndex(0)
        let viewControllers : Array = [startingViewController]
        self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    
    @IBAction func skipWalkthroughAndMoveToApp(sender: AnyObject) {
        let mainNavigationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigationViewController")
        presentViewController(mainNavigationViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func showHamburgerMenu(sender: AnyObject) {
        let fbMainViewController = UIStoryboard(name: "FBMain", bundle: nil).instantiateViewControllerWithIdentifier("SWRevealViewController")
        presentViewController(fbMainViewController, animated: true, completion: nil)
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
