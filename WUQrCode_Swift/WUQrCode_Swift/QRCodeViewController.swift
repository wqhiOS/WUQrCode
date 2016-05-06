//
//  QRCodeViewController.swift
//  WUQrCode_Swift
//
//  Created by wuqh on 16/5/6.
//  Copyright © 2016年 wuqh. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startScanning()
    }
    
    //MARK: - Private
    private func startScanning() {
        if !session.canAddInput(deviceInput) {
            return
        }
        if !session.canAddOutput(metaDataOutput) {
            return
        }
        session.addInput(deviceInput)
        session.canAddOutput(metaDataOutput)
        
        metaDataOutput.metadataObjectTypes = metaDataOutput.availableMetadataObjectTypes
        metaDataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        session.startRunning()
        
    }

    //MARK: - 懒加载
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch {
            print(error)
            return nil
        }
        
        
    }()
    
    private lazy var metaDataOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        print(metadataObjects)
    }
}
