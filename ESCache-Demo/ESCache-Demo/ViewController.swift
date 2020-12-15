//
//  ViewController.swift
//  ESCache-Demo
//
//  Created by 罗树新 on 2020/12/10.
//
//  Copyright (c) 2020 Later<lshxin89@126.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import ESCache

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FileCache.cache.save("saveValue", for: "saveKey")
        let value = FileCache.cache.string(for: "saveKey")
        print(value ?? "")
        
        let codableObject = CodableObject(name: "name", age: 17)
        let saveSuccess = FileCache.cache.save(codableObject, for: "v6/portal?name=name&age=17")
        if saveSuccess == true {
            let obj = FileCache.cache.codable(for: "v6/portal?name=name&age=17", type: CodableObject.self)
            print(obj)
        }
    }


}


struct CodableObject: Codable {
    var name: String?
    var age: Int?
    
    init(name: String?, age: Int?) {
        self.name = name
        self.age = age
    }
}
