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
    
    var captureDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
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
    
    func beginSession(){
        var err: NSError? = nil
        
        //captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
           print("error: ")
        }
        
    
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

