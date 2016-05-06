//
//  ViewController.swift
//  WUQrCode_Swift
//
//  Created by wuqh on 16/5/6.
//  Copyright © 2016年 wuqh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scan(sender: AnyObject) {
        navigationController?.pushViewController(QRCodeViewController(), animated: true)
    }
   
}

