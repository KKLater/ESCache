//
//  ViewController.swift
//  ESCache-Demo-macos
//
//  Created by 罗树新 on 2020/12/10.
//

import Cocoa
import ESCache

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ESFileCache.cache.save("saveValue", for: "saveKey")
        let value = ESFileCache.cache.string(for: "saveKey")
        print(value?)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

