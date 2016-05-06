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
        title = "扫一扫"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        view.addSubview(navBar)
        startScanning()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navBar.removeFromSuperview()
        navigationController?.navigationBar.hidden = false
    }

    
    //MARK: - Private
    
    private lazy var navBar: UINavigationBar = {
        let bar = UINavigationBar(frame: CGRectMake(0 ,0 , UIScreen.mainScreen().bounds.size.width,64))
        bar.barTintColor = UIColor(white: 0.0, alpha: 0.2)
        
        let titleItem = UINavigationItem()
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(18)
        titleLabel.text = "扫一扫"
        titleLabel.textColor = UIColor.whiteColor()
        titleItem.titleView = titleLabel
        titleLabel.sizeToFit()
        bar.pushNavigationItem(titleItem, animated: true)
        
        return bar
    }()
    
    private func startScanning() {
        if !session.canAddInput(deviceInput) {
            return
        }
        if !session.canAddOutput(metaDataOutput) {
            return
        }
        session.addInput(deviceInput)
        session.addOutput(metaDataOutput)
        
        metaDataOutput.metadataObjectTypes = metaDataOutput.availableMetadataObjectTypes
        metaDataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        view.layer.insertSublayer(preivewLayer, atIndex: 0)
        
        session.startRunning()
    }
    
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
    
    private lazy var preivewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        return layer
    }()

    
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        print(metadataObjects)
    }
}
