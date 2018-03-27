import UIKit
import AhgoraCore

final class SettingsViewController: UIViewController, SettingsView {
	var presenter: SettingsPresenter!

	@IBOutlet weak var companyTokenIdentifierTextField: UITextField!
	@IBOutlet weak var companyIdentifierTextField: UITextField!
	@IBOutlet weak var employeeRegistrationTextField: UITextField!
	@IBOutlet weak var employeePasswordTextField: UITextField!
	@IBOutlet weak var lastDayOfMonthTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			Swift.fatalError("view loaded without a presenter")
		}

		presenter.viewDidLoad()
	}

	func show(viewModel: SettingsViewModel) {
		companyTokenIdentifierTextField.text = viewModel.companyTokenIdentifier
		companyIdentifierTextField.text = viewModel.companyIdentifier
		employeeRegistrationTextField.text = String(viewModel.employeeRegistration)
		employeePasswordTextField.text = String(viewModel.employeePassword)
		lastDayOfMonthTextField.text = viewModel.lastDayOfMonth
	}

	func showNotLogged() {}

	func showError(message: String) {
		let errorController = UIAlertController.createErrorAlert(message: message)

		present(errorController, animated: true, completion: nil)
	}

	func showCredentialsUpdated() {
		let controller = UIAlertController(title: "Credenciais", message: "Credenciais atualizadas com sucesso", preferredStyle: .alert)

		let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
			controller.dismiss(animated: true, completion: nil)
		}

		controller.addAction(okAction)

		present(controller, animated: true, completion: nil)
	}

	@IBAction func saveCredentials(_ sender: Any) {
		guard let companyTokenIdentifier = companyTokenIdentifierTextField.text,
			let companyIdentifier = companyIdentifierTextField.text,
			let employeeRegistration = employeeRegistrationTextField.text,
			let employeePassword = employeePasswordTextField.text else { return }

		let lastDayOfMonth = Int(lastDayOfMonthTextField.text ?? "") ?? AppState.lastDayOfMonthDefault

		let company = SettingsCompany(token: companyTokenIdentifier, identifier: companyIdentifier)
		let employee = SettingsEmployee(registration: employeeRegistration, password: employeePassword)
		let settings = Settings(company: company, employee: employee, lastDayOfMonth: lastDayOfMonth)

		presenter.save(settings: settings)
	}
}
