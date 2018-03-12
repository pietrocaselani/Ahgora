import RxSwift

public final class PunchService: PunchInteractor {
	private let network: PunchNetwork

	public init(network: PunchNetwork) {
		self.network = network
	}

	public func punch(credentials: Credentials) -> Single<PunchResult> {
		let employee = credentials.employee
		let company = credentials.company
		let parameters = PunchAPIParameters(employeeRegistration: employee.registration,
											employeePassword: employee.password,
											companyTokenIdentifier: company.tokenIdentifier)

		return network.punch(parameters: parameters)
	}
}
