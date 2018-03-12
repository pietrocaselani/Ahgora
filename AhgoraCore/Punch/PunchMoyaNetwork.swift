import RxSwift
import Moya

public final class PunchMoyaNetwork: PunchNetwork {
	private let provider: AhgoraAPIProvider

	public init(provider: AhgoraAPIProvider) {
		self.provider = provider
	}

	public func punch(parameters: PunchAPIParameters) -> Single<PunchResult> {
		let target = AhgoraAPI.punch(parameters: parameters)
		return provider.ahgora.rx.request(target).map(PunchResult.self)
	}
}
