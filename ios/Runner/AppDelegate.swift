import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GMSServices.provideAPIKey("AIzaSyD7qHr3Ux1Ufesom3IM5Ftmu9iPOL6KpYQ")
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self UNUserNotificationCenterDelegate
}

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
