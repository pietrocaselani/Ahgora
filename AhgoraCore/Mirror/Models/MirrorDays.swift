import Foundation

public struct MirrorDays: Decodable {
	public static let empty = MirrorDays()
	public let days: [MirrorDay]

	public init() {
		self.days = [MirrorDay]()
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: JSONCodingKeys.self)
		let result = try container.decode(Dictionary<String, Any>.self)

		let formatter = AhgoraDateFormatter.instance.dateFormatter

		let days = result.flatMap { (key, value) -> MirrorDay? in
			guard let date = formatter.date(from: key),
				let json = value as? Dictionary<String, Any> else {
					return MirrorDay.empty
			}

			return MirrorDay(json: json, date: date)
		}

		self.days = days.sorted(by: { (lhs, rhs) -> Bool in
			return lhs.date < rhs.date
		})
	}
}




