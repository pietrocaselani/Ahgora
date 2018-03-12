import Moya

final class DefaultMoyaRequestInterceptor: RequestInterceptor {
	func intercept(endpoint: Endpoint, done: @escaping MoyaProvider<AhgoraAPI>.RequestResultClosure) {
		MoyaProvider<AhgoraAPI>.defaultRequestMapping(for: endpoint, closure: done)
	}
}
