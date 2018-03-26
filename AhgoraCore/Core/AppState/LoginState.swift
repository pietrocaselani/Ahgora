public enum LoginState {
	case notLogged
	case logged(credentials: Credentials)
}

extension LoginState: Hashable {
	public var hashValue: Int {
		switch self {
		case .notLogged:
			return 1
		case .logged(let credentials):
			return 11 ^ credentials.hashValue
		}
	}

	public static func ==(lhs: LoginState, rhs: LoginState) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}

