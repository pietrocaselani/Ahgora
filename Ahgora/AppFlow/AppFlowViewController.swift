import UIKit
import AhgoraCore

final class AppFlowViewController: UITabBarController, AppFlowView {
	var presenter: AppFlowPresenter!

	override func viewDidLoad() {
		super.viewDidLoad()

		guard presenter != nil else {
			fatalError("view loaded without presenter")
		}

		presenter.viewDidLoad()
	}

	func show(pages: [ModulePage]) {
		let viewControllers = pages.map { page -> UIViewController in
			guard let viewController = page.view as? UIViewController else {
				fatalError("page should be an instance of UIViewController")
			}

			viewController.title = page.title
			return viewController
		}

		self.viewControllers = viewControllers
	}
}
