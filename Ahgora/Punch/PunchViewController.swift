import UIKit
import AhgoraCore

final class PunchViewController: UIViewController, PunchView {
	var presenter: PunchPresenter!

	@IBOutlet weak var infoLabel: UILabel!
	@IBOutlet weak var punchButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			Swift.fatalError("View loaded without a presenter")
		}

		presenter.viewDidLoad()
	}

	@IBAction func punch(_ sender: Any) {
		presenter.punch()
	}

	func showMissingCredentials() {
		infoLabel.text = "Vá em Configurações para atualizar suas credenciais"
		infoLabel.isHidden = false
		punchButton.isHidden = true
	}

	func showCredentialsValid() {
		infoLabel.isHidden = true
		punchButton.isHidden = false
	}

	func show(punch: PunchResult) {
		let time = punch.time
		let name = punch.name
		let punchesOfDay = punch.punchesOfDay.joined(separator: ", ")

		let message = "\(name)\n\(punchesOfDay)"

		let alert = UIAlertController(title: time, message: message, preferredStyle: .alert)

		let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
			alert.dismiss(animated: true, completion: nil)
		}

		alert.addAction(okAction)

		present(alert, animated: true, completion: nil)
	}

	func showError(message: String) {
		let alert = UIAlertController.createErrorAlert(message: message)

		present(alert, animated: true, completion: nil)
	}
}
