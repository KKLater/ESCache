//
//  AutoPurgeCache.swift
//  ESCache
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

#if TARGET_OS_IPHONE
import UIKit
/// 自动清理缓存
///
/// 在收到系统内容警告时，会自动清理掉内存缓存
public class AutoPurgeCache<String, ObjectType>: NSCache<AnyObject, AnyObject> where ObjectType : AnyObject {
    
    override init() {
        super.init()
        
        addNotification()
    }
    
    deinit { removeNotification() }
    
    private func addNotification() {
        removeNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllObjects), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    private func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
}

#else
import Foundation
public class AutoPurgeCache<String, ObjectType>: NSCache<AnyObject, AnyObject> where ObjectType : AnyObject {}
#endif
