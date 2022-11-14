import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/common/constants/theme.dart';
import 'package:music_app/common/providers/theme_provider.dart';
import 'package:music_app/modules/auth/screens/login_screen.dart';
import 'package:music_app/routes/router.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDark = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Acuostic App',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
