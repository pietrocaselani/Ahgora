public struct EmployeeCredentials: Hashable {
	public let registration: String
	public let password: String

	public init(registration: String, password: String) {
		self.registration = registration
		self.password = password
	}

	public var hashValue: Int {
		return 11 ^ registration.hashValue ^ password.hashValue
	}

	public static func == (lhs: EmployeeCredentials, rhs: EmployeeCredentials) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
