public struct MirrorResult: Decodable {
	public let type: MirrorResultType
	public let value: String
	public let valid: Bool

	private enum CodingKeys: String, CodingKey {
		case type = "tipo"
		case value = "valor"
		case valid = "em_dia"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let jsonType = try container.decode(String.self, forKey: .type)
		var valueJSON = try container.decode(String.self, forKey: .value)
		self.valid = try container.decode(Bool.self, forKey: .valid)

		self.type = MirrorResultType.create(from: jsonType)

		if type == .workedHours {
			valueJSON.formatAsAhgoraHour()
		}

		self.value = valueJSON
	}
}
