import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class Detail extends StatelessWidget {
  final data;
  Detail({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          child: Image.asset(
            '/22222.jpg',
            fit: BoxFit.fill,
            height: Get.height,
            width: Get.width,
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                appBar(context),
                Container(
                  padding: EdgeInsets.only(bottom: 32),
                  width: Get.width * 0.5,
                  child: Column(
                    children: [
                      data['image'] != ""
                          ? ClipRRect(
                              child: Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              child: Image.network(
                                'https://d2gvpkbpfjsf4i.cloudfront.net/web-builder/no-image.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                      data['description'] != "" // == ""
                          ? _buildLayoutDescription(
                              data['description'], 'สาเหตุ')
                          : Container(),
                      SizedBox(height: 16),
                      data['method'] != ""
                          ? _buildLayoutDescription(data['method'], 'วิธีแก้ไข')
                          : _buildLayoutDescription('ไม่มีคำอธิบาย', ''),
                      SizedBox(height: 16),
                      data['URL'] != ""
                          ? _buildURL(data['URL'], 'วีดีโอ')
                          : _buildURL('ไม่มีวีดีโอ', ''),
                    ]),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  data['name'],
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget _buildLayoutDescription(String value, String title) {
    var resultValue = value;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Container(
          width: Get.width * 0.4,
          child: Text(
            "$resultValue",
            style: TextStyle(
              height: 1.5,
              color: Color(0xB3FFFFFF),
              fontSize: 16,
            ),
            maxLines: null,
            // softWrap: false,
          ),
        ),
      ],
    );
  }


  Widget _buildURL(String value, String title) {
    var resultValue = value;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Container(
          width: Get.width * 0.4,
          child: new InkWell(
                      child: Text(
              "$resultValue",
              style: TextStyle(
                height: 1.5,
                color: Color(0xB3FFFFFF),
                fontSize: 16,
              ),
              maxLines: null,
              // softWrap: false,
            ),
            onTap: () => launch('$resultValue'),
          ),
        ),
      ],
    );
  }
}
