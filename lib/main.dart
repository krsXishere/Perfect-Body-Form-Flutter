import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/pages/sign_in_page.dart';
import 'package:perfect_body_form/providers/auth_provider.dart';
import 'package:perfect_body_form/providers/bottom_navigation_bar_provider.dart';
import 'package:perfect_body_form/providers/exercise_provider.dart';
import 'package:perfect_body_form/providers/home_provider.dart';
import 'package:perfect_body_form/providers/user_provider.dart';
import 'package:perfect_body_form/widgets/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
String token = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  token = await storage.read(
        key: "token",
        aOptions: getAndroidOptions(),
      ) ??
      "";

  runApp(const PerfectBodyForm());
}

class PerfectBodyForm extends StatefulWidget {
  const PerfectBodyForm({super.key});

  @override
  State<PerfectBodyForm> createState() => _PerfectBodyFormState();
}

class _PerfectBodyFormState extends State<PerfectBodyForm> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExerciseProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
            ),
            useMaterial3: true,
          ),
          home: token != "" ? const BottomNavigationBarWidget() : const SignInPage(),
          // home: const SignInPage(),
        );
      }),
    );
  }
}
