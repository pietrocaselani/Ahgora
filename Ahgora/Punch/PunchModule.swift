import UIKit
import AhgoraCore

final class PunchModule {
	private init() {}

	static func setupModule() -> BaseView {
		let storyboard = UIStoryboard(name: "Punch", bundle: Bundle.main)
		let viewController = storyboard.instantiateViewController(withIdentifier: "PunchViewController")
		guard let view = viewController as? PunchViewController else {
			Swift.fatalError("Can't instantiate settings view controller from storyboard")
		}

		let apiProvider = Environment.instance.ahgoraProvider
		let appStateObservable = Environment.instance.appStateObservable
		let appState = Environment.instance.appState

		let network = PunchMoyaNetwork(provider: apiProvider)
		let interactor = PunchService(network: network)
		let presenter = PunchDefaultPresenter(view: view, interactor: interactor, appStateObservable: appStateObservable, appState: appState)

		view.presenter = presenter

		return view
	}
}
