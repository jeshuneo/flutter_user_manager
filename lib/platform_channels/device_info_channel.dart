import 'package:flutter/services.dart';

class DeviceInfoChannel {
  static const MethodChannel _channel = MethodChannel(
    'com.example.user_manager/device_info',
  );

  // Get device information from native platform
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        'getDeviceInfo',
      );
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get device info: ${e.message}');
    }
  }

  // Check if device has biometric authentication
  static Future<bool> hasBiometricAuth() async {
    try {
      final bool result = await _channel.invokeMethod('hasBiometricAuth');
      return result;
    } on PlatformException catch (e) {
      throw Exception('Failed to check biometric auth: ${e.message}');
    }
  }

  // Get device orientation lock status
  static Future<bool> isOrientationLocked() async {
    try {
      final bool result = await _channel.invokeMethod('isOrientationLocked');
      return result;
    } on PlatformException catch (e) {
      throw Exception('Failed to get orientation lock status: ${e.message}');
    }
  }
}
