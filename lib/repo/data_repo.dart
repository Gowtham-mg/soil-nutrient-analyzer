import 'package:soilnutrientanalyzer/model/data_model.dart';

List<Map<String, DataModel>> repo = [
  {
    'Wheat|கோதுமை|गेहूँ': DataModel.named(
      moisture: '60 -100 percent',
      npkRatio: '60:30:30 kg NPK/ha',
      ph: '6.0-7.0',
      temperature: '20°C - 25°C',
    )
  },
  {
    'Rice|அரிசி|चावल': DataModel.named(
      moisture: '0 - 80 percent',
      npkRatio: '30:10:10 kg NPK/ha',
      ph: '5.0-8.0',
      temperature: '25°C and 35°C',
    )
  },
  {
    'Barely|பார்லி|मक्का': DataModel.named(
      moisture: '0 - 50  percent',
      npkRatio: '165:60:85 kg NPK/ha',
      ph: '5.0-6.0',
      temperature: '12°C - 15°C',
    )
  },
  {
    'Maize|சோளம்|जौ': DataModel.named(
      moisture: '10 - 45 percent',
      npkRatio: '60:30:30 kg NPK/ha',
      ph: '6.0-7.0',
      temperature: '18°C and 27°C C',
    )
  },
  {
    'Pea|பட்டாணி|मटर': DataModel.named(
      moisture: '0 - 50 percent',
      npkRatio: '15:15:15 kg NPK/ha',
      ph: '5.8-6.2',
      temperature: '21°C and 30°C',
    )
  },
  {
    'Chickpea|கொண்டைக்கடலை|काबुली चना': DataModel.named(
      moisture: '0 - 50 percent',
      npkRatio: '15:15:15 kg NPK/ha',
      ph: '5.8-6.2',
      temperature: '21°C and 30°C',
    )
  },
  {
    'Sugarcane|கரும்பு|गन्ना': DataModel.named(
      moisture: '0 - 50 percent',
      npkRatio: '300:100:200 kg NPK/ha',
      ph: '6.5-7.5',
      temperature: '20°C and 26°C',
    )
  },
  {
    'Cotton|பருத்தி|कपास': DataModel.named(
      moisture: '80 - 100 percent',
      npkRatio: '100:50:50 kg NPK/ha',
      ph: '5.8-8.0',
      temperature: '20°C and 32°C',
    )
  },
  {
    'Jute|சணல்|जूट': DataModel.named(
      moisture: '40 - 90 percent',
      npkRatio: '40:20:20 kg NPK/ha',
      ph: '6.0-7.5',
      temperature: '17° C and 41°C',
    )
  },
  {
    'Tomato|தக்காளி|टमाटर': DataModel.named(
      moisture: '50 - 100 percent',
      npkRatio: '8:32:16 NPK/ha',
      ph: '6.0-6.8',
      temperature: '18.5°C and 26.5°C',
    )
  },
  {
    'Banana|வாழை|केला': DataModel.named(
      moisture: '40 - 60 percent',
      npkRatio: '1:0:3 kg NPK/ha',
      ph: '6.5-7.5',
      temperature: '27°C and 35°C',
    )
  },
  {
    'Chilli|மிளகாய்|मिर्च': DataModel.named(
      moisture: '70 - 100 percent',
      npkRatio: '30:60:30 kg NPK/ha',
      ph: '6.0-6.8',
      temperature: '18°C and 22°C',
    )
  },
  {
    'Carrot|கேரட்|गाजर': DataModel.named(
      moisture: '50 - 60 percent',
      npkRatio: '0:10:10 kg NPK/ha',
      ph: '6.0-6.5',
      temperature: '13°C and 24°C',
    )
  },
  {
    'Spinach|கீரை|पालक': DataModel.named(
      moisture: '41 - 80 percent',
      npkRatio: '20:20:20 kg NPK/ha',
      ph: '5.0 – 7.0',
      temperature: '10°C and 22°C',
    )
  },
  {
    'Tea|தேநீர்|चाय': DataModel.named(
      moisture: '10 - 40 percent',
      npkRatio: '195:60:195 kg NPK/ha',
      ph: '2.9 - 3.9',
      temperature: '12°C and 18°C',
    )
  },
  {
    'Coffee|காப்பி|कॉफ़ी': DataModel.named(
      moisture: '10 - 40 percent',
      npkRatio: '10:07:10 kg NPK/ha',
      ph: '5.9 - 6.9',
      temperature: '18°C and 30°C',
    )
  },
];
