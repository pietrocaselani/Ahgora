import RxSwift

public protocol MirrorView: BaseView {
	var presenter: MirrorPresenter! { get }

	func showMissingCredentials()
	func showError(message: String)
	func show(mirror: Mirror)
}

public protocol MirrorInteractor {
	init(network: MirrorNetwork)

	func mirrorFor(month: Int, year: Int, credentials: Credentials) -> Single<Mirror>
}

public protocol MirrorNetwork {
	init(provider: AhgoraAPIProvider)

	func mirrorFor(month: Int, year: Int, credentials: Credentials) -> Single<Mirror>
}

public protocol MirrorPresenter {
	init(view: MirrorView, interactor: MirrorInteractor, appStateObservable: AppStateObservable, dateProvider: DateProvider, appState: AppState)

	func viewDidLoad()
	func mirrorFor(month: Int, year: Int)
}
