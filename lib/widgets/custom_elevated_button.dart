import 'package:flutter/material.dart';
import 'package:weather_app/utilities/text_style_source.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function callback;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black,
      ),
      onPressed: () {
        callback();
      },
      child: Text(
        title,
        style: TextStyleSource.inter14,
      ),
    );
  }
}
