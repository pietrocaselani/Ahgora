import Foundation

final class SecurePersistableCredentials: NSObject, NSCoding {
	let employeeRegistration: Int
	let employeePassword: String
	let companyTokenIdentifier: String
	let companyIdentifier: String

	init(employeeRegistration: Int, employeePassword: String, companyTokenIdentifier: String, companyIdentifier: String) {
		self.employeeRegistration = employeeRegistration
		self.employeePassword = employeePassword
		self.companyTokenIdentifier = companyTokenIdentifier
		self.companyIdentifier = companyIdentifier
	}

	init?(coder decoder: NSCoder) {
		guard let companyTokenIdentifier = decoder.decodeObject(forKey: "companyTokenIdentifier") as? String,
			let companyIdentifier = decoder.decodeObject(forKey: "companyIdentifier") as? String,
			let employeePassword = decoder.decodeObject(forKey: "employeePassword") as? String else {
				return nil
		}

		self.employeeRegistration = decoder.decodeInteger(forKey: "employeeRegistration")
		self.employeePassword = employeePassword
		self.companyTokenIdentifier = companyTokenIdentifier
		self.companyIdentifier = companyIdentifier
	}

	func encode(with coder: NSCoder) {
		coder.encode(employeeRegistration, forKey: "employeeRegistration")
		coder.encode(employeePassword, forKey: "employeePassword")
		coder.encode(companyTokenIdentifier, forKey: "companyTokenIdentifier")
		coder.encode(companyIdentifier, forKey: "companyIdentifier")
	}

	override func isEqual(_ object: Any?) -> Bool {
		guard let otherCredentials = object as? SecurePersistableCredentials else {
			return false
		}

		return self == otherCredentials
	}

	override var hash: Int {
		return self.hashValue
	}

	override var hashValue: Int {
		return employeePassword.hashValue ^ employeeRegistration.hashValue ^
			companyIdentifier.hashValue ^ companyTokenIdentifier.hashValue
	}

	static func == (lhs: SecurePersistableCredentials, rhs: SecurePersistableCredentials) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
