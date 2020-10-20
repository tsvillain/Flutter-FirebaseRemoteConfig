import 'package:flutter/material.dart';
import 'package:flutter_firebase/Services/remote_config_service.dart';

class RemoteConfig extends StatefulWidget {
  @override
  _RemoteConfigState createState() => _RemoteConfigState();
}

class _RemoteConfigState extends State<RemoteConfig> {
  bool isLoading = true;
  RemoteConfigService _remoteConfigService;

  initializeRemoteConfig() async {
    _remoteConfigService = await RemoteConfigService.getInstance();
    await _remoteConfigService.initialize();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    initializeRemoteConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: _remoteConfigService.getBoolValue
                  ? Colors.amber
                  : Colors.blue,
              child: Center(
                child: Text(_remoteConfigService.getStringValue),
              ),
            ),
    );
  }
}
