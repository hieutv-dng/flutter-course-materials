import '../constants.dart';
import '../strings.dart';

enum Domain {
  ios(Constants.iosDomain, Constants.iosFilter, Strings.ios),
  android(Constants.androidDomain, Constants.androidFilter, Strings.android),
  flutter(Constants.flutterDomain, Constants.flutterFilter, Strings.flutter),
  sss(Constants.sssDomain, Constants.sssFilter, Strings.sss),
  unity(Constants.unityDomain, Constants.unityFilter, Strings.unity),
  macos(Constants.macosDomain, Constants.macosFilter, Strings.macos),
  archived(
      Constants.archivedDomain, Constants.archivedFilter, Strings.archived),
  all('', Constants.allFilter, Strings.all),
  unknown('unknow', Constants.allFilter, Strings.unknown);

  final String id;
  final int value;
  final String name;

  const Domain(this.id, this.value, this.name);

  static List<Domain> get filters =>
      values.where((e) => e != Domain.unknown).toList();

  static Domain getDomain(String domainId) {
    for (var e in values) {
      if (e.id == domainId) {
        return e;
      }
    }
    return Domain.unknown;
  }
}
