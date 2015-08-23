//
//  ViewController.swift
//  AVFoundationQRcode
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see
//  http:/www.gnu.org/licenses/.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var previewView: UIView!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession : AVCaptureSession!
    var metadataOutput: AVCaptureMetadataOutput!
    var videoDevice:AVCaptureDevice!
    var videoInput: AVCaptureDeviceInput!
    var running = false
    
    var sendURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCaptureSession() 
        previewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "startRunning:", name:UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopRunning:", name:UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRunning(){
        captureSession.startRunning()
        metadataOutput.metadataObjectTypes =
            metadataOutput.availableMetadataObjectTypes
        running = true
    }
    func stopRunning(){
        captureSession.stopRunning()
        running = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startRunning()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopRunning()
    }
    
    func setupCaptureSession(){
        
        if(captureSession != nil){
            return
        }
        videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if(videoDevice == nil){
            println("No camera on this device")
        }
        captureSession = AVCaptureSession()
        videoInput = AVCaptureDeviceInput.deviceInputWithDevice(videoDevice, error: nil) as! AVCaptureDeviceInput
        
        if(captureSession.canAddInput(videoInput)){
            captureSession.addInput(videoInput)
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        metadataOutput = AVCaptureMetadataOutput()
        var metadataQueue = dispatch_queue_create("com.example.QRCode.metadata", nil)
        metadataOutput.setMetadataObjectsDelegate(self, queue: metadataQueue)
        
        if(captureSession.canAddOutput(metadataOutput)){
            captureSession.addOutput(metadataOutput)
        } }
    
    func captureOutput(captureOutput: AVCaptureOutput!,
        didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection
        connection: AVCaptureConnection!) {
            var elemento = metadataObjects.first as?
            AVMetadataMachineReadableCodeObject
            if(elemento != nil){
                println(elemento!.stringValue)
                sendURL = elemento!.stringValue

            }
    }
    

    
}



