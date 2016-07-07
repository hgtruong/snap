//
//  ViewController.swift
//  snapHack
//
//  Created by Huy Truong on 7/7/16.
//  Copyright © 2016 Huy Truong. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController{
    
    let captureSession = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer?()
    
    var captureDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()
        
        for device in devices{
            if(device.hasMediaType(AVMediaTypeVideo)){
                if(device.position == AVCaptureDevicePosition.Back){
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice != nil {
                beginSession()
        }
    }
    
    ///////////////////////Begin Session Function/////////////////////////////
    func beginSession(){
        
        configureDevice()
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
           print("error: ")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
   
    ///////////////////////Configure Device Function/////////////////////////////
    func configureDevice(){
        if let device = captureDevice{
            do {
                try device.lockForConfiguration()
                device.focusMode = .Locked
                device.unlockForConfiguration()
            } catch {
                
            }
            
        }
    }
    
    /////////////////////////////focus To Function/////////////////////////////
    func focusTo(value: Float){
        if let device = captureDevice{
            
            do{
                _ = try device.lockForConfiguration()
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                })
                
                
            } catch {
                print("err")
            }
            device.unlockForConfiguration()
        }
    }
    
    ////////////////////////////Function/////////////////////////////
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch = touches.first! as UITouch
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
  
    
    ////////////////////////////Function/////////////////////////////
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch = touches.first! as UITouch
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    

    ////////////////////////////Function/////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

