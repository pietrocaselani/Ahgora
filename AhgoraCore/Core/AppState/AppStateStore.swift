import RxSwift

public final class AppStateStore: AppStateOutput, AppStateObservable {
	private let subject: BehaviorSubject<AppState>

	public init(initialState: AppState) {
		subject = BehaviorSubject(value: initialState)
	}

	public func newAppState(newState: AppState) {
		subject.onNext(newState)
	}

	public func observe() -> Observable<AppState> {
		return subject.asObservable().distinctUntilChanged()
	}
}
