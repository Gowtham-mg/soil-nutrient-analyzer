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
      emit(ResultSuccess(
        result.data,
        selectedCrop,
        temp,
        moisture,
      ));
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
  @override
  List<Object> get props => [];
}

class ResultError extends ResultState {
  final String error;

  ResultError(this.error);
  @override
  List<Object> get props => [];
}
