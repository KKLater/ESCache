import XCTest
@testable import ESCache

final class ESCacheTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ESCache().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
