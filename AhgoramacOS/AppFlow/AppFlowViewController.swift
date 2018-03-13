import Cocoa
import AhgoraCore

final class AppFlowViewController: NSTabViewController, AppFlowView {
	var presenter: AppFlowPresenter!

	override func viewDidLoad() {
		guard presenter != nil else {
			Swift.fatalError("View loaded without a presenter")
		}

		super.viewDidLoad()

		presenter.viewDidLoad()
	}

	func show(pages: [ModulePage]) {
		pages.map { page -> NSTabViewItem in
			guard let viewController = page.view as? NSViewController else {
				Swift.fatalError("should be an instance of NSViewController")
			}

			viewController.title = page.title

			return NSTabViewItem(viewController: viewController)
			}.forEach { [weak self] tabItem in
				self?.addTabViewItem(tabItem)
		}

		if pages.count > 0 {
			self.selectedTabViewItemIndex = 0
		}
	}

}
