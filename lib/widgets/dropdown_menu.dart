import 'package:henkin_chat/views/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        items: [
          DropdownMenuItem(
            value: 'config',
            child: Row(
              children: const [
                Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text('Configurações'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'sair',
            child: Row(
              children: const [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text('Sair'),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          if (value == 'sair')
            FirebaseAuth.instance.signOut();
          else if (value == 'config')
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => SettingsScreen()));
        },
      ),
    );
  }
}
