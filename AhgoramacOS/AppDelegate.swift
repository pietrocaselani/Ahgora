import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	@IBOutlet weak var window: NSWindow!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		guard let viewController = AppFlowModule.setupModule() as? NSViewController else {
			Swift.fatalError("view should be an instance of NSViewController")
		}

		window.contentViewController = viewController
		window.makeKeyAndOrderFront(nil)
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
}

