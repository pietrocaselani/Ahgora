import Foundation

final class JSONParse {
	enum JSONError: String, Error {
		case cantFindFile
	}

	static func parseJSON<T: Decodable>(named name: String, using testClass: AnyClass, of type: T.Type) throws -> T {
		let testBundle = Bundle(for: testClass)

		guard let jsonPath = testBundle.path(forResource: name, ofType: "json") else {
			throw JSONError.cantFindFile
		}

		let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath))

		let decoder = JSONDecoder()
		return try decoder.decode(type, from: data)
	}
}
