import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synrg/synrg.dart';
import 'package:uuid/uuid.dart';

/// This function sets the id for all all the app monitoring services
Future<void> setUserId(String? userId, {String? id}) async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo = await deviceInfoPlugin.deviceInfo;
  final deviceId = await _getDeviceIdentifier(deviceInfo);
  if (id == null) {
    SynrgCrashlytics.instance.setUserIdentifier('anonymous-$deviceId');
    await SynrgAnalytics.instance.setUserId('anonymous-$deviceId');
  } else {
    SynrgCrashlytics.instance.setUserIdentifier('$id-$deviceId');
    await SynrgAnalytics.instance.setUserId('$id-$deviceId');
  }
}

/// Retrieves a unique identifier best suited for each platform
Future<String> _getDeviceIdentifier(BaseDeviceInfo deviceInfo) async {
  final prefs = await SharedPreferences.getInstance();

  if (deviceInfo is AndroidDeviceInfo) {
    return deviceInfo.id;
  } else if (deviceInfo is IosDeviceInfo) {
    return deviceInfo.identifierForVendor ??
        await _getOrGenerateId(prefs, 'iosDeviceId');
  } else if (deviceInfo is WindowsDeviceInfo) {
    return _getOrGenerateId(prefs, 'windowsDeviceId');
  } else if (deviceInfo is LinuxDeviceInfo) {
    return _getOrGenerateId(prefs, 'linuxDeviceId');
  } else if (deviceInfo is MacOsDeviceInfo) {
    return deviceInfo.systemGUID ??
        await _getOrGenerateId(prefs, 'macOsDeviceId');
  } else if (deviceInfo is WebBrowserInfo) {
    return _getOrGenerateId(prefs, 'webDeviceId');
  }

  // Fallback for any other cases
  return _getOrGenerateId(prefs, 'genericDeviceId');
}

/// Gets an existing ID from SharedPreferences or generates and stores a new one
Future<String> _getOrGenerateId(SharedPreferences prefs, String key) async {
  var id = prefs.getString(key);
  if (id == null) {
    id = const Uuid().v4();
    await prefs.setString(key, id);
  }
  return id;
}
