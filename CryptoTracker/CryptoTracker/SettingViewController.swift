//
//  SettingViewController.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 12/6/21.
//

import UIKit

class SettingViewController: UIViewController {

    var lightOn = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func colorSwitch(_ sender: UISwitch) {
        lightOn = !lightOn
        if lightOn{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        else{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }
}



