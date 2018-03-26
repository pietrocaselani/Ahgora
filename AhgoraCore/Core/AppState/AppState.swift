public struct AppState: Hashable {
	public static let lastDayOfMonthDefault = 25
	public static let initial = AppState(loginState: .notLogged, lastDayOfMonth: AppState.lastDayOfMonthDefault)
	let loginState: LoginState
	let lastDayOfMonth: Int

	public init(loginState: LoginState, lastDayOfMonth: Int) {
		self.loginState = loginState
		self.lastDayOfMonth = lastDayOfMonth
	}

	public var hashValue: Int {
		return loginState.hashValue ^ lastDayOfMonth.hashValue
	}

	public static func ==(lhs: AppState, rhs: AppState) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
