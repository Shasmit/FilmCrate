import 'dart:async';

import 'package:all_sensors/all_sensors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProximityBrightnessControl extends StatefulWidget {
  final Widget child;

  const ProximityBrightnessControl({Key? key, required this.child})
      : super(key: key);

  @override
  State<ProximityBrightnessControl> createState() =>
      _ProximityBrightnessControlState();
}

class _ProximityBrightnessControlState
    extends State<ProximityBrightnessControl> {
  double _proximityValue = 0;
  double _initialBrightness = 1.0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void dispose() {
    for (final subscription in _streamSubscription) {
      subscription.cancel();
    }
    // Reset the system brightness to the initial value when disposing
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.grey,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            _initialBrightness < 0.5 ? Brightness.light : Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
      });

      // Proximity values range from 0.0 (near) to 5.0 (far)
      double newBrightness = 1.0 - (_proximityValue / 5.0) * 0.9;

      // Ensure that brightness stays within valid range (0.1 to 1.0)
      newBrightness = newBrightness.clamp(0.1, 1.0);

      // Set the system brightness
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          systemNavigationBarDividerColor: Colors.grey,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              newBrightness < 0.5 ? Brightness.light : Brightness.dark,
        ),
      );

      // Save the initial brightness in case we want to reset it later
      if (_initialBrightness == 1.0) {
        _initialBrightness = newBrightness;
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
