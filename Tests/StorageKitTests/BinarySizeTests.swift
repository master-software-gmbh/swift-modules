import XCTest
@testable import StorageKit

final class BinarySizeTests: XCTestCase {
    func testBytes_initializedWithBytes() {
        let size: BinarySize = .bytes(300)
        XCTAssertEqual(size.bytes, 300)
    }

    func testBytes_initializedWithKilobytes() {
        let size: BinarySize = .kilobytes(1)
        XCTAssertEqual(size.bytes, 1024)
    }

    func testBytes_initializedWithMegabytes() {
        let size: BinarySize = .megabytes(1)
        XCTAssertEqual(size.bytes, 1_048_576)
    }
}
