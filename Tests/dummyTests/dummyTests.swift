import XCTest
@testable import dummy

final class dummyTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(dummy().text, "Hello, World!")
    }
}
