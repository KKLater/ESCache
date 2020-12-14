//
//  ESFileLibraryTests.swift
//
//
//  Created by 罗树新 on 2020/12/9.
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

#if !os(watchOS)
import XCTest
@testable import ESCache

final class ESFileLibraryTests: XCTestCase {
    func testStringCache() {
        let str = "save string object"
        let key = "saveKey"
        
        
        let success = FileCache.libraby.save(str, for: key)
        XCTAssertEqual(success, true, "字符串保存失败")
        let value = FileCache.libraby.string(for: key)
        XCTAssertEqual(value, str, "字符串取出失败")
    }
    
    func testObjectCache() {
        @objc(_TtCFC10CacheTests14FileCacheTests15testObjectCacheFT_T_L_3Obj)class Obj: NSObject, NSSecureCoding {
            static var supportsSecureCoding: Bool = true
            
            func encode(with coder: NSCoder) {
                coder.encode(name, forKey: "name")
                coder.encode(age, forKey: "age")
            }
            
            required init?(coder: NSCoder) {
                self.name = coder.decodeObject(forKey: "name") as? String
                self.age = coder.decodeInteger(forKey: "age")
            }
            
            var name: String? = "name"
            var age = 17
            
            override init() {
                
            }
            
            override func isEqual(_ object: Any?) -> Bool {
                guard let o = object as? Obj else {
                    return false
                }
                
                if self.age != o.age {
                    return false
                }
                if o.name == nil && self.name == nil {
                    return true
                }
                
                if o.name != nil && self.name != nil && o.name == self.name {
                    return true
                }
                
                return false
            }
        }
        let key = "obj"
        let obj = Obj()
        let success = FileCache.libraby.save(obj, for: key)
        XCTAssertEqual(success, true, "对象保存失败")
        if let o = FileCache.libraby.object(for: key) as? Obj {
            XCTAssertEqual(o, obj, "对象取出失败")
        }
    }
    
    func testExisit() {
        let str = "save string object"
        let key = "saveKey"
        let success = FileCache.libraby.save(str, for: key)
        XCTAssertEqual(success, true, "字符串保存失败")
        let exisit = FileCache.libraby.exists(for: key)
        XCTAssertEqual(exisit, true, "校验存储失败")
    }
    
    func testInExpiresCache() {
        let str = "save string object"
        let key = "saveKey"
        let success = FileCache.libraby.save(str, for: key, expires: Date(timeIntervalSinceNow: 5))
        XCTAssertEqual(success, true, "字符串保存失败")
        let promise4 = expectation(description: "Just wait 4 seconds")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(4)) {
            promise4.fulfill()
            let exisit = FileCache.libraby.exists(for: key)
            XCTAssertEqual(exisit, true, "校验存储失败")
            let newValue = FileCache.libraby.string(for: key)
            XCTAssertEqual(newValue, str, "数据到期前有效校验失败")
        }
        waitForExpectations(timeout: 5) { (error) in
        }
    }
    
    func testOutExpiresCache() {
        let str = "save string object"
        let key = "saveKey"
        let success = FileCache.libraby.save(str, for: key, expires: Date(timeIntervalSinceNow: 5))
        XCTAssertEqual(success, true, "字符串保存失败")
        let promise6 = expectation(description: "Just wait 6 seconds")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(6)) {
            promise6.fulfill()
            let exisit = FileCache.libraby.exists(for: key)
            XCTAssertEqual(exisit, false, "校验存储失败")
            let newValue = FileCache.libraby.string(for: key)
            XCTAssertNil(newValue, "数据到期后无效校验失败")
        }
        waitForExpectations(timeout: 6) { (error) in
        }
    }
    
    static var allTests = [
        ("字符串存取测试", testStringCache),
        ("对象存取测试", testObjectCache),
        ("是否有缓存数据校验测试", testExisit),
        ("存储未过期测试", testInExpiresCache),
        ("存储过期测试", testOutExpiresCache),
    ]
}
#endif
