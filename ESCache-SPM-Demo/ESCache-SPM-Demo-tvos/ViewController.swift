//
//  ViewController.swift
//  ESCache-SPM-Demo-tvos
//
//  Created by 罗树新 on 2020/12/14.
//

import UIKit
import ESCache

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FileCache.cache.save("saveValue", for: "saveKey")
        let value = FileCache.cache.string(for: "saveKey")
        print(value ?? "")
    }


}

