import Cocoa
import AhgoraCore

final class SettingsModule {
	private init() {}

	static func setupModule() -> BaseView {
		let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Settings"), bundle: Bundle.main)
		let viewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SettingsViewController"))

		guard let view = viewController as? SettingsViewController else {
			Swift.fatalError("Should be an instance of SettingsViewController")
		}

		let appStateOutput = Environment.instance.appStateOutput
		let appStateObservable = Environment.instance.appStateObservable
		let userDefaults = Environment.instance.userDefaults

		let dataSource = SettingsUserDefaultsDataSource(appStateOutput: appStateOutput, userDefaults: userDefaults)
		let interactor = SettingsService(dataSource: dataSource)
		let presenter = SettingsDefaultPresenter(view: view, interactor: interactor, appStateObservable: appStateObservable)

		view.presenter = presenter

		return view
	}
}
