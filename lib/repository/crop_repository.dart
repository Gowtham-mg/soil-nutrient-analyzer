import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';

abstract class CropRepository {
  Future<AppResponse<List<String>>> translateSoilType(String language);
  Future<AppResponse<List<Crop>>> translateCrop(String language);
}

class CropFirebaseRepository extends CropRepository {
  @override
  Future<AppResponse<List<Crop>>> translateCrop(String language) {
    // TODO: implement translateCrop
    throw UnimplementedError();
  }

  @override
  Future<AppResponse<List<String>>> translateSoilType(String language) {
    // TODO: implement translateSoilType
    throw UnimplementedError();
  }
}
