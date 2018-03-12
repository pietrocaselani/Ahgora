public struct CompanyCredentials: Hashable {
	public let tokenIdentifier: String
	public let identifier: String

	public init(tokenIdentifier: String, identifier: String) {
		self.tokenIdentifier = tokenIdentifier
		self.identifier = identifier
	}

	public var hashValue: Int {
		return 11 ^ tokenIdentifier.hashValue ^ identifier.hashValue
	}

	public static func == (lhs: CompanyCredentials, rhs: CompanyCredentials) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
