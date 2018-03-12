import UIKit
import AhgoraCore

final class MirrorModule {
	private init() {}

	static func setupModule() -> MirrorView {
		let storyboard = UIStoryboard(name: "Mirror", bundle: Bundle.main)
		let viewController = storyboard.instantiateViewController(withIdentifier: "MirrorViewController")
		guard let mirrorViewController = viewController as? MirrorViewController else {
			Swift.fatalError("Can't instantiate settings view controller from storyboard")
		}

		let appStateObservable = Environment.instance.appStateObservable
		let dateProvider = Environment.instance.dateProvider
		let apiProvider = Environment.instance.ahgoraProvider
		let appState = Environment.instance.appState

		let network = MirrorMoyaNetwork(provider: apiProvider)
		let interactor = MirrorService(network: network)
		let presenter = MirrorDefaultPresenter(view: mirrorViewController,
											   interactor: interactor,
											   appStateObservable: appStateObservable,
											   dateProvider: dateProvider,
											   appState: appState)

		mirrorViewController.presenter = presenter

		return mirrorViewController
	}
}

