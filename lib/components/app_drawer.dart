import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/theme.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo Usuário'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCTS
              );
            },
          ),
          const Spacer(),
          ListTile(
            leading: Switch(
              value: themeProvider.isDark,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) {
                themeProvider.toggleDark(value);
              },
            ),
            title: const Text('Modo dark'),
          ),          
        ],
      ),
    );
  }
}
