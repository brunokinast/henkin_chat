import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AlertColorPicker extends StatelessWidget {
  final Color pickerColor;
  final void Function(Color) onColorChanged;

  const AlertColorPicker(this.pickerColor, this.onColorChanged);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlidePicker(
            pickerColor: pickerColor,
            colorModel: ColorModel.rgb,
            enableAlpha: false,
            labelTypes: const [],
            onColorChanged: onColorChanged,
            indicatorBorderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
        ],
      ),
    );
  }
}
