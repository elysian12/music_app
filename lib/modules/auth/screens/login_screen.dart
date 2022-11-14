import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/common/providers/theme_provider.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  void toogleTheme(WidgetRef ref) {
    ref.watch(themeNotifierProvider.notifier).toggle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDark = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => toogleTheme(ref),
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
    );
  }
}
