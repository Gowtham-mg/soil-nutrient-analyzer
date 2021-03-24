import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/model/data_model.dart';
import 'package:soilnutrientanalyzer/repository/results_repository.dart';

class ResultCubit extends Cubit<ResultState> {
  final ResultsRepository resultsRepository;
  ResultCubit(this.resultsRepository) : super(ResultInitial());

  void getResult(Crop selectedCrop, String temp, String moisture) async {
    emit(ResultLoading());
    AppResponse<DataModel> result =
        await resultsRepository.cropResults(selectedCrop);
    if (result.isSuccess) {
      ResultSuccess success = ResultSuccess(
        result.data,
        selectedCrop,
        temp,
        moisture,
      );
      await resultsRepository.saveResult(success);
      emit(success);
    } else {
      emit(ResultError(result.error));
    }
  }
}

abstract class ResultState extends Equatable {}

class ResultInitial extends ResultState {
  @override
  List<Object> get props => [];
}

class ResultLoading extends ResultState {
  @override
  List<Object> get props => [];
}

class ResultSuccess extends ResultState {
  final DataModel result;
  final Crop crop;
  final String temp;
  final String moisture;
  ResultSuccess(this.result, this.crop, this.temp, this.moisture);

  ResultSuccess.named({this.result, this.crop, this.temp, this.moisture});

  ResultSuccess copyWith(
      {DataModel result, Crop crop, String temp, String moisture}) {
    return ResultSuccess.named(
      result: result ?? this.result,
      crop: crop ?? this.crop,
      temp: temp ?? this.temp,
      moisture: moisture ?? this.moisture,
    );
  }

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return {
      'result': result.toMap(),
      'crop': crop.toMap(),
      'temp': temp,
      'moisture': moisture,
    };
  }

  factory ResultSuccess.fromMap(Map<String, dynamic> map) {
    return ResultSuccess.named(
      result: DataModel.fromMap(map['result']),
      crop: Crop.fromMap(map['crop']),
      temp: map['temp'],
      moisture: map['moisture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSuccess.fromJson(String source) =>
      ResultSuccess.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResultSuccess(result: $result, crop: $crop, temp: $temp, moisture: $moisture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultSuccess &&
        other.result == result &&
        other.crop == crop &&
        other.temp == temp &&
        other.moisture == moisture;
  }

  @override
  int get hashCode {
    return result.hashCode ^ crop.hashCode ^ temp.hashCode ^ moisture.hashCode;
  }
}

class ResultError extends ResultState {
  final String error;

  ResultError(this.error);
  @override
  List<Object> get props => [];
}
