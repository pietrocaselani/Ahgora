public struct MirrorEmployee: Decodable {
	public let name: String
	public let department: String
	public let jobRole: String
	public let registration: String
	public let admissionDate: String

	private enum CodingKeys: String, CodingKey {
		case name = "nome"
		case department = "departamento"
		case jobRole = "cargo"
		case registration = "matricula"
		case admissionDate = "dt_admissao"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.name = try container.decode(String.self, forKey: .name)
		self.department = try container.decode(String.self, forKey: .department)
		self.jobRole = try container.decode(String.self, forKey: .jobRole)
		self.registration = try container.decode(String.self, forKey: .registration)
		self.admissionDate = try container.decode(String.self, forKey: .admissionDate)
	}
}
