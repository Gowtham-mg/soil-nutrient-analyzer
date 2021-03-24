import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/data_model.dart';

abstract class ResultsRepository {
  Future<AppResponse<DataModel>> translateSoilType(String language);
}

class ResultsFriebaseRepository extends ResultsRepository {
  @override
  Future<AppResponse<DataModel>> translateSoilType(String language) {
    // TODO: implement translateSoilType
    throw UnimplementedError();
  }
}
