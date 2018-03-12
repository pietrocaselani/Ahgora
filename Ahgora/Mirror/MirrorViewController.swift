import UIKit
import AhgoraCore

final class MirrorViewController: UIViewController, MirrorView {
	typealias AhgoraMirror = AhgoraCore.Mirror

	var presenter: MirrorPresenter!
	private var mirrorDays = MirrorDays.empty
	private let dateFormatter = DateFormatter()
	
	@IBOutlet weak var infoLabel: UILabel!
	@IBOutlet weak var employeeLabel: UILabel!
	@IBOutlet weak var hoursLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var changeMonthButton: UIButton!

	@IBAction func changeMonth(_ sender: Any) {
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			Swift.fatalError("view loaded without a presenter")
		}

		dateFormatter.dateStyle = .short
		tableView.dataSource = self

		presenter.viewDidLoad()
	}

	func showMissingCredentials() {
		infoLabel.text = "Vá em Configurações para atualizar suas credenciais"
		infoLabel.isHidden = false
		tableView.isHidden = true
		employeeLabel.isHidden = true
		hoursLabel.isHidden = true
		changeMonthButton.isHidden = true
	}

	func showError(message: String) {
		let controller = UIAlertController.createErrorAlert(message: message)

		present(controller, animated: true, completion: nil)
	}

	func show(mirror: AhgoraMirror) {
		employeeLabel.text = mirror.employee.name
		hoursLabel.text = mirror.results.map { "\($0.type): \($0.value)" }.joined(separator: " | ")
		self.mirrorDays = mirror.days

		infoLabel.isHidden = true
		tableView.isHidden = false
		employeeLabel.isHidden = false
		hoursLabel.isHidden = false
		changeMonthButton.isHidden = false

		tableView.reloadData()
	}
}

extension MirrorViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mirrorDays.days.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MirrorDayCell", for: indexPath)

		let day = mirrorDays.days[indexPath.row]

		let dateText = dateFormatter.string(from: day.date)
		let resultsText = day.results.map { "\($0.type): \($0.value)" }.joined(separator: " | ")

		cell.textLabel?.text = "\(dateText) \(resultsText)"
		cell.detailTextLabel?.text = day.puches.map { $0.hour }.joined(separator: ", ")

		return cell
	}
}
