import AhgoraCore

final class PunchModule {
	private init() {}

	static func setupModule() -> BaseView {
		let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Punch"), bundle: Bundle.main)
		let viewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PunchViewController"))

		guard let view = viewController as? PunchViewController else {
			Swift.fatalError("Should be an instance of PunchViewController")
		}

		let appState = Environment.instance.appState
		let appStateObservable = Environment.instance.appStateObservable
		let apiProvider = Environment.instance.ahgoraProvider

		let network = PunchMoyaNetwork(provider: apiProvider)
		let interactor = PunchService(network: network)
		let presenter = PunchDefaultPresenter(view: view, interactor: interactor, appStateObservable: appStateObservable, appState: appState)

		view.presenter = presenter

		return view
	}
}
