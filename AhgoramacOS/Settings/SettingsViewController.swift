import Cocoa
import AhgoraCore

final class SettingsViewController: NSViewController, SettingsView {
	var presenter: SettingsPresenter!

	@IBOutlet weak var companyTokenIdentifierTextField: NSTextField!
	@IBOutlet weak var companyIdentifierTextField: NSTextField!
	@IBOutlet weak var employeeRegistrationTextField: NSTextField!
	@IBOutlet weak var employeePasswordTextField: NSTextField!

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

		presenter.save(companyTokenIdentifier: companyToken,
					   companyIdentifier: companyIdentifier, employeeRegistration: employeeRegistration, employeePassword: employeePassword)
	}

	func show(viewModel: SettingsViewModel) {
		companyTokenIdentifierTextField.stringValue = viewModel.companyTokenIdentifier
		companyIdentifierTextField.stringValue = viewModel.companyIdentifier
		employeeRegistrationTextField.integerValue = viewModel.employeeRegistration
		employeePasswordTextField.stringValue = viewModel.employeePassword
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
