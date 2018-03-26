import RxSwift

public protocol SettingsView: BaseView {
	var presenter: SettingsPresenter! { get set }

	func show(viewModel: SettingsViewModel)
	func showCredentialsUpdated()
	func showNotLogged()
	func showError(message: String)
}

public protocol SettingsPresenter {
	init(view: SettingsView, interactor: SettingsInteractor, appStateObservable: AppStateObservable)

	func viewDidLoad()

	func save(settings: Settings)
}

public protocol SettingsInteractor {
	init(dataSource: SettingsDataSource)

	func update(settings: Settings) -> Completable
}

public protocol SettingsDataSource {
	init(appStateOutput: AppStateOutput)

	func fetchAppState() -> Observable<AppState>
	func saveState(appState: AppState) -> Completable
}

public struct Settings {
	public let company: SettingsCompany
	public let employee: SettingsEmployee
	public let lastDayOfMonth: Int

	public init(company: SettingsCompany, employee: SettingsEmployee, lastDayOfMonth: Int) {
		self.company = company
		self.employee = employee
		self.lastDayOfMonth = lastDayOfMonth
	}
}

public struct SettingsEmployee {
	public let registration: String
	public let password: String

	public init(registration: String, password: String) {
		self.registration = registration
		self.password = password
	}
}

public struct SettingsCompany {
	public let token: String
	public let identifier: String

	public init(token: String, identifier: String) {
		self.token = token
		self.identifier = identifier
	}
}

public struct SettingsViewModel {
	public let companyTokenIdentifier: String
	public let companyIdentifier: String
	public let employeeRegistration: String
	public let employeePassword: String
	public let lastDayOfMonth: String

	public init(companyTokenIdentifier: String, companyIdentifier: String, employeeRegistration: String, employeePassword: String, lastDayOfMonth: String) {
		self.companyTokenIdentifier = companyTokenIdentifier
		self.companyIdentifier = companyIdentifier
		self.employeeRegistration = employeeRegistration
		self.employeePassword = employeePassword
		self.lastDayOfMonth = lastDayOfMonth
	}
}
