//
//  ViewController.swift
//  ESCache-Demo-tvos
//
//  Created by 罗树新 on 2020/12/10.
//

import UIKit
import ESCache

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ESFileCache.cache.save("saveValue", for: "saveKey")
        let value = ESFileCache.cache.string(for: "saveKey")
        print(value?)
    }


}

