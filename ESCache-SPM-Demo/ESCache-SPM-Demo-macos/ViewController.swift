//
//  ViewController.swift
//  ESCache-SPM-Demo-macos
//
//  Created by 罗树新 on 2020/12/14.
//

import Cocoa
import ESCache

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        FileCache.cache.save("saveValue", for: "saveKey")
        let value = FileCache.cache.string(for: "saveKey")
        print(value ?? "")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

