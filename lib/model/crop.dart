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
  List<Object> get props => [this.image, this.name];
}
