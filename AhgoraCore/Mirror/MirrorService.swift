import RxSwift

public final class MirrorService: MirrorInteractor {
	private let network: MirrorNetwork

	public init(network: MirrorNetwork) {
		self.network = network
	}

	public func mirrorFor(month: Int, year: Int, credentials: Credentials) -> Single<Mirror> {
		return network.mirrorFor(month: month, year: year, credentials: credentials)
	}
}
