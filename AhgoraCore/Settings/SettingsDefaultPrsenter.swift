import RxSwift

public final class SettingsDefaultPresenter: SettingsPresenter {
	private weak var view: SettingsView?
	private let interactor: SettingsInteractor
	private let appStateObservable: AppStateObservable
	private let disposeBag = DisposeBag()

	public init(view: SettingsView, interactor: SettingsInteractor, appStateObservable: AppStateObservable) {
		self.view = view
		self.interactor = interactor
		self.appStateObservable = appStateObservable
	}

	public func viewDidLoad() {
		appStateObservable.observe()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] newAppState in
				guard let strongSelf = self, let view = strongSelf.view else { return }

				switch newAppState {
				case .notLogged:
					view.showNotLogged()
				case .logged(let credentials):
					let viewModel = strongSelf.convertToViewModel(credentials)
					view.show(viewModel: viewModel)
				}
			}, onError: { [weak self] error in
				guard let view = self?.view else { return }
				view.showError(message: error.localizedDescription)
			}).disposed(by: disposeBag)
	}

	public func save(companyTokenIdentifier: String, companyIdentifier: String, employeeRegistration: String, employeePassword: String) {
		guard let registration = Int(employeeRegistration) else { return }

		let completable = interactor.update(companyTokenIdentifier: companyTokenIdentifier, companyIdentifier: companyIdentifier,
											employeeRegistration: registration, employeePassword: employeePassword)

		completable.observeOn(MainScheduler.instance)
			.subscribe(onCompleted: { [weak self] in
				self?.view?.showCredentialsUpdated()
			}) { [weak self] error in
				self?.view?.showError(message: error.localizedDescription)
			}.disposed(by: disposeBag)
	}

	private func convertToViewModel(_ credentials: Credentials) -> SettingsViewModel {
		let employee = credentials.employee
		let company = credentials.company

		return SettingsViewModel(companyTokenIdentifier: company.tokenIdentifier, companyIdentifier: company.identifier,
								 employeeRegistration: employee.registration, employeePassword: employee.password)
	}
}
