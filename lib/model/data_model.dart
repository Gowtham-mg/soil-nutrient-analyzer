import 'dart:convert';

class DataModel {
  final String ph;
  final String temperature;
  final String moisture;
  final String npkRatio;
  DataModel.named({
    this.ph,
    this.temperature,
    this.moisture,
    this.npkRatio,
  });

  DataModel(
    this.ph,
    this.temperature,
    this.moisture,
    this.npkRatio,
  );

  DataModel copyWith({
    String ph,
    String temperature,
    String moisture,
    String npkRatio,
  }) {
    return DataModel.named(
      ph: ph ?? this.ph,
      temperature: temperature ?? this.temperature,
      moisture: moisture ?? this.moisture,
      npkRatio: npkRatio ?? this.npkRatio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ph': ph,
      'temperature': temperature,
      'moisture': moisture,
      'npkRatio': npkRatio,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DataModel.named(
      ph: map['ph'],
      temperature: map['temperature'],
      moisture: map['moisture'],
      npkRatio: map['npkRatio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DataModel(ph: $ph, temperature: $temperature, moisture: $moisture, npkRatio: $npkRatio)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DataModel &&
        o.ph == ph &&
        o.temperature == temperature &&
        o.moisture == moisture &&
        o.npkRatio == npkRatio;
  }

  @override
  int get hashCode {
    return ph.hashCode ^
        temperature.hashCode ^
        moisture.hashCode ^
        npkRatio.hashCode;
  }
}
