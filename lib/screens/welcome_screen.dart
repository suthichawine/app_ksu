// import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_ksu/app_route.dart';
import 'package:app_ksu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    await SharedPrefs.setSharedPreference('isFirstTime', false);

    Navigator.pushReplacementNamed(context, AppRouter.bottomsNav);
  }

  Widget _buildImage(String assetName, bool isShadow, [double width = 350]) {
    if (isShadow) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), // กำหนด border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // สีของเงา
              spreadRadius: 2, // การกระจายของเงา
              blurRadius: 5, // การเบลอของเงา
              offset: const Offset(0, 3), // การย้ายที่ของเงา (x, y)
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(12.0), // กำหนด border radius เช่นเดียวกัน
          child: Image.asset('assets/images/$assetName', width: width),
        ),
      );
    } else {
      return Image.asset('assets/images/$assetName', width: width);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    const bodyStyle = TextStyle(fontSize: 16.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
          child: IntroductionScreen(
            key: introKey,
            pages: [
              PageViewModel(
                title: "ยินดีต้อนรับสู่มหาวิทยาลัยกาฬสินธุ์",
                body:
                    "สำรวจโอกาสและประสบการณ์การเรียนรู้ที่ไม่มีที่สิ้นสุดกับเรา",
                image: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: _buildImage('ksu.png', false, 230),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "มหาวิทยาลัยกาฬสินธุ์สู่ความเป็นเลิศ",
                body:
                    "มหาวิทยาลัยกาฬสินธุ์ มุ่งสู่ความเป็นเลิศด้านการศึกษา หล่อหลอมบัณฑิตที่มีคุณภาพ พร้อมทักษะที่ตรงกับความต้องการของตลาดแรงงาน",
                image: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: _buildImage('ksu2.jpg', true),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "อนาคตที่สดใสรอคุณอยู่",
                body:
                    "มุ่งมั่นส่งเสริมให้นักศึกษาบรรลุเป้าหมาย และประสบความสำเร็จบนเส้นทางที่คุณเลือก",
                image: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: _buildImage('ksu3.jpg', true),
                ),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            onSkip: () => _onIntroEnd(context),
            showSkipButton: true,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showBackButton: false,
            skip: const Text('ข้าม',
                style: TextStyle(fontWeight: FontWeight.w600)),
            next: const Icon(Icons.arrow_forward),
            done: const Text('เสร็จสิ้น',
                style: TextStyle(fontWeight: FontWeight.w600)),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color.fromARGB(255, 81, 175, 215),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            dotsContainerDecorator: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
