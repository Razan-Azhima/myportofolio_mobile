import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Navigasi ke halaman utama portofolio
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            // Navigasi ke halaman tambah proyek
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-project');
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_sharp),
            title: const Text('Add Education'),

            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-edu');
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_history),
            title: const Text('Add Experience'),
            onTap: () {
              Navigator.pop(context);
              final route = context.read<AuthState>().isAuthenticated
                  ? '/add-experience'
                  : '/login';
              Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
    );
  }
}
