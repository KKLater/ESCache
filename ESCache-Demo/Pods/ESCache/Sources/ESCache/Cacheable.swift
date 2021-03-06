//
//  Cacheable.swift
//  Cache
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

import Foundation

#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public protocol Cacheable {
    
    /// 缓存 Data 数据
    /// - Parameters:
    ///   - data: 缓存数据
    ///   - key: 缓存键值
    ///   - expires: 过期时间
    @discardableResult
    func save(_ data: Data, for key: String, expires: Date?) -> Bool
    
    /// 查询缓存数据
    /// - Parameter key: 缓存键值
    /// 
    /// 如果根据键值查询到数据，但是数据设置过期时间并已经过期，则会清理到缓存数据，查询为空
    /// 如果根据键值查询到数据，数据没有设置过期时间或者设置过期时间有效期内，则查询成功
    func data(for key: String) -> Data?
    
    /// 是否已经缓存了数据
    /// - Parameter key: 缓存键值
    ///
    /// 如果数据已经缓存，并且设置了过期时间，则会清理掉缓存缓存无效
    /// 如果数据已经缓存，没有设置过期时间，则缓存有效
    func exists(for key: String) -> Bool
    
    /// 清理掉缓存数据
    /// - Parameter key: 缓存键值
    @discardableResult
    func removeObject(for key: String) -> Bool
    
    /// 清理掉所有缓存，并重建缓存
    func removeAllObjects()
}

extension Cacheable {
    
    /// 字符串缓存
    /// - Parameters:
    ///   - string: 字符串数据
    ///   - key: 缓存键值
    ///   - expires: 过期时间
    /// - Returns: 是否缓存成功
    @discardableResult
    public func save(_ string: String, for key: String, expires: Date? = nil) -> Bool {
        guard let data = string.data(using: .utf8) else { return false }
        return save(data, for: key, expires: expires)
    }
    
    /// 查询缓存的字符串
    /// - Parameter key: 缓存键值
    /// - Returns: 缓存的数据
    ///
    /// 如果根据键值查询到数据，但是数据设置过期时间并已经过期，则会清理到缓存数据，查询为空
    /// 如果根据键值查询到数据，数据没有设置过期时间或者设置过期时间有效期内，则查询成功
    public func string(for key: String) -> String? {
        guard let data = data(for: key), let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
    }
    
    #if !os(macOS)
    
    /// 存储图片
    /// - Parameters:
    ///   - image: 图片
    ///   - key: 缓存键值
    ///   - expires: 过期时间
    /// - Returns: 是否缓存成功
    @discardableResult
    public func save(_ image: UIImage, for key: String, expires: Date? = nil) -> Bool {
        guard let data = image.pngData() else { return false }
        return save(data, for: key, expires: expires)
    }
    
    /// 图片获取
    /// - Parameter key: 缓存键值
    /// - Returns: 查询缓存的图片
    public func image(for key: String) -> UIImage? {
        guard let data = data(for: key), let img = UIImage(data: data) else {
            return nil
        }
        return img
    }
    
    #else
    
    /// 存储图片
    /// - Parameters:
    ///   - image: 图片
    ///   - key: 缓存键值
    ///   - expires: 过期时间
    /// - Returns: 是否缓存成功
    @discardableResult
    public func save(_ image: NSImage, for key: String, expires: Date? = nil) -> Bool {
        guard let data = image.tiffRepresentation else { return false }
        return save(data, for: key, expires: expires)
    }
    
    /// 图片获取
    /// - Parameter key: 缓存键值
    /// - Returns: 查询缓存的图片
    public func image(for key: String) -> NSImage? {
        guard let data = data(for: key), let img = NSImage(data: data) else {
            return nil
        }
        return img
    }
    #endif
}

extension Cacheable {
 
    /// 对象缓存
    /// - Parameters:
    ///   - object: 对象数据，必须继承于 NSObject 并且实现 NSSecureCoding
    ///   - key: 缓存键值
    ///   - expires: 过期时间
    /// - Returns: 是否缓存成功
    @discardableResult
    public func save<T>(_ object: T, for key: String, expires: Date? = nil) -> Bool where T : NSObject, T : NSSecureCoding  {
        if #available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *) {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: T.supportsSecureCoding) else { return false }
            return save(data, for: key, expires: expires)
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: object)
            return save(data, for: key, expires: expires)
        }
    }
    
    /// 查询缓存的对象数据
    /// - Parameter key: 缓存键值
    /// - Returns: 缓存的数据
    ///
    /// 如果根据键值查询到数据，但是数据设置过期时间并已经过期，则会清理到缓存数据，查询为空
    /// 如果根据键值查询到数据，数据没有设置过期时间或者设置过期时间有效期内，则查询成功
    public func object(for key: String) -> Any?  {
        guard let data = data(for: key), let obj = NSKeyedUnarchiver.unarchiveObject(with: data) else {
            return nil
        }
        return obj
    }
}

extension Cacheable {
    
    /// 对象缓存
    /// - Parameters:
    ///   - object: 对象数据
    ///   - key: 缓存键值
    ///   - expires: 过期时间
    /// - Returns: 是否缓存成功
    @discardableResult
    public func save<T: Codable>(_ codable: T, for key: String, expires: Date? = nil) -> Bool {
        guard let data =  try? JSONEncoder().encode(codable) else {
            return false
        }
        return save(data, for: key, expires: expires)
    }
    
    /// 查询缓存的对象数据
    /// - Parameter key: 缓存键值
    /// - Returns: 缓存的数据
    ///
    /// 如果根据键值查询到数据，但是数据设置过期时间并已经过期，则会清理到缓存数据，查询为空
    /// 如果根据键值查询到数据，数据没有设置过期时间或者设置过期时间有效期内，则查询成功
    public func codable<T: Decodable>(for key: String, type: T.Type) -> T? {
        guard let data = data(for: key), let obj = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return obj
    }
}
