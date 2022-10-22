import 'package:henkin_chat/widgets/color_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:henkin_chat/utils/settings.dart';

class SettingsScreen extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Color? bubbleColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          ColorSetting(
            title: 'Cor da aplicação:',
            colorValue: Settings.appColor.value,
            onChange: (color) => Settings.appColor = color,
          ),
          const Divider(
            thickness: 2,
            endIndent: 10,
            indent: 10,
          ),
          ValueListenableBuilder<Color>(
            valueListenable: Settings.getBubbleColor,
            builder: (_, color, __) => ColorSetting(
              title: 'Cor da suas mensagens:',
              colorValue: color.value,
              onChange: (color) => bubbleColor = color,
              onClose: () {
                if (bubbleColor != null) Settings.setBubbleColor(bubbleColor!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
