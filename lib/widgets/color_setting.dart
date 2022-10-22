import 'package:henkin_chat/widgets/alert_color_picker.dart';
import 'package:flutter/material.dart';

class ColorSetting extends StatefulWidget {
  final String title;
  final int colorValue;
  final void Function(Color) onChange;
  final void Function()? onClose;

  const ColorSetting({
    required this.title,
    required this.colorValue,
    required this.onChange,
    this.onClose,
  });

  @override
  ColorSettingState createState() => ColorSettingState();
}

class ColorSettingState extends State<ColorSetting> {
  @override
  Widget build(BuildContext context) {
    int colorValue = widget.colorValue;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          CircleAvatar(
            backgroundColor: Color(colorValue),
            radius: 30,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Color(colorValue).computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertColorPicker(
                    Color(colorValue),
                    (color) {
                      setState(() => colorValue = color.value);
                      widget.onChange.call(color);
                    },
                  ),
                ).then((_) => widget.onClose?.call());
              },
            ),
          ),
        ],
      ),
    );
  }
}
