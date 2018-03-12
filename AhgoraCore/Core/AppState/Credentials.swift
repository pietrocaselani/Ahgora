public struct Credentials: Hashable {
	public let company: CompanyCredentials
	public let employee: EmployeeCredentials

	public init(company: CompanyCredentials, employee: EmployeeCredentials) {
		self.company = company
		self.employee = employee
	}

	public var hashValue: Int {
		return company.hashValue ^ employee.hashValue
	}

	public static func == (lhs: Credentials, rhs: Credentials) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
