public struct MirrorResult: Decodable {
	public let type: String
	public let value: String
	public let valid: Bool

	private enum CodingKeys: String, CodingKey {
		case type = "tipo"
		case value = "valor"
		case valid = "em_dia"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.type = try container.decode(String.self, forKey: .type)
		self.value = try container.decode(String.self, forKey: .value)
		self.valid = try container.decode(Bool.self, forKey: .valid)
	}
}
