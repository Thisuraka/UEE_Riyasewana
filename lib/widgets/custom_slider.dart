import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styles.dart';

class CustomSlider extends StatefulWidget {
  List<String> imgList = [];
  CustomSlider({Key? key, required this.imgList}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final controller = PageController(viewportFraction: 1, initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageGen = List.generate(
      widget.imgList.length,
      (index) => Container(
          child: Image.asset(
        widget.imgList[index],
        fit: BoxFit.cover,
      )),
    );

    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[300],
      margin: EdgeInsets.only(top: 5),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            child: PageView.builder(
              controller: controller,
              itemBuilder: (_, index) {
                return imageGen[index % imageGen.length];
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            child: SmoothPageIndicator(
              controller: controller,
              count: imageGen.length,
              effect: WormEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  spacing: 20,
                  type: WormType.thin,
                  dotColor: Colors.white,
                  activeDotColor: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
