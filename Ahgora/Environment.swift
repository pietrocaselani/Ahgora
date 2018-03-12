import Foundation
import AhgoraCore
import Moya

public class Environment {
	public static let instance = Environment()
	let userDefaults: UserDefaults
	let appStateObservable: AppStateObservable
	let appStateOutput: AppStateOutput
	let dateProvider: DateProvider
	let ahgoraProvider: AhgoraAPIProvider
	var appState: AppState {
		return SettingsUserDefaultsDataSource.currentAppState(userDefaults: userDefaults)
	}

	private init() {
		self.userDefaults = UserDefaults.standard
		self.dateProvider = DefaultDateProvider()

		let appState = SettingsUserDefaultsDataSource.currentAppState(userDefaults: userDefaults)
		let appStateStore = AppStateStore(initialState: appState)

		self.appStateObservable = appStateStore
		self.appStateOutput = appStateStore

		self.ahgoraProvider = AhgoraBuilder { builder in
			builder.callbackQueue = DispatchQueue(label: "NetworkQueue", qos: .utility)
		}.build()
	}
}
