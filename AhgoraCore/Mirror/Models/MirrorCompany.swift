public struct MirrorCompany: Decodable {
	public let identifier: String
	public let name: String
	public let monthStartsOnDay: String

	private enum CodingKeys: String, CodingKey {
		case identifier = "empresa"
		case name = "nome"
		case monthStartsOnDay = "inicia_dia"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.identifier = try container.decode(String.self, forKey: .identifier)
		self.name = try container.decode(String.self, forKey: .name)
		self.monthStartsOnDay = try container.decode(String.self, forKey: .monthStartsOnDay)
	}
}
