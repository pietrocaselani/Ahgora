import Moya

public protocol AhgoraAPIProvider {
	var ahgora: MoyaProvider<AhgoraAPI> { get }
}
