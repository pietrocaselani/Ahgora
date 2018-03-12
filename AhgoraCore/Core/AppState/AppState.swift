public enum AppState {
	case notLogged
	case logged(credentials: Credentials)
}

extension AppState: Hashable {
	public var hashValue: Int {
		switch self {
		case .notLogged:
			return 1
		case .logged(let credentials):
			return 11 ^ credentials.hashValue
		}
	}

	public static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}	
}
