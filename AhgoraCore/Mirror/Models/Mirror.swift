public struct Mirror: Decodable {
	public let company: MirrorCompany
	public let employee: MirrorEmployee
	public let results: [MirrorResult]
	public let days: MirrorDays

	private enum CodingKeys: String, CodingKey {
		case company = "empresa"
		case employee = "funcionario"
		case results = "resultado"
		case days = "dias"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.company = try container.decode(MirrorCompany.self, forKey: .company)
		self.employee = try container.decode(MirrorEmployee.self, forKey: .employee)
		self.results = try container.decode([MirrorResult].self, forKey: .results)
		self.days = try container.decode(MirrorDays.self, forKey: .days)
	}
}
