import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(
			options: authOptions,
			completionHandler: { _, _ in }
		)
		
		application.registerForRemoteNotifications()
		
		return true
	}
}
