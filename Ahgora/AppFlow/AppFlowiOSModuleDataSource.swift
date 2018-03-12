import AhgoraCore

final class AppFlowiOSModuleDataSource: AppFlowModuleDataSource {
	var modulePages: [ModulePage]

	init() {
		let punchView = PunchModule.setupModule()
		let punchPage = ModulePage(view: punchView, title: "Ponto")

		let mirrorView = MirrorModule.setupModule()
		let mirrorPage = ModulePage(view: mirrorView, title: "Espelho")

		let settingsView = SettingsModule.setupModule()
		let settingsPage = ModulePage(view: settingsView, title: "Configurações")

		self.modulePages = [punchPage, mirrorPage, settingsPage]
	}
}
