//
//  InterfaceController.swift
//  ESCache-SPM-Demo-watchos WatchKit Extension
//
//  Created by 罗树新 on 2020/12/14.
//

import WatchKit
import Foundation
import ESCache

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        FileCache.cache.save("saveValue", for: "saveKey")
        let value = FileCache.cache.string(for: "saveKey")
        print(value ?? "")

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
