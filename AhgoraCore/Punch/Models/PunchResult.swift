import Foundation

public struct PunchResult: Decodable {
	public let result: Bool
	public let time: String
	public let day: Date
	public let punchesOfDay: [String]
	public let name: String

	private enum CodingKeys: String, CodingKey {
		case result
		case time
		case day
		case puchesOfDay = "batidas_dia"
		case name = "nome"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.result = try container.decode(Bool.self, forKey: .result)
		self.time = try container.decode(String.self, forKey: .time)
		self.punchesOfDay = try container.decode([String].self, forKey: .puchesOfDay)
		self.name = try container.decode(String.self, forKey: .name)

		let day = try container.decode(String.self, forKey: .day)
		self.day = AhgoraDateFormatter.instance.date(from: day) ?? Date()
	}
}
