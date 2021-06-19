import 'package:flutter/material.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:key_chain/gospel_track/info_gospel_page.dart';
import 'package:key_chain/gospel_track/page_number.dart';
import 'package:provider/provider.dart';

class GospelTrackPage extends StatelessWidget {
  static const String route = 'about';
  static const List<String> _imgList = [
    'https://firebasestorage.googleapis.com/v0/b/burnapp-fca75.appspot.com/o/1_5finger.jpg?alt=media&token=203e37cd-03b1-44a9-bc86-861d4b4afe9f',
    'https://firebasestorage.googleapis.com/v0/b/burnapp-fca75.appspot.com/o/2_5finger.jpg?alt=media&token=1dca3f32-b264-4c59-96ff-c0ea1ce45726',
    'https://firebasestorage.googleapis.com/v0/b/burnapp-fca75.appspot.com/o/3_5finger.jpg?alt=media&token=b8eafd98-644a-458f-82de-1ad093454ab3',
    'https://firebasestorage.googleapis.com/v0/b/burnapp-fca75.appspot.com/o/4_5finger.jpg?alt=media&token=8137800f-b26b-4d63-8ab9-003c6b009b0e',
    'https://firebasestorage.googleapis.com/v0/b/burnapp-fca75.appspot.com/o/5_5finger.jpg?alt=media&token=f2283c26-260d-45cd-b35d-852e2cbb23ea'
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _imgList.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });

    final double height = MediaQuery.of(context).size.height;
    return MyScaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta != null && details.primaryDelta! < -9) {
            Navigator.push(context, InfoGospelPage());
          }
        },
        child: CarouselSlider(
          options: CarouselOptions(
              initialPage: context.read<PageNumber>().currentPage,
              enableInfiniteScroll: false,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, _) =>
                  context.read<PageNumber>().currentPage = index),
          items: _imgList
              .map((item) => Container(
                  color: Colors.white,
                  child: Center(
                      child: Image.network(
                    item,
                    fit: BoxFit.fitWidth,
                    height: height,
                  ))))
              .toList(),
        ),
      ),
    );
  }
}
