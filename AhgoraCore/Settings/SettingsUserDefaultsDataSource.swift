import RxSwift

public final class SettingsUserDefaultsDataSource: SettingsDataSource {
	private static let loggedKey = "settingsUserDefaultsDataSourceLogged"
	private static let credentialsKey = "settingsUserDefaultsDataSourceCredentials"

	private let output: AppStateOutput
	private let userDefaults: UserDefaults

	public init(appStateOutput: AppStateOutput) {
		Swift.fatalError("Please, use init(appStateOutput: userDefaults:)")
	}

	public init(appStateOutput: AppStateOutput, userDefaults: UserDefaults) {
		self.output = appStateOutput
		self.userDefaults = userDefaults
	}

	public static func currentAppState(userDefaults: UserDefaults) -> AppState {
		let logged = userDefaults.bool(forKey: SettingsUserDefaultsDataSource.loggedKey)

		guard logged else {
			return AppState.notLogged
		}

		guard let credentialsData = userDefaults.data(forKey: SettingsUserDefaultsDataSource.credentialsKey) else {
			return AppState.notLogged
		}

		guard let secureCredentials = NSKeyedUnarchiver.unarchiveObject(with: credentialsData) as? SecurePersistableCredentials else {
			return AppState.notLogged
		}

		let companyCredentials = CompanyCredentials(tokenIdentifier: secureCredentials.companyTokenIdentifier, identifier: secureCredentials.companyIdentifier)
		let employeeCredentials = EmployeeCredentials(registration: secureCredentials.employeeRegistration, password: secureCredentials.employeePassword)
		let credentials = Credentials(company: companyCredentials, employee: employeeCredentials)

		return AppState.logged(credentials: credentials)
	}

	public func fetchAppState() -> Observable<AppState> {
		return Observable.create({ [weak self] observer -> Disposable in
			guard let strongSelf = self else {
				return Disposables.create()
			}

			let appState = strongSelf.fetchAppStateFromUserDefaults()
			observer.onNext(appState)

			return Disposables.create()
		})
	}

	public func saveState(appState: AppState) -> Completable {
		return Completable.fromCallable { [weak self] in
			self?.saveOnUserDefaults(appState: appState)
			}.do(onCompleted: { [weak self] in
				self?.output.newAppState(newState: appState)
			})
	}

	private func fetchAppStateFromUserDefaults() -> AppState {
		return SettingsUserDefaultsDataSource.currentAppState(userDefaults: userDefaults)
	}

	private func saveOnUserDefaults(appState: AppState) {
		switch appState {
		case .notLogged:
			userDefaults.set(false, forKey: SettingsUserDefaultsDataSource.loggedKey)
		case .logged(let credentials):
			let employee = credentials.employee
			let company = credentials.company

			userDefaults.set(true, forKey: SettingsUserDefaultsDataSource.loggedKey)
			let credentials = SecurePersistableCredentials(employeeRegistration: employee.registration,
														   employeePassword: employee.password,
														   companyTokenIdentifier: company.tokenIdentifier,
														   companyIdentifier: company.identifier)
			let credentialsData = NSKeyedArchiver.archivedData(withRootObject: credentials)
			userDefaults.set(credentialsData, forKey: SettingsUserDefaultsDataSource.credentialsKey)
		}
	}
}
