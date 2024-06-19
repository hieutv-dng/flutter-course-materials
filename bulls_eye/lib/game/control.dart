import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_model.dart';
import 'slider_thumb_image.dart';
import 'dart:ui' as ui;

class Control extends StatefulWidget {
  const Control({super.key, required this.model});

  final GameModel model;

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  ui.Image? _sliderImage;

  Future<ui.Image> _load(String asset) async {
    //Lấy dữ liệu từ gói ứng dụng
    final data = await rootBundle.load(asset);
    //Lấy codec hình ảnh truyền từ data
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 60,
      targetHeight: 60,
    );
    //Lấy ảnh
    final fi = await codec.getNextFrame();
    return fi.image; //Trả về ảnh
  }

  @override
  void initState() {
    _load('assets/images/nub.png').then((image) {
      setState(() {
        _sliderImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 90, right: 10),
          child: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red.shade700,
              inactiveTrackColor: Colors.red.shade700,
              trackHeight: 8,
              trackShape: const RoundedRectSliderTrackShape(),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 28),
              thumbShape: SliderThumbImage(image: _sliderImage),
            ),
            child: Slider(
              value: widget.model.current.toDouble(),
              onChanged: (newValue) {
                print('$newValue');
                setState(() {
                  widget.model.current = newValue.toInt();
                });
              },
              min: 1.0,
              max: 100.0,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 90),
          child: Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
