# ESCache

----

* [开始使用](#开始使用) 
    * [要求](#要求)
    * [安装](#安装)
        * [Swift Package Manager](#SwiftPackageManager)
        * [Cocoapods](#Cocoapods)
    * [使用](#使用)
        * [内存存取](#内存存取)
        * [文件存取](#文件存取)
* [其他](#其他)
* [许可协议](#许可协议)

----

[ESCache](https://github.com/KKLater/ESCache) 是对常用缓存方案的封装，意在提供方便的内存管理、磁盘存储管理方案。

##  <span id="开始使用">开始使用</span>

### <span id="要求">要求</span>

* Swift 5.0

### <span id="安装">安装</span>

#### <span id="SwiftPackageManager">Swift Package Manager (推荐)</span>

```swift
package.dependencies += [
    .package(url: "https://github.com/KKLater/ESCache.git", from: "0.0.1"),
]
```

#### <span id="Cocoapods">Cocoapods</span>

```sh
pod 'ESCache', "~> 0.0.1"
```

### <span id="使用">使用</span>

#### <span id="内存存取">内存存取</span>

##### 单例存取

可以直接使用 `MemoryCache` 的 `default` 单例进行存取。

```swift
let str = "save string object"
let key = "saveKey"

let success = MemoryCache.default.save(str, for: key)
let value = MemoryCache.default.string(for: key)
```



##### 实例存取

也可以创建 [MemoryCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/MemoryCache.swift) 实例进行存取。

```swift
let str = "save string object"
let key = "saveKey"

let cache = MemoryCache(name: "creat")
let success = cache.save(str, for: key)
let value = cache.string(for: key)
```

需要注意的是实例的创建需要一个缓存名称命名，如果没有设置名称，则创建的缓存实例名称与 `default` 单例一致。

#### <span id="文件存取">文件存取</span>

##### 单例

可以直接使用 [FileCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/FileCache.swift) 的相关实例进行存取，`FileCache` 提供了以下单例。

```swift
// 默认单例，等价于 cache
public static let `default`: ESCache.FileCache

// cache 单例，文件存储位置为系统 cache 文件夹
public static let cache: ESCache.FileCache

// document 单例，文件存储位置为系统 documnet 文件夹
public static let document: ESCache.FileCache

// download 单例，文件存储位置为系统 download 文件夹
public static let download: ESCache.FileCache

// libraby 单例，文件存储位置为系统 libraby 文件夹
public static let libraby: ESCache.FileCache

// temp 单例，在 `iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0` 以上系统版本，文件存储在 temp 文件路径，其他版本存储在 `cache` 路径
public static let temp: ESCache.FileCache

```

##### 单例存取

```swift
let str = "save string object"
let key = "saveKey"

let success = FileCache.default.save(str, for: key)
let value = FileCache.default.string(for: key)
```

##### 实例存取

与 [MemoryCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/MemoryCache.swift) 一致，[FileCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/FileCache.swift) 也提供了自定义文件路径存取的方案。

```swift  
let str = "save string object"
let key = "saveKey"

let cache = FileCache(name: "private", directory: .cache)
let success = cache.save(str, for: key)
let value = cache.string(for: key)
```

实例创建时提供的 `name` 和 `directory` 构成文件存储路径。

### <span id="其他">其他</span>



[Cacheable](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/Cacheable.swift) 协议提供了基础缓存方案，即存取 `data`。在此基础上如果需要储存其他类型对象，可以通过针对 `Cacheable` 协议做方法扩展。例如已经提供的存储字符串和存储满足 `NSSecureCoding` 协议的实例对象的方案。

```swift
public func string(for key: String) -> String?
public func save(_ string: String, for key: String, expires: Date? = nil) -> Bool


public func object(for key: String) -> Any? 
public func save<T>(_ object: T, for key: String, expires: Date? = nil) -> Bool where T : NSObject, T : NSSecureCoding 
```



[AutoPurgeCache](https://github.com/KKLater/ESCache/blob/main/Sources/ESCache/AutoPurgeCache.swift) 在 `UIKit` 框架下，在接收到系统内存警告的时候，会自动执行 `removeAllObjects` 清理内存。

## <span id="许可协议">许可协议</span>

[ESCache](https://github.com/KKLater/ESCache) 以 MIT 协议发布. 查看 [LICENSE](https://github.com/KKLater/ESCache/blob/main/LICENSE) 获取更多信息.

