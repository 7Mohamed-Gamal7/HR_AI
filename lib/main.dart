import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/services/database_service.dart';
import 'core/services/auth_service.dart';
import 'core/providers/app_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/main/screens/main_screen.dart';

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
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.login:
              return MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              );
            case AppRoutes.home:
              return MaterialPageRoute(
                builder: (context) => const MainScreen(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              );
          }
        },
      ),
    );
  }
}