import RxSwift

public final class SettingsService: SettingsInteractor {
	private let dataSource: SettingsDataSource

	public init(dataSource: SettingsDataSource) {
		self.dataSource = dataSource
	}

	public func update(settings: Settings) -> Completable {
		let company = CompanyCredentials(tokenIdentifier: settings.company.token, identifier: settings.company.identifier)
		let employee = EmployeeCredentials(registration: settings.employee.registration, password: settings.employee.password)
		let credentials = Credentials(company: company, employee: employee)
		let loginState = LoginState.logged(credentials: credentials)
		let appState = AppState(loginState: loginState, lastDayOfMonth: AppState.lastDayOfMonthDefault)
		return dataSource.saveState(appState: appState)
	}
}
