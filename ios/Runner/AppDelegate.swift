import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)
    
    // Set up method channel
    let controller = window?.rootViewController as! FlutterViewController
    let deviceChannel = FlutterMethodChannel(
      name: "com.example.user_manager/device_info",
      binaryMessenger: controller.binaryMessenger
    )
    
    deviceChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "getDeviceInfo":
        self?.getDeviceInfo(result: result)
      case "hasBiometricAuth":
        self?.hasBiometricAuth(result: result)
      case "isOrientationLocked":
        self?.isOrientationLocked(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getDeviceInfo(result: FlutterResult) {
    let device = UIDevice.current
    let info: [String: Any] = [
      "model": device.model,
      "systemName": device.systemName,
      "systemVersion": device.systemVersion,
      "identifierForVendor": device.identifierForVendor?.uuidString ?? ""
    ]
    result(info)
  }
  
  private func hasBiometricAuth(result: FlutterResult) {
    // Implementation for biometric check
    result(true)
  }
  
  private func isOrientationLocked(result: FlutterResult) {
    // Implementation for orientation lock check
    result(false)
  }
}