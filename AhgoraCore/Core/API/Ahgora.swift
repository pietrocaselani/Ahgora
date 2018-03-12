import Moya

public final class Ahgora: AhgoraAPIProvider {
	public lazy var ahgora: MoyaProvider<AhgoraAPI> = createProvider()
	private let callbackQueue: DispatchQueue?
	private let interceptors: [RequestInterceptor]
	private let plugins: [PluginType]

	init(builder: AhgoraBuilder) {
		self.callbackQueue = builder.callbackQueue

		var interceptors = builder.interceptors ?? [RequestInterceptor]()
		interceptors.append(DefaultMoyaRequestInterceptor())

		self.interceptors = interceptors
		self.plugins = builder.plugins ?? [PluginType]()
	}

	private func createProvider() -> MoyaProvider<AhgoraAPI> {
		let requestClosure = createRequestClosure()

		return MoyaProvider<AhgoraAPI>(requestClosure: requestClosure, callbackQueue: callbackQueue, plugins: plugins)
	}

	private func createRequestClosure() -> MoyaProvider<AhgoraAPI>.RequestClosure {
		let requestClosure = { [unowned self] (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
			self.interceptors.forEach { $0.intercept(endpoint: endpoint, done: done) }
		}

		return requestClosure
	}
}

public final class AhgoraBuilder {
	public var plugins: [PluginType]?
	public var interceptors: [RequestInterceptor]?
	public var callbackQueue: DispatchQueue?

	public typealias BuilderClosure = (AhgoraBuilder) -> Void

	public init(buildClosure: BuilderClosure) {
		buildClosure(self)
	}

	public func build() -> Ahgora {
		return Ahgora(builder: self)
	}
}
