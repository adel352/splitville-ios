//
//  CameraViewController.swift
//  SplitVille
//
//  Created by Nabil Maadarani on 2016-02-27.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var stillImageView: UIImageView!
    
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var declineButton: UIButton?
    var acceptButton: UIButton?

    @IBOutlet weak var cameraToolbarView: UIView!
    @IBOutlet weak var cameraIconView: UIView!
    @IBOutlet weak var cameraCircleView: CameraIconCircle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.captureSession.sessionPreset = AVCaptureSessionPresetMedium
        let devices = AVCaptureDevice.devices()
        
        devices.forEach {
            if $0.hasMediaType(AVMediaTypeVideo) {
                if $0.position == AVCaptureDevicePosition.Back {
                    self.captureDevice = $0 as? AVCaptureDevice
                    if self.captureDevice != nil {
                        print("Found device: \(self.captureDevice)")
                        self.beginSession()
                    }
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        guard let previewLayer = self.previewLayer else { return }
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.bounds = self.cameraView.bounds
        previewLayer.position = CGPointMake(CGRectGetMidX(self.cameraView.bounds), CGRectGetMidY(self.cameraView.bounds))
        self.cameraView.layer.addSublayer(previewLayer)
        self.captureSession.startRunning()
        
        // Make menu button rounded
        self.menuView.layer.cornerRadius = self.menuView.bounds.width / 2
        self.menuView.layer.masksToBounds = true
        // Make camera icon rounded
        self.cameraIconView.layer.cornerRadius = self.cameraIconView.bounds.width / 2
        self.cameraIconView.layer.masksToBounds = true
        
        let fingerTap = UITapGestureRecognizer(target: self, action: "cameraButtonTapped:")
        self.cameraCircleView.addGestureRecognizer(fingerTap)
    }
    
    func cameraButtonTapped(recognizer: UIGestureRecognizer) {
        var videoConnection: AVCaptureConnection?
        self.stillImageOutput?.connections.forEach {connection in
            guard let inputPortsArray = connection.inputPorts as? NSArray else { return }
            inputPortsArray.forEach {
                if $0.mediaType == AVMediaTypeVideo {
                    videoConnection = connection as? AVCaptureConnection
                    return
                }
            }
            if videoConnection != nil {
                return
            }
        }
        print("About to request capture from \(self.stillImageOutput)")
        self.stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection) { (imageSampleBuffer, error) -> Void in
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
            let image = UIImage(data: imageData)
            self.refreshInterfaceForStillImage(image)
        }
    }
    
    func declineButtonTapped(sender: AnyObject) {
        refreshInterfaceForCamera()
    }
    
    func acceptButtonTapped(sender: AnyObject) {
        
    }
    
    func refreshInterfaceForStillImage(image: UIImage?) {
        self.cameraView.hidden = true
        self.menuView.hidden = true
        
        self.stillImageView.hidden = false
        self.stillImageView.image = image
        
        // Add bottom buttons
        self.declineButton = UIButton(frame: CGRect(x: 0, y: 0,
            width: self.cameraToolbarView.bounds.width / 2, height: self.cameraToolbarView.bounds.height))
        self.declineButton?.addTarget(self, action: "declineButtonTapped:", forControlEvents: .TouchUpInside)
        guard let declineButton = self.declineButton else { return }
        declineButton.backgroundColor = UIColor.redColor()
        self.cameraToolbarView.addSubview(declineButton)
       
        self.acceptButton = UIButton(frame: CGRect(x: self.cameraToolbarView.bounds.width / 2, y: 0,
            width: self.cameraToolbarView.bounds.width / 2, height: self.cameraToolbarView.bounds.height))
        self.acceptButton?.addTarget(self, action: "acceptButtonTapped:", forControlEvents: .TouchUpInside)
        guard let acceptButton = self.acceptButton else { return }
        acceptButton.backgroundColor = UIColor.greenColor()
        self.cameraToolbarView.addSubview(acceptButton)
        
        // Add images to buttons
        let declineImage = UIImageView(image: UIImage(named: "cancel"))
        declineButton.addSubview(declineImage)
        declineImage.frame = CGRect(x: declineImage.bounds.origin.x, y: declineImage.bounds.origin.y,
            width: declineButton.bounds.width / 3, height: 2/3 * declineButton.bounds.height)
        declineImage.center = self.declineButton!.center

        
        let acceptImage = UIImageView(image: UIImage(named: "accept"))
        acceptButton.addSubview(acceptImage)
        acceptImage.frame = CGRect(x: acceptButton.bounds.width / 2 - acceptImage.bounds.width / 3,
            y: acceptButton.bounds.height / 8,
            width: acceptButton.bounds.width / 2, height: 3/4 * acceptButton.bounds.height)
    }
    
    func refreshInterfaceForCamera() {
        self.cameraView.hidden = false
        self.menuView.hidden = false
        
        self.stillImageView.hidden = true
        
        // Remove bottom buttons
        self.declineButton?.removeFromSuperview()
        self.acceptButton?.removeFromSuperview()
    }
    
    func beginSession() {
        do {
            try self.captureSession.addInput(AVCaptureDeviceInput(device: self.captureDevice))
            
            self.stillImageOutput = AVCaptureStillImageOutput()
            self.stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            self.captureSession.addOutput(self.stillImageOutput)
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        } catch {
            print("Failed to add input device")
        }
    }

    let screenWidth = UIScreen.mainScreen().bounds.size.width
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPercent = touch.locationInView(self.cameraView).x / self.screenWidth
        focusTo(Float(touchPercent))
    }
    
    func focusTo(value : Float) {
        guard let device = self.captureDevice else { return }
        do {
            try device.lockForConfiguration()
        } catch {
            print("Can't lock")
        }
        device.setFocusModeLockedWithLensPosition(value, completionHandler: nil)
        device.unlockForConfiguration()
    }
}
