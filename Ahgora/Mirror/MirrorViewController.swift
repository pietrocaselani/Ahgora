import UIKit
import AhgoraCore
import RMDateSelectionViewController

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
	@IBOutlet weak var updateButton: UIButton!
	private var currentDate = Date()
	private var admissionDate = Date(timeIntervalSince1970: 0)

	@IBAction func changeMonth(_ sender: Any) {
		let selectAction = RMAction<UIDatePicker>(title: "Selecionar", style: .done) { [weak self] controller in
			self?.fetchMirror(for: controller.contentView.date)
			self?.dismiss(animated: true, completion: nil)
		}

		let cancelAction = RMAction<UIDatePicker>(title: "Cancelar", style: .cancel) { [weak self] controller in
			self?.dismiss(animated: true, completion: nil)
		}

		guard let dateController = RMDateSelectionViewController(style: .default,
														   title: nil,
														   message: "Selecione um mês e ano",
														   select: selectAction,
														   andCancel: cancelAction) else { return }

		dateController.datePicker.minimumDate = admissionDate
		dateController.datePicker.datePickerMode = .date
		dateController.datePicker.date = currentDate

		present(dateController, animated: true, completion: nil)
	}

	@IBAction func update(_ sender: Any) {
		self.fetchMirror(for: currentDate)
	}

	private func fetchMirror(for date: Date) {
		self.currentDate = date

		let calendar = Calendar.current
		let month = calendar.component(.month, from: date)
		let year = calendar.component(.year, from: date)

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/yyyy"
		changeMonthButton.setTitle(dateFormatter.string(from: date), for: .normal)

		presenter.mirrorFor(month: month, year: year)
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
		updateButton.isHidden = true
	}

	func showError(message: String) {
		let controller = UIAlertController.createErrorAlert(message: message)

		present(controller, animated: true, completion: nil)
	}

	func show(mirror: AhgoraMirror, for date: Date) {
		let today = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"

		self.admissionDate = dateFormatter.date(from: mirror.employee.admissionDate) ?? today
		self.currentDate = date

		employeeLabel.text = mirror.employee.name
		hoursLabel.text = mirror.results.map { "\($0.type): \($0.value)" }.joined(separator: " | ")
		self.mirrorDays = mirror.days

		infoLabel.isHidden = true
		tableView.isHidden = false
		employeeLabel.isHidden = false
		hoursLabel.isHidden = false
		changeMonthButton.isHidden = false
		updateButton.isHidden = false

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
		cell.detailTextLabel?.text = day.punches.map { $0.hour }.joined(separator: ", ")

		return cell
	}
}
