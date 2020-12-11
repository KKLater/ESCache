# ESCache

----

[TOC]

----

[ESCache](https://github.com/KKLater/ESCache) 是对常用缓存方案的封装，意在提供方便的内存管理、磁盘存储管理方案。

## 开始使用

### 要求

* Swift 5.0

### 安装

#### Swift Package Manager (推荐)

```swift
package.dependencies += [
    .package(url: "https://github.com/KKLater/ESCache.git", from: "0.0.1"),
]
```

#### Cocoapods

```sh
pod 'ESCache', "~> 0.0.1"
```

### 使用

#### 内存存取

##### 单例存取

可以直接使用 `ESMemoryCache` 的 `default` 单例进行存取。

```swift
let str = "save string object"
let key = "saveKey"

let success = ESMemoryCache.default.save(str, for: key)
let value = ESMemoryCache.default.string(for: key)
```



##### 实例存取

也可以创建 [ESMemoryCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/ESMemoryCache.swift) 实例进行存取。

```swift
let str = "save string object"
let key = "saveKey"

let cache = ESMemoryCache(name: "creat")
let success = cache.save(str, for: key)
let value = cache.string(for: key)
```

需要注意的是实例的创建需要一个缓存名称命名，如果没有设置名称，则创建的缓存实例名称与 `default` 单例一致。

#### 文件存取

##### 单例

可以直接使用 [ESFileCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/ESFileCache.swift) 的相关实例进行存取，`ESFileCache` 提供了以下单例。

```swift
// 默认单例，等价于 cache
public static let `default`: ESCache.ESFileCache

// cache 单例，文件存储位置为系统 cache 文件夹
public static let cache: ESCache.ESFileCache

// document 单例，文件存储位置为系统 documnet 文件夹
public static let document: ESCache.ESFileCache

// download 单例，文件存储位置为系统 download 文件夹
public static let download: ESCache.ESFileCache

// libraby 单例，文件存储位置为系统 libraby 文件夹
public static let libraby: ESCache.ESFileCache

// temp 单例，在 `iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0` 以上系统版本，文件存储在 temp 文件路径，其他版本存储在 `cache` 路径
public static let temp: ESCache.ESFileCache

```

##### 单例存取

```swift
let str = "save string object"
let key = "saveKey"

let success = ESFileCache.default.save(str, for: key)
let value = ESFileCache.default.string(for: key)
```

##### 实例存取

与 [ESMemoryCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/ESMemoryCache.swift) 一致，[ESFileCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/ESFileCache.swift) 也提供了自定义文件路径存取的方案。

```swift  
let str = "save string object"
let key = "saveKey"

let cache = ESFileCache(name: "private", directory: .cache)
let success = cache.save(str, for: key)
let value = cache.string(for: key)
```

实例创建时提供的 `name` 和 `directory` 构成文件存储路径。

### 其他



[ESCacheable](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/ESCacheable.swift) 协议提供了基础缓存方案，即存取 `data`。在此基础上如果需要储存其他类型对象，可以通过针对 `ESCacheable` 协议做方法扩展。例如已经提供的存储字符串和存储满足 `NSSecureCoding` 协议的实例对象的方案。

```swift
public func string(for key: String) -> String?
public func save(_ string: String, for key: String, expires: Date? = nil) -> Bool


public func object(for key: String) -> Any? 
public func save<T>(_ object: T, for key: String, expires: Date? = nil) -> Bool where T : NSObject, T : NSSecureCoding 
```



[ESAutoPurgeCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/ESAutoPurgeCache.swift) 在 `UIKit` 框架下，在接收到系统内存警告的时候，会自动执行 `removeAllObjects` 清理内存。

## 许可协议

[ESCache](https://github.com/KKLater/ESCache) 以 MIT 协议发布. 查看 [LICENSE](https://github.com/KKLater/ESCache/blob/main/LICENSE) 获取更多信息.

