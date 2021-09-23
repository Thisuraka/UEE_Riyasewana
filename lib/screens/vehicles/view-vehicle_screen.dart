import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../styles.dart';

class ViewVehicleScreen extends StatefulWidget {
  @override
  _ViewVehicleScreenState createState() => _ViewVehicleScreenState();
}

final controller = PageController(viewportFraction: 1, initialPage: 0);
String _postDate = "2021-04-21";
String _vName = "Nissan Silvia S15 - 1992";
String _price = "9,400,000";
bool _negotiable = true;

final imgList = List.generate(
  5,
  (index) => Container(
      child: Center(
          child: Image.asset(
    'assets/images/car1.jpg',
    fit: BoxFit.cover,
  ))),
);

class _ViewVehicleScreenState extends State<ViewVehicleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: CustomAppbarWidget(
              mainTitle: "",
              leadingImg: false,
              logo: true,
              searchIcon: false,
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Posted on " + _postDate,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: DefaultColor,
                  fontSize: 15),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Container(
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
                            return imgList[index % imgList.length];
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 200),
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: imgList.length,
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
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 260),
                  color: Colors.blueAccent,
                  child: Stack(
                    children: [Text(_vName)],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
