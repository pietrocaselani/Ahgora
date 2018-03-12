import AhgoraCore
import UIKit

final class AppFlowModule {
	private init() {}
	
	static func setupModule() -> BaseView {
		let storyboard = UIStoryboard(name: "AppFlow", bundle: Bundle.main)
		let viewController = storyboard.instantiateViewController(withIdentifier: "AppFlowViewController")
		guard let view = viewController as? AppFlowViewController else {
			Swift.fatalError("Can't instantiate settings view controller from storyboard")
		}

		let moduleDataSource = AppFlowiOSModuleDataSource()
		let presenter = AppFlowDefaultPresenter(view: view, dataSource: moduleDataSource)

		view.presenter = presenter

		return view
	}
}
