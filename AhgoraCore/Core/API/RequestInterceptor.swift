import Moya

public protocol RequestInterceptor {
	func intercept(endpoint: Endpoint, done: @escaping MoyaProvider<AhgoraAPI>.RequestResultClosure)
}
