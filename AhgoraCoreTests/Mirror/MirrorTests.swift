import XCTest
@testable import AhgoraCore

final class MirrorTests: XCTestCase {
	func testMirror_parseSuccess() throws {
		let mirror = try? JSONParse.parseJSON(named: "mirror", using: MirrorTests.self, of: Mirror.self)

		XCTAssertNotNil(mirror)
	}
}
