import RxSwift

public final class SettingsService: SettingsInteractor {
	private let dataSource: SettingsDataSource

	public init(dataSource: SettingsDataSource) {
		self.dataSource = dataSource
	}

	public func update(companyTokenIdentifier: String, companyIdentifier: String, employeeRegistration: Int, employeePassword: String) -> Completable {
		let company = CompanyCredentials(tokenIdentifier: companyTokenIdentifier, identifier: companyIdentifier)
		let employee = EmployeeCredentials(registration: employeeRegistration, password: employeePassword)
		let credentials = Credentials(company: company, employee: employee)
		let appState = AppState.logged(credentials: credentials)
		return dataSource.saveState(appState: appState)
	}
}
