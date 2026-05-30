import 'dart:async';

import 'package:flutter/material.dart';

import '../models/hue_light.dart';
import '../services/hue_service.dart';

class LightProvider extends ChangeNotifier {
  final HueService _service = HueService();

  HueLight? light;

  bool loading = true;

  Timer? _pollTimer;

  LightProvider() {
    initialize();
  }

  Future<void> initialize() async {
    await refresh();

    _pollTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => refresh(),
    );
  }

  Future<void> refresh() async {
    try {
      light = await _service.getLight();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> toggle() async {
    if (light == null) return;

    final newState = !light!.on;

    await _service.setLight(
      on: newState,
      brightness: light!.brightness,
    );

    light = light!.copyWith(
      on: newState,
    );

    notifyListeners();
  }

  Future<void> setBrightness(double value) async {
    if (light == null) return;

    final bri = value.round();

    light = light!.copyWith(
      brightness: bri,
      on: bri > 0,
    );

    notifyListeners();

    await _service.setLight(
      on: bri > 0,
      brightness: bri,
    );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }
}