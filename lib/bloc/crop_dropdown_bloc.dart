import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/repo/crop_repo.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final List<Crop> crops;
  final List<String> soils;
  LanguageCubit(this.crops, this.soils)
      : super(LanguageState.named(
          crops: crops,
          selectedCrop:
              Crop.named(name: 'Rice', image: 'assets/images/rice.png'),
          soils: soils,
          selectedSoil: 'Black soils',
        ));

  void updateLanguage(BuildContext context, String language) {
    List<Crop> _crops = TranslateRepo.translate(language);
    Crop crop = _crops
        .firstWhere((element) => element.image == state.selectedCrop.image);
    int index = state.soils.indexOf(state.selectedSoil);
    List<String> _soils = TranslateRepo.soliType(language);
    emit(state.copyWith(
      selectedCrop: crop,
      crops: _crops,
      selectedSoil: _soils[index],
      soils: _soils,
    ));
  }

  void updateCrop(Crop crop) {
    emit(state.copyWith(selectedCrop: crop));
  }

  void updateSoil(String _soil) {
    emit(state.copyWith(selectedSoil: _soil));
  }
}

class LanguageState extends Equatable {
  final List<Crop> crops;
  final Crop selectedCrop;
  final List<String> soils;
  final String selectedSoil;

  LanguageState(this.crops, this.selectedCrop, this.soils, this.selectedSoil);
  LanguageState.named({
    this.crops,
    this.selectedCrop,
    this.soils,
    this.selectedSoil,
  });

  LanguageState copyWith({
    List<Crop> crops,
    Crop selectedCrop,
    List<String> soils,
    String selectedSoil,
  }) {
    return LanguageState.named(
      crops: crops ?? this.crops,
      selectedCrop: selectedCrop ?? this.selectedCrop,
      soils: soils ?? this.soils,
      selectedSoil: selectedSoil ?? this.selectedSoil,
    );
  }

  @override
  List<Object> get props =>
      [this.crops, this.selectedCrop, this.selectedSoil, this.soils];
}
