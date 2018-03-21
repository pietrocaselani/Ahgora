import Moya
import RxSwift

public final class MirrorMoyaNetwork: MirrorNetwork {
	private let provider: AhgoraAPIProvider

	public init(provider: AhgoraAPIProvider) {
		self.provider = provider
	}

	public func mirrorFor(month: Int, year: Int, credentials: Credentials) -> Single<Mirror> {
		let company = credentials.company
		let employee = credentials.employee

		let parameters = MirrorAPIParameters(year: year,
											 month: month,
											 companyIdentifier: company.identifier,
											 employeeRegistration: employee.registration,
											 employeePassword: employee.password)

		let target = AhgoraAPI.mirror(parameters: parameters)
		return provider.ahgora.rx.request(target).map(Mirror.self)
	}
}
