import AhgoraCore

final class MirrorModule {
	private init() {}

	static func setupModule() -> BaseView {
		let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Mirror"), bundle: Bundle.main)
		let viewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "MirrorViewController"))

		guard let view = viewController as? MirrorViewController else {
			Swift.fatalError("Should be an instance of MirrorViewController")
		}

		let apiProvider = Environment.instance.ahgoraProvider
		let appStateObservable = Environment.instance.appStateObservable
		let dateProvider = Environment.instance.dateProvider
		let appState = Environment.instance.appState

		let network = MirrorMoyaNetwork(provider: apiProvider)
		let interactor = MirrorService(network: network)
		let presenter = MirrorDefaultPresenter(view: view,
											   interactor: interactor,
											   appStateObservable: appStateObservable,
											   dateProvider: dateProvider,
											   appState: appState)

		view.presenter = presenter

		return view
	}
}
