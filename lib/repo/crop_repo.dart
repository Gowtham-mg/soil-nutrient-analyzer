import 'package:soilnutrientanalyzer/model/crop.dart';

class TranslateRepo {
  // List<Crop> cropRepo = [
  //   Crop.named(name: S.of(context).Wheat, image: 'assets/images/wheat.png'),
  //   Crop.named(name: S.of(context).Rice, image: 'assets/images/rice.png'),
  //   Crop.named(name: S.of(context).Barley, image: 'assets/images/barley.png'),
  //   Crop.named(name: S.of(context).Maize, image: 'assets/images/maize.png'),
  //   Crop.named(name: S.of(context).pea, image: 'assets/images/pea.png'),
  //   Crop.named(name: S.of(context).chickpea, image: 'assets/images/chickpea.png'),
  //   Crop.named(name: S.of(context).sugarcane, image: 'assets/images/sugarcane.png'),
  //   Crop.named(name: S.of(context).cotton, image: 'assets/images/cotton.png'),
  //   Crop.named(name: S.of(context).jute, image: 'assets/images/jute.png'),
  //   Crop.named(name: S.of(context).tomato, image: 'assets/images/tomato.png'),
  //   Crop.named(name: S.of(context).banana, image: 'assets/images/banana.png'),
  //   Crop.named(name: S.of(context).chilli, image: 'assets/images/chilli.png'),
  //   Crop.named(name: S.of(context).carrot, image: 'assets/images/carrot.png'),
  //   Crop.named(name: S.of(context).spinach, image: 'assets/images/spinach.png'),
  //   Crop.named(name: S.of(context).tea, image: 'assets/images/tea.png'),
  //   Crop.named(name: S.of(context).coffee, image: 'assets/images/coffee.png'),
  // ];
  static List<Crop> crops = [
    Crop.named(name: 'Wheat', image: 'assets/images/wheat.png'),
    Crop.named(name: 'Rice', image: 'assets/images/rice.png'),
    Crop.named(name: 'Barley', image: 'assets/images/barley.png'),
    Crop.named(name: 'Maize', image: 'assets/images/maize.png'),
    Crop.named(name: 'Pea', image: 'assets/images/pea.png'),
    Crop.named(name: 'Chickpea', image: 'assets/images/chickpea.png'),
    Crop.named(name: 'Sugarcane', image: 'assets/images/sugarcane.png'),
    Crop.named(name: 'Cotton', image: 'assets/images/cotton.png'),
    Crop.named(name: 'Jute', image: 'assets/images/jute.png'),
    Crop.named(name: 'Tomato', image: 'assets/images/tomato.png'),
    Crop.named(name: 'Banana', image: 'assets/images/banana.png'),
    Crop.named(name: 'Chilli', image: 'assets/images/chilli.png'),
    Crop.named(name: 'Carrot', image: 'assets/images/carrot.png'),
    Crop.named(name: 'Spinach', image: 'assets/images/spinach.png'),
    Crop.named(name: 'Tea', image: 'assets/images/tea.png'),
    Crop.named(name: 'Coffee', image: 'assets/images/coffee.png'),
  ];

  static List<Crop> translate(String language) {
    final List<String> english = [
      "Rice",
      "Wheat",
      "Maize",
      "Barley",
      "Pea",
      "Chickpea",
      "Sugarcane",
      "Cotton",
      "Jute",
      "Tomato",
      "Banana",
      "Chilli",
      "Carrot",
      "Spinach",
      "Tea",
      "Coffee"
    ];
    final List<String> tamil = [
      "அரிசி",
      "கோதுமை",
      "சோளம்",
      "பார்லி",
      "பட்டாணி",
      "கடலை",
      "கரும்பு",
      "பருத்தி",
      "சணல்",
      "தக்காளி",
      "வாழை",
      "மிளகாய்",
      "கேரட்",
      "கீரை",
      "தேநீர்",
      "காப்பி"
    ];
    final List<String> hindi = [
      "चावल",
      "गेहूँ",
      "मक्का",
      "जौ",
      "मटर",
      "काबुली चना",
      "गन्ना",
      "कपास",
      "जूट",
      "टमाटर",
      "केला",
      "मिर्च",
      "गाजर",
      "पालक",
      "चाय",
      "कॉफ़ी"
    ];
    List<Crop> _crops = [];
    if (language == 'English') {
      for (var i = 0; i < crops.length; i++) {
        _crops.add(crops[i].copyWith(name: english[i]));
      }
    } else if (language == 'தமிழ்') {
      for (var i = 0; i < crops.length; i++) {
        _crops.add(crops[i].copyWith(name: tamil[i]));
      }
    } else if (language == 'हिन्दी') {
      for (var i = 0; i < crops.length; i++) {
        _crops.add(crops[i].copyWith(name: hindi[i]));
      }
    }
    return _crops;
  }

  static List<String> soliType(String language) {
    final List<String> soilTypeEnglish = [
      "Alluvial soils",
      "Black soils",
      "Red and Yellow soils",
      "Laterite soils",
      "Arid soils",
      "Saline soils",
      "Peaty soils",
      "Forest soils",
    ];
    final List<String> soilTypeTamil = [
      "வண்டல் மண்",
      "கரிசல் மண்",
      "செம்மண்",
      "லேட்டரைட் மண்",
      "வறண்ட மண்",
      "உப்பு மண்",
      "கரி மண்",
      "வன மண்",
    ];
    final List<String> soilTypeHindi = [
      "जलोढ़ मिट्टी",
      "काली मिट्टी",
      "लाल मिट्टी",
      "बाद की मिट्टी",
      "शुष्क मिट्टी",
      "खारी मिट्टी",
      "पीटती हुई मिट्टी",
      "जंगल की मिट्टी",
    ];

    if (language == 'English') {
      return soilTypeEnglish;
    } else if (language == 'தமிழ்') {
      return soilTypeTamil;
    } else {
      return soilTypeHindi;
    }
  }
}
