class HueLight {
  final String id;
  final String name;
  final bool on;
  final int brightness;
  final bool reachable;

  const HueLight({
    required this.id,
    required this.name,
    required this.on,
    required this.brightness,
    required this.reachable,
  });

  factory HueLight.fromJson(
    String id,
    Map<String, dynamic> json,
  ) {
    final state = json['state'];

    return HueLight(
      id: id,
      name: json['name'] ?? 'Lampe',
      on: state['on'] ?? false,
      brightness: state['bri'] ?? 0,
      reachable: state['reachable'] ?? false,
    );
  }

  HueLight copyWith({
    bool? on,
    int? brightness,
  }) {
    return HueLight(
      id: id,
      name: name,
      on: on ?? this.on,
      brightness: brightness ?? this.brightness,
      reachable: reachable,
    );
  }
}