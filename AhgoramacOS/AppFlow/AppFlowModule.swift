import Cocoa
import AhgoraCore

final class AppFlowModule {
	private init() {}

	static func setupModule() -> BaseView {
		let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "AppFlow"), bundle: Bundle.main)
		let viewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AppFlowViewController"))

		guard let view = viewController as? AppFlowViewController else {
			Swift.fatalError("Should be an instance of AppFlowViewController")
		}

		let moduleDataSource = AppFlowMacOSCreator()
		let presenter = AppFlowDefaultPresenter(view: view, dataSource: moduleDataSource)

		view.presenter = presenter

		return view
	}
}
