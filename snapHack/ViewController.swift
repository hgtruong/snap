//
//  ViewController.swift
//  snapHack
//
//  Created by Huy Truong on 7/7/16.
//  Copyright © 2016 Huy Truong. All rights reserved.
//

import UIKit
import CoreImage
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickFromGallergy: UIButton!
    
    
    var emojiArray : [UIButton] = []
    
    @IBAction func pickFromGallery(sender: AnyObject) {
        for emoji in emojiArray {
            emoji.removeFromSuperview()
        }
        emojiArray.removeAll()
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })
    }
    
    
    var player: AVAudioPlayer?
    
    func playSound() {
        let url = NSBundle.mainBundle().URLForResource("Sitcom laughing #2", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
            print("lel")
        }
    }
    
    func addEmoji(){
        let ciImage  = CIImage(CGImage:imageView.image!.CGImage!)
        let detector = CIDetector(
            ofType: CIDetectorTypeFace,
            context: nil,
            options: [ CIDetectorAccuracy: CIDetectorAccuracyHigh ]
        )
        
        let faces = detector.featuresInImage(
            ciImage,
            options: [ CIDetectorSmile: true ]
            ) as! [CIFaceFeature]
//        print("inside addEmoji and faces.length is :\(faces.count)")
        
//        let features = detector.featuresInImage(ciImage)
        
        
        
        
        UIGraphicsBeginImageContext(imageView.image!.size)
        imageView.image!.drawInRect(CGRectMake(0,0,imageView.image!.size.width,imageView.image!.size.height))
        
        for face in faces {
            print(face.bounds)
            
            //context
            //let drawCtxt = UIGraphicsGetCurrentContext()
            
            
            
            
//            print(resized)
//            
//            let blackView = UIView(frame: face.bounds)
//            blackView.backgroundColor = UIColor.blackColor()
//            self.view.addSubview(blackView)
//
//            let times = face.bounds.width / imageView.frame.width
//            let width = face.bounds.width / times
//            let width = resized.size.width
//
//            let heightTimes = face.bounds.height / imageView.frame.height
//            let height = face.bounds.height / heightTimes
//            let height = resized.size.height
//
//            let xTimes = face.bounds.origin.x /  imageView.frame.origin.x
//            let x = face.bounds.origin.x / xTimes
           // let x  = resized.siz
            
//            
//            let yTimes = face.bounds.origin.y / imageView.frame.origin.y
//            let y = face.bounds.origin.y / yTimes
            //let y = face.bounds.origin.y
            
          
            
            
            var rect = face.bounds
            
            rect.origin.y = imageView.image!.size.height - rect.origin.y - rect.size.height
            
//            let calloutView = UIButton(frame: rect)
//            let text = face.hasSmile ? "😀" : "😐"
//            calloutView.titleLabel!.font = UIFont.systemFontOfSize(face.bounds.width)
//            calloutView.setTitle(text, forState: UIControlState.Normal)
            
            var calloutView:UIImage!
            
            if face.hasSmile {
                calloutView = UIImage(named:"asdfasdf.png")
                playSound()
            } else {
                calloutView = UIImage(named:"expressionless.png")
            }
            
            
            calloutView!.drawInRect(rect)
            
            
//            CGContextStrokeRect(drawCtxt,rect)
//            self.imageView.addSubview(calloutView)
            
//            self.emojiArray.append(calloutView)
            
            
            
        }
        let drawedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = drawedImage
    }
    /////////////////////////////RESIZE FUNC/////////////////////////\
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        print("in resize functon")
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    @IBOutlet weak var pickFromCamera: UIButton!
    
    @IBAction func pickFromCamera(sender: AnyObject) {
        for emoji in emojiArray {
            emoji.removeFromSuperview()
        }
        emojiArray.removeAll()
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })

        
    }

    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let resized = self.ResizeImage(pickedImage, targetSize: CGSizeMake(self.imageView.frame.width, self.imageView.frame.height))
            imageView.image = resized
            imageView.contentMode = .ScaleAspectFit
            
            print("get image")
            addEmoji()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

