import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    this.width,
    this.height,
    this.placeholder = Colors.transparent,
    required this.url,
  });

  final double? width;
  final double? height;
  final Color placeholder;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: placeholder,
        image: url.contains('http')
            ? DecorationImage(image: NetworkImage(url))
            : null,
      ),
    );
  }
}
