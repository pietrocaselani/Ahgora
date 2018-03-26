import Cocoa
import AhgoraCore

final class SettingsViewController: NSViewController, SettingsView {
	var presenter: SettingsPresenter!

	@IBOutlet weak var companyTokenIdentifierTextField: NSTextField!
	@IBOutlet weak var companyIdentifierTextField: NSTextField!
	@IBOutlet weak var employeeRegistrationTextField: NSTextField!
	@IBOutlet weak var employeePasswordTextField: NSTextField!
	@IBOutlet weak var lastDayOfMonthTextField: NSTextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			Swift.fatalError("view loaded without a presenter")
		}

		presenter.viewDidLoad()
	}

	@IBAction func saveCredentials(_ sender: Any) {
		let companyToken = companyTokenIdentifierTextField.stringValue
		let companyIdentifier = companyIdentifierTextField.stringValue
		let employeeRegistration = employeeRegistrationTextField.stringValue
		let employeePassword = employeePasswordTextField.stringValue
		let lastDayOfMonth = lastDayOfMonthTextField.integerValue

		let company = SettingsCompany(token: companyToken, identifier: companyIdentifier)
		let employee = SettingsEmployee(registration: employeeRegistration, password: employeePassword)

		presenter.save(settings: Settings(company: company, employee: employee, lastDayOfMonth: lastDayOfMonth))
	}

	func show(viewModel: SettingsViewModel) {
		companyTokenIdentifierTextField.stringValue = viewModel.companyTokenIdentifier
		companyIdentifierTextField.stringValue = viewModel.companyIdentifier
		employeeRegistrationTextField.stringValue = viewModel.employeeRegistration
		employeePasswordTextField.stringValue = viewModel.employeePassword
		lastDayOfMonthTextField.stringValue = viewModel.lastDayOfMonth
	}

	func showCredentialsUpdated() {
		let alert = NSAlert()
		alert.addButton(withTitle: "OK")
		alert.messageText = "Credenciais atualizadas com sucesso"
		alert.alertStyle = .informational
		alert.runModal()
	}

	func showNotLogged() {

	}

	func showError(message: String) {

	}
}
