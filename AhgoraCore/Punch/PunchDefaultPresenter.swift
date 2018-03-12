import RxSwift

public final class PunchDefaultPresenter: PunchPresenter {
	private weak var view: PunchView?
	private let interactor: PunchInteractor
	private let appStateObservable: AppStateObservable
	private var appState: AppState
	private let disposeBag = DisposeBag()

	public init(view: PunchView, interactor: PunchInteractor, appStateObservable: AppStateObservable, appState: AppState) {
		self.view = view
		self.interactor = interactor
		self.appStateObservable = appStateObservable
		self.appState = appState
	}

	public func viewDidLoad() {
		appStateObservable.observe()
			.catchErrorJustReturn(AppState.notLogged)
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] appState in
				self?.appState = appState

				if appState == .notLogged {
					self?.view?.showMissingCredentials()
				} else {
					self?.view?.showCredentialsValid()
				}
			}).disposed(by: disposeBag)
	}

	public func punch() {
		if case .logged(let credentials) = appState {
			interactor.punch(credentials: credentials)
				.observeOn(MainScheduler.instance)
				.subscribe(onSuccess: { [weak self] result in
					self?.view?.show(punch: result)
				}, onError: { [weak self] error in
					self?.view?.showError(message: error.localizedDescription)
				}).disposed(by: disposeBag)
		} else {
			view?.showMissingCredentials()
		}
	}
}
