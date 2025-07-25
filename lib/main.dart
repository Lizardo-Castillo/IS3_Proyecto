import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/recover_password.dart';
import 'screens/registrer_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/edit_transaction_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_settings_screen.dart';
import 'screens/currency_settings_screen.dart';
import 'screens/language_settings_screem.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_of_use_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/chart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SmartBudgetApp());
}

class SmartBudgetApp extends StatelessWidget {
  const SmartBudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBudget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/recover': (context) => const RecoverPasswordScreen(),
        '/register': (context) => const RegisterScreen(),
        '/add': (context) => const AddTransactionScreen(),
        '/edit': (context) => const EditTransactionScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/profile_settings': (context) => const ProfileSettingsScreen(),
        '/currency_settings': (context) => const CurrencySettingsScreen(),
        '/language_settings': (context) => const LanguageSettingsScreen(),
        '/privacy_policy': (context) => const PrivacyPolicyScreen(),
        '/terms_of_use': (context) => const TermsOfUseScreen(),
        '/about_us': (context) => const AboutUsScreen(),
        '/reports': (context) => const ReportsScreen(),
        '/charts': (context) => const ChartScreen(),
      },
    );
  }
}