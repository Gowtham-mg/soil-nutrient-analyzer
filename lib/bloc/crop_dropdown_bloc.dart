import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/repository/crop_repository.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final CropRepository cropRepository;
  LanguageCubit(this.cropRepository) : super(LanguageInitialState());

  void updateLanguage(String language, LanguageSuccessState langState) async {
    emit(LanguageLoadingState());
    AppResponse<Map<String, String>> basicWords =
        await cropRepository.translateBasicWords(language);
    AppResponse<List<Crop>> crops =
        await cropRepository.translateCrop(language);
    AppResponse<List<String>> soilType =
        await cropRepository.translateSoilType(language);
    if (soilType.isSuccess && basicWords.isSuccess && crops.isSuccess) {
      if (langState == null) {
        emit(LanguageSuccessState.named(
          basicWords: basicWords.data,
          crops: crops.data,
          selectedCrop: crops.data.first,
          selectedSoil: soilType.data.first,
          soils: soilType.data,
        ));
      } else {
        int selectedCropIndex = langState.crops.indexWhere(
            (element) => element.name == langState.selectedCrop.name);
        int selectedSoilIndex = langState.soils
            .indexWhere((element) => element == langState.selectedSoil);
        emit(LanguageSuccessState.named(
          basicWords: basicWords.data,
          crops: crops.data,
          selectedCrop: crops.data[selectedCropIndex],
          selectedSoil: soilType.data[selectedSoilIndex],
          soils: soilType.data,
        ));
      }
    } else {
      emit(LanguageErrorState(
          basicWords.error ?? crops.error ?? soilType.error));
    }
  }

  void updateCrop(LanguageSuccessState langState, Crop selectedCrop) {
    emit(langState.copyWith(selectedCrop: selectedCrop));
  }

  void updateSoil(LanguageSuccessState langState, String selectedSoil) {
    emit(langState.copyWith(selectedSoil: selectedSoil));
  }
}

abstract class LanguageState extends Equatable {}

class LanguageSuccessState extends LanguageState {
  final List<Crop> crops;
  final Crop selectedCrop;
  final List<String> soils;
  final String selectedSoil;
  final Map<String, String> basicWords;

  LanguageSuccessState(this.crops, this.selectedCrop, this.soils,
      this.selectedSoil, this.basicWords);
  LanguageSuccessState.named({
    this.crops,
    this.selectedCrop,
    this.soils,
    this.selectedSoil,
    this.basicWords,
  });

  LanguageSuccessState copyWith({
    List<Crop> crops,
    Crop selectedCrop,
    List<String> soils,
    String selectedSoil,
    Map<String, String> basicWords,
  }) {
    return LanguageSuccessState.named(
      crops: crops ?? this.crops,
      selectedCrop: selectedCrop ?? this.selectedCrop,
      soils: soils ?? this.soils,
      selectedSoil: selectedSoil ?? this.selectedSoil,
      basicWords: basicWords ?? this.basicWords,
    );
  }

  @override
  List<Object> get props => [
        this.crops,
        this.selectedCrop,
        this.selectedSoil,
        this.soils,
        this.basicWords
      ];
}

class LanguageInitialState extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageLoadingState extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageErrorState extends LanguageState {
  final String error;

  LanguageErrorState(this.error);
  @override
  List<Object> get props => [];
}
