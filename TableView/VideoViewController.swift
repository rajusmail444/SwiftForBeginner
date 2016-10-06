//
//  VideoViewController.swift
//  TableView
//
//  Created by Rajesh Billakanti on 26/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class VideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var videoURL : NSURL?
    var videoController : AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func captureVideo(sender: AnyObject) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let picker = UIImagePickerController.init()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeMovie as String]
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
        [picker .dismissViewControllerAnimated(true, completion: nil)]
        
        self.videoController = AVPlayerViewController.init()
        let player = AVPlayer(URL: self.videoURL!)
        self.videoController?.player = player
        self.videoController?.view.frame = CGRectMake(0, 0, 320, 460)
        self.view.addSubview((self.videoController?.view)!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(videoPlayBackDidFinish) , name: AVPlayerItemDidPlayToEndTimeNotification, object: self.videoController)
        player.play()
        
    }
    
    func videoPlayBackDidFinish(notification:NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        self.videoController?.player?.pause()
        self.videoController?.player = nil
        self.videoController = nil
        self.videoController?.view.removeFromSuperview()
        let alertController = UIAlertController(title: "Video Playback", message: "Just finished the video playback. The video is now removed.", preferredStyle: UIAlertControllerStyle.Alert);
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
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
