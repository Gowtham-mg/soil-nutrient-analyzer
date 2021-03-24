import 'dart:convert';

import 'package:equatable/equatable.dart';

class Crop extends Equatable {
  final String name;
  final String image;
  Crop(this.name, this.image);
  Crop.named({this.name, this.image});

  Crop copyWith({String name, String image}) {
    return Crop.named(name: name ?? this.name, image: image ?? this.image);
  }

  @override
  List<Object> get props => [name, image];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop.named(
      name: map['name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Crop.fromJson(String source) => Crop.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
