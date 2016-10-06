//
//  CoreDataDetailViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 15/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDetailViewController: UIViewController {
    var device : NSManagedObject?
    @IBOutlet weak var versionTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getManagedContext() -> NSManagedObjectContext{
        let appDeligate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDeligate.managedObjectContext
    }
    
    @IBAction func save(sender: AnyObject) {
        let managedContext = getManagedContext()
        if self.device != nil{
            device!.setValue(nameTextField.text, forKey: "name")
            device!.setValue(versionTextField.text, forKey: "version")
            device!.setValue(companyTextField.text, forKey: "company")
        }else{
            let entity = NSEntityDescription.entityForName("CoreData", inManagedObjectContext: managedContext)
            let newDevice = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            newDevice.setValue(nameTextField.text, forKey: "name")
            newDevice.setValue(versionTextField.text, forKey: "version")
            newDevice.setValue(companyTextField.text, forKey: "company")
        }
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Device:\(device?.valueForKey("name") as? String)")
        if self.device != nil{
            nameTextField.text = device?.valueForKey("name") as? String
            versionTextField.text = device?.valueForKey("version") as? String
            companyTextField.text = device?.valueForKey("company") as? String
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
