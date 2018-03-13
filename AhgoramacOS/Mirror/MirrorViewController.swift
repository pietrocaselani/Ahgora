	import Cocoa
import AhgoraCore

final class MirrorViewController: NSViewController, MirrorView {
	typealias AhgoraMirror = AhgoraCore.Mirror
	var presenter: MirrorPresenter!

	private var mirrorDays = MirrorDays.empty
	private let dateFormatter = DateFormatter()

	@IBOutlet weak var infoTextField: NSTextField!
	@IBOutlet weak var nameTextField: NSTextField!
	@IBOutlet weak var hoursTextField: NSTextField!
	@IBOutlet weak var tableView: NSTableView!
	@IBOutlet weak var scrollView: NSScrollView!

	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			Swift.fatalError("view loaded without a presenter")
		}

		dateFormatter.dateStyle = .short

		tableView.dataSource = self
		tableView.delegate = self

		presenter.viewDidLoad()
	}

	func show(mirror: AhgoraMirror) {
		self.mirrorDays = mirror.days
		nameTextField.stringValue = mirror.employee.name
		hoursTextField.stringValue = mirror.results.map { "\($0.type): \($0.value)" }.joined(separator: " | ")

		infoTextField.isHidden = true
		nameTextField.isHidden = false
		hoursTextField.isHidden = false
		scrollView.isHidden = false

		tableView.reloadData()
	}

	func showMissingCredentials() {
		infoTextField.stringValue = "Vá em configurações para fazer o login"
		nameTextField.isHidden = true
		hoursTextField.isHidden = true
		scrollView.isHidden = true
		infoTextField.isHidden = false
	}

	func showError(message: String) {
		let alert = NSAlert()
		alert.addButton(withTitle: "OK")
		alert.messageText = message
		alert.alertStyle = .critical
		alert.runModal()
	}
}

extension MirrorViewController: NSTableViewDataSource {
	func numberOfRows(in tableView: NSTableView) -> Int {
		return mirrorDays.days.count
	}
}

extension MirrorViewController: NSTableViewDelegate {
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let mirrorDay = mirrorDays.days[row]

		let cellIdentifier: String
		let cellValue: String

		if tableColumn == tableView.tableColumns[0] {
			cellIdentifier = "mirrorDayCell"
			cellValue = dateFormatter.string(from: mirrorDay.date)
		} else if tableColumn == tableView.tableColumns[1] {
			cellIdentifier = "mirrorPunchCell"
			cellValue = mirrorDay.punches.map { $0.hour }.joined(separator: ", ")
		} else if tableColumn == tableView.tableColumns[2] {
			cellIdentifier = "mirrorResultCell"
			cellValue = mirrorDay.results.map { "\($0.type): \($0.value)" }.joined(separator: " | ")
		} else {
			fatalError("WTF!")
		}

		guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView else {
			return nil
		}

		cell.textField?.stringValue = cellValue

		return cell
	}
}
