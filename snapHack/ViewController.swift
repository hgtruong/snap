//
//  ViewController.swift
//  snapHack
//
//  Created by Huy Truong on 7/7/16.
//  Copyright © 2016 Huy Truong. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickFromGallergy: UIButton!
    
    @IBAction func pickFromGallery(sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })
    }
    
    func addEmoji(){
        let detector = CIDetector(
            ofType: CIDetectorTypeFace,
            context: nil,
            options: [ CIDetectorAccuracy: CIDetectorAccuracyHigh ]
        )
        
        let faces = detector.featuresInImage(
            CIImage(image: imageView.image!)!,
            options: [ CIDetectorSmile: true ]
            ) as! [CIFaceFeature]
        
        for face in faces {
            print(face.bounds)
//            let blackView = UIView(frame: face.bounds)
//            blackView.backgroundColor = UIColor.blackColor()
//            imageView.addSubview(blackView)
            let calloutView = UIButton(frame: face.bounds)
            let text = face.hasSmile ? "😀" : "😐"
            calloutView.titleLabel!.font = UIFont.systemFontOfSize(200)
            calloutView.setTitle(text, forState: UIControlState.Normal)
            
            imageView.addSubview(calloutView)
            
        }
    }
    
    
    @IBOutlet weak var pickFromCamera: UIButton!
    
    @IBAction func pickFromCamera(sender: AnyObject) {
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })

        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            imageView.contentMode = .ScaleAspectFit
            addEmoji()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

