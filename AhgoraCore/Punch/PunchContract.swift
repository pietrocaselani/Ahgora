import RxSwift

public protocol PunchView: BaseView {
	var presenter: PunchPresenter! { get }

	func showMissingCredentials()
	func showCredentialsValid()
	func show(punch: PunchResult)
	func showError(message: String)
}

public protocol PunchInteractor: class {
	init(network: PunchNetwork)

	func punch(credentials: Credentials) -> Single<PunchResult>
}

public protocol PunchNetwork: class {
	init(provider: AhgoraAPIProvider)

	func punch(parameters: PunchAPIParameters) -> Single<PunchResult>
}

public protocol PunchPresenter: class {
	init(view: PunchView, interactor: PunchInteractor, appStateObservable: AppStateObservable, appState: AppState)

	func viewDidLoad()
	func punch()
}
