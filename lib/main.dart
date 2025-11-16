import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_management_system/core/services/database_service.dart';
import 'package:hr_management_system/core/services/auth_service.dart';
import 'package:hr_management_system/core/providers/app_provider.dart';
import 'package:hr_management_system/core/theme/app_theme.dart';
import 'package:hr_management_system/core/routes/app_routes.dart';
import 'package:hr_management_system/features/auth/screens/login_screen.dart';
import 'package:hr_management_system/features/main/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize localization
  await EasyLocalization.ensureInitialized();
  
  // Initialize database
  final databaseService = DatabaseService();
  await databaseService.initializeDatabase();
  
  // Initialize auth service
  final authService = AuthService();
  await authService.initialize();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: HRMApp(
        databaseService: databaseService,
        authService: authService,
      ),
    ),
  );
}

class HRMApp extends StatelessWidget {
  final DatabaseService databaseService;
  final AuthService authService;
  
  const HRMApp({
    super.key,
    required this.databaseService,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>.value(value: databaseService),
        Provider<AuthService>.value(value: authService),
        ChangeNotifierProvider(create: (_) => AppProvider(databaseService)),
      ],
      child: MaterialApp(
        title: 'نظام إدارة الموارد البشرية',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}