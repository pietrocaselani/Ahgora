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

	func save(companyTokenIdentifier: String, companyIdentifier: String,
			  employeeRegistration: String, employeePassword: String)
}

public protocol SettingsInteractor {
	init(dataSource: SettingsDataSource)

	func update(companyTokenIdentifier: String, companyIdentifier: String,
				employeeRegistration: Int, employeePassword: String) -> Completable
}

public protocol SettingsDataSource {
	init(appStateOutput: AppStateOutput)

	func fetchAppState() -> Observable<AppState>
	func saveState(appState: AppState) -> Completable
}

public struct SettingsViewModel {
	public let companyTokenIdentifier: String
	public let companyIdentifier: String
	public let employeeRegistration: Int
	public let employeePassword: String

	public init(companyTokenIdentifier: String, companyIdentifier: String, employeeRegistration: Int, employeePassword: String) {
		self.companyTokenIdentifier = companyTokenIdentifier
		self.companyIdentifier = companyIdentifier
		self.employeeRegistration = employeeRegistration
		self.employeePassword = employeePassword
	}
}
