import Moya

public struct MirrorAPIParameters {
	public let year: Int
	public let month: Int
	public let companyIdentifier: String
	public let employeeRegistration: Int
	public let employeePassword: String
}

public struct PunchAPIParameters {
	public let employeeRegistration: Int
	public let employeePassword: String
	public let companyTokenIdentifier: String
}

public enum AhgoraAPI {
	case mirror(parameters: MirrorAPIParameters)
	case punch(parameters: PunchAPIParameters)
}

extension AhgoraAPI: TargetType {
	public var baseURL: URL { return URL(string: "https://www.ahgora.com.br")! }

	public var path: String {
		switch self {
		case .mirror:
			return "/externo/getApuracao"
		case .punch:
			return "/batidaonline/verifyIdentification"
		}
	}

	public var method: Moya.Method {
		return .post
	}

	public var sampleData: Data {
		return Data()
	}

	public var task: Task {
		let bodyString: String
		switch self {
		case .mirror(let parameters):
			bodyString = "ano=\(parameters.year)&company=\(parameters.companyIdentifier)&matricula=\(parameters.employeeRegistration)&mes=\(parameters.month)&senha=\(parameters.employeePassword)"
		case .punch(let parameters):
			bodyString = "account=\(parameters.employeeRegistration)&password=\(parameters.employeePassword)&identity=\(parameters.companyTokenIdentifier)&key="
		}

		let bodyData = bodyString.data(using: .utf8) ?? Data()
		return Task.requestData(bodyData)
	}

	public var headers: [String : String]? {
		return ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
	}
}
