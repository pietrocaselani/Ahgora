public struct EmployeeCredentials: Hashable {
	public let registration: Int
	public let password: String

	public init(registration: Int, password: String) {
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
