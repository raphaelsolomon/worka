// ignore: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:worka/controllers/loading_controller.dart';
import 'package:worka/employer_page/controller/answerController.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/Helper.dart';
import 'package:worka/phoenix/ProfileController.dart';
import 'package:provider/provider.dart';
import 'employer_page/controller/empContoller.dart';
import 'screens/welcome_screen.dart';

final _configuration =
    PurchasesConfiguration('appl_JmXeXxakZDeIwYPsxJOfyKwzbGm')
      ..appUserID = null
      ..observerMode = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.configure(_configuration);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<Controller>(create: (_) => Controller()),
            ChangeNotifierProvider<AnswerController>(
                create: (_) => AnswerController()),
            ChangeNotifierProvider<Helper>(create: (_) => Helper()),
            ChangeNotifierProvider<LoadingController>(
                create: (_) => LoadingController()),
            ChangeNotifierProvider<ProfileController>(
                create: (_) => ProfileController()),
            ChangeNotifierProvider<EmpController>(
                create: (_) => EmpController())
          ],
          child: GetMaterialApp(
            title: 'Worka',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const WelcomeScreen(),
          ));
}
