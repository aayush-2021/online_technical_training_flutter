import 'package:permission_handler/permission_handler.dart';

/// This is a Permission Helper class to manage permission_handler package from pub.dev
class PermissionHelper {
  static Future<bool> requestAllPermissions() async {
    // You can request multiple permissions at once.
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.contacts,
      // Permission.location,
      // Permission.storage,
      // Permission.camera,
      Permission.notification,
    ].request();
    return true;
  }
}
