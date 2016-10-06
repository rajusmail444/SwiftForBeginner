//
//  CameraViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 24/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func takePhoto(sender: UIButton) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let alertController = UIAlertController(title: "Error", message: "Device has no camera", preferredStyle: UIAlertControllerStyle.Alert);
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            let picker:UIImagePickerController = UIImagePickerController.init()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    @IBAction func selectPhoto(sender: UIButton) {
        let picker:UIImagePickerController = UIImagePickerController.init()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        self.imageView.image = chosenImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
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
