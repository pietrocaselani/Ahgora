import UIKit
import AhgoraCore

final class SettingsModule {
	private init() {}

	static func setupModule() -> SettingsView {
		let storyboard = UIStoryboard(name: "Settings", bundle: Bundle.main)
		let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
		guard let settingsViewController = viewController as? SettingsViewController else {
			Swift.fatalError("Can't instantiate settings view controller from storyboard")
		}

		let appStateOutput = Environment.instance.appStateOutput
		let appStateObservable = Environment.instance.appStateObservable
		let userDefaults = Environment.instance.userDefaults

		let dataSource = SettingsUserDefaultsDataSource(appStateOutput: appStateOutput, userDefaults: userDefaults)
		let interactor = SettingsService(dataSource: dataSource)
		let presenter = SettingsDefaultPresenter(view: settingsViewController, interactor: interactor, appStateObservable: appStateObservable)

		settingsViewController.presenter = presenter

		return settingsViewController
	}
}
