import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.black,
      ),
      body: Stack(children: [
        Image.asset(
          '/win10bg.jpg',
          fit: BoxFit.fill,
          height: Get.height,
          width: Get.width,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ]),
            child: Text(
              ' การพัฒนาระบบให้คำแนะนำการซ่อมบำรุงอุปกรณ์คอมพิวเตอร์ตั้งโต๊ะ (PC) โดยใช้ออนโทโลยี \n \n The system development provides advice on computer (PC) equipment maintenance using ontology \n \n นาย อภิรักษ์ ชินจักร \n รหัสนักศึกษา 6011500680 \n \n คณะ วิทยาศาสตร์ สาขา วิทยาการคอมพิวเตอร์ \n \n มหาวิทยาลัยราชภัฏจันทรเกษม \n อาจารย์ที่ปรึกษา อาจารย์ ชัยศิริ สนิทพลกลาง',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            // color: Colors.red,
          ),
        ),
      ]),
    );
  }
}
