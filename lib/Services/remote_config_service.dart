import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _BOOLEAN_VALUE = 'sample_bool_value';
const String _INT_VALUE = 'sample_int_value';
const String _STRING_VALUE = 'sample_string_value';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    _BOOLEAN_VALUE: false,
    _INT_VALUE: 01,
    _STRING_VALUE: "Flutter Firebase",
  };

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }
    return _instance;
  }

  bool get getBoolValue => _remoteConfig.getBool(_BOOLEAN_VALUE);
  int get getIntValue => _remoteConfig.getInt(_INT_VALUE);
  String get getStringValue => _remoteConfig.getString(_STRING_VALUE);

  Future initialize() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (e) {
      print("Rmeote Config fetch throttled: $e");
    } catch (e) {
      print("Unable to fetch remote config. Default value will be used");
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: Duration(seconds: 0));
    await _remoteConfig.activateFetched();
    print("boolean::: $getBoolValue");
    print("int::: $getIntValue");
    print("string::: $getStringValue");
  }
}
