import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

final controller = PageController(viewportFraction: 0.8, keepPage: true);

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imgList = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                height: 280,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller,
                  // itemCount: imgList.length,
                  itemBuilder: (_, index) {
                    return imgList[index % imgList.length];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  'Worm',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: imgList.length,
                effect: WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.thin,
                  // strokeWidth: 5,
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
