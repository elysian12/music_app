import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/common/providers/theme_provider.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void toogleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDark = ref.watch(themeNotifierProvider);
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => Scaffold.of(context).closeDrawer(),
            ),
            trailing: IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => toogleTheme(ref),
            ),
          )
        ],
      ),
    );
  }
}
