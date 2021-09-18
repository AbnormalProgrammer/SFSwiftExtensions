//
//  ViewController.swift
//  Demo
//
//  Created by Stroman on 2021/7/20.
//

import UIKit
import SFSwiftExtensions

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(CGFloat.randomPercentage())
        print("123.456".isPhoneNumber())
    }
}

