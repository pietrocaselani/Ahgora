import Cocoa
import AhgoraCore

final class PunchViewController: NSViewController, PunchView {
	var presenter: PunchPresenter!

	@IBOutlet weak var infoTextField: NSTextField!
	@IBOutlet weak var punchButton: NSButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			Swift.fatalError("view loaded without a presenter")
		}
		
		presenter.viewDidLoad()
	}

	@IBAction func punch(_ sender: Any) {
		presenter.punch()
	}

	func showMissingCredentials() {
		infoTextField.stringValue = "Vá em configurações para fazer o login"
		infoTextField.isHidden = false
		punchButton.isEnabled = false
	}

	func showCredentialsValid() {
		infoTextField.isHidden = true
		punchButton.isEnabled = true
	}

	func show(punch: PunchResult) {
		let alert = NSAlert()
		alert.addButton(withTitle: "OK")
		alert.messageText = "Ponto batido: \(punch.time) para \(punch.name)"
		alert.informativeText = "Batidas do dia: \(punch.punchesOfDay.joined(separator: ", "))"
		alert.runModal()
	}

	func showError(message: String) {
		let alert = NSAlert()
		alert.addButton(withTitle: "OK")
		alert.messageText = message
		alert.alertStyle = .critical
		alert.runModal()
	}

}
