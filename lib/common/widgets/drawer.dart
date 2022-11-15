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
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
            onTap: () {},
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 2),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            onTap: () {},
            title: const Text(
              'Liked Songs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 2),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.message_outlined),
              onPressed: () {},
            ),
            onTap: () {},
            title: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 2),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.lightbulb_outline_rounded),
              onPressed: () {},
            ),
            onTap: () {},
            title: const Text(
              'FAQ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 2),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            onTap: () {},
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          ListTile(
            onTap: () {},
            title: const Text(
              'Developed with ❤️ by Aman',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
