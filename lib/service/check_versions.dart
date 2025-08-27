import 'package:package_info_plus/package_info_plus.dart';

int compareVersions(String v1, String v2) {
  List<int> v1Parts = v1.split('.').map(int.parse).toList();
  List<int> v2Parts = v2.split('.').map(int.parse).toList();

  for (int i = 0; i < v1Parts.length || i < v2Parts.length; i++) {
    int part1 = i < v1Parts.length ? v1Parts[i] : 0;
    int part2 = i < v2Parts.length ? v2Parts[i] : 0;

    if (part1 > part2) return 1;
    if (part1 < part2) return -1;
  }
  return 0;
}

Future<bool> isAvailableApp(String version) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return compareVersions(packageInfo.version, version) >= 0;
}

Future<String> getAppVersion()async{
  return (await PackageInfo.fromPlatform()).version;
}
