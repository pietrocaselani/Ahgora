import RxSwift

public final class MirrorDefaultPresenter: MirrorPresenter {
	private weak var view: MirrorView?
	private let interactor: MirrorInteractor
	private let appStateObservable: AppStateObservable
	private let dateProvider: DateProvider
	private var appState: AppState
	private let disposeBag = DisposeBag()

	public init(view: MirrorView, interactor: MirrorInteractor, appStateObservable: AppStateObservable, dateProvider: DateProvider, appState: AppState) {
		self.view = view
		self.interactor = interactor
		self.appStateObservable = appStateObservable
		self.dateProvider = dateProvider
		self.appState = appState
	}

	public func viewDidLoad() {
		appStateObservable.observe()
			.catchErrorJustReturn(AppState.initial)
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] appState in
				guard let strongSelf = self else {
					return
				}

				strongSelf.handleAppState(appState)

			}).disposed(by: disposeBag)
	}

	public func mirrorFor(month: Int, year: Int) {
		if case .logged(let credentials) = appState.loginState {
			mirrorFor(month: month, year: year, credentials: credentials)
		} else if let view = view {
			view.showMissingCredentials()
		}
	}

	private func handleAppState(_ appState: AppState) {
		self.appState = appState

		guard let view = view else { return }

		switch appState.loginState {
		case .notLogged:
			view.showMissingCredentials()
		case .logged(let credentials):
			let now = dateProvider.now
			let calendar = Calendar.current

			let currentMonth = calendar.component(.month, from: now)
			let currentYear = calendar.component(.year, from: now)

			mirrorFor(month: currentMonth, year: currentYear, credentials: credentials)
		}
	}

	public func mirrorFor(month: Int, year: Int, credentials: Credentials) {
		let today = dateProvider.now

		let components = Calendar.current.dateComponents([.year, .month, .day], from: today)
		let day = components.value(for: .day) ?? 1
		var month = components.value(for: .month) ?? 0
		var year = components.value(for: .year) ?? 0

		if day >= appState.lastDayOfMonth {
			if month == 12 {
				month = 1
				year += 1
			} else {
				month += 1
			}
		}

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: "\(year)-\(month)-\(day)") ?? today

		interactor.mirrorFor(month: month, year: year, credentials: credentials)
			.observeOn(MainScheduler.instance)
			.subscribe(onSuccess: { [weak self] mirror in
				guard let strongSelf = self else { return }

				strongSelf.view?.show(mirror: mirror, for: date)
			}) { [weak self] error in
				self?.view?.showError(message: error.localizedDescription)
			}.disposed(by: disposeBag)
	}
}
