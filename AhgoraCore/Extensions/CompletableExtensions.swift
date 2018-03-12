import RxSwift

extension PrimitiveSequence where Trait == CompletableTrait {
	public static func fromCallable(_ function: @escaping () throws -> ()) -> Completable {
		return Completable.create { emitter -> Disposable in
			do {
				try function()
				emitter(.completed)
			} catch {
				emitter(.error(error))
			}
			return Disposables.create()
		}
	}
}
