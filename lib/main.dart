import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/bloc/bloc.dart';
import 'package:soilnutrientanalyzer/repo/crop_repo.dart';
import 'package:soilnutrientanalyzer/repository/login_repository.dart';
import 'package:soilnutrientanalyzer/repository/user_repository.dart';
import 'package:soilnutrientanalyzer/screens/auth.dart';
import 'bloc/crop_dropdown_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = Hive.box('user');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    LoginUserRepository userRepository = LoginUserFirebaseRepository(firestore);
    AuthRepository authRepository =
        FirebaseAuthRepository(auth, box, userRepository);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(
            TranslateRepo.crops,
            TranslateRepo.soliType('English'),
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository, box),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Humidity Analyzer',
        home: SignupScreen(),
      ),
    );
  }
}

class CurrentLocale {
  static String locale;
}
