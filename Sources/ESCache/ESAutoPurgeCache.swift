//
//  ESAutoPurgeCache.swift
//  ESCache
//
//  Created by 罗树新 on 2020/12/9.
//

#if TARGET_OS_IPHONE
import UIKit
/// 自动清理缓存
///
/// 在收到系统内容警告时，会自动清理掉内存缓存
public class ESAutoPurgeCache<String, ObjectType>: NSCache<AnyObject, AnyObject> where ObjectType : AnyObject {
    
    override init() {
        super.init()
        
        addNotification()
    }
    
    deinit {
        removeNotification()
    }
    
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
