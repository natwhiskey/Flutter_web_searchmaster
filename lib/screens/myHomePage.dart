import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_search/screens/aboutScreen.dart';
import 'package:flutter_web_search/screens/addDataInDB.dart';
import 'package:flutter_web_search/screens/detail.dart';
import 'package:flutter_web_search/screens/domainScreen.dart';
import 'package:flutter_web_search/screens/modelScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resultSearch = "";
  bool showCancelIcon = false;
  TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          '/computerbg.jpg',
          fit: BoxFit.fill,
          height: Get.height,
          width: Get.width,
        ),
        Container(
          child: Column(
            children: [
              Column(children: [
                SizedBox(
                  height: Get.height * 0.2,
                ),
                appBar(context),
                _buildSearchLayout(),
                _buildResultSearch(),
              ]),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTab('About', AboutScreen()),
            _buildTab('Model', ModelScreen()),
            _buildTab('Domain', DomainScreen()),
            _buildTab('Add Data', AddDataInDB()),
          ],
        ),
      ]),
    );
  }

  Widget _buildSearchLayout() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width * 0.4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                suffixIcon: _controller.text != "" || resultSearch != ""
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Icon(Icons.cancel),
                          onTap: () {
                            _controller.clear();
                            resultSearch = "";
                          },
                        ),
                      )
                    : null,
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                resultSearch = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, builderRoute) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => builderRoute));
          },
        ),
      ),
    );
  }

  Widget _buildResultSearch() {
    return Container(
      height: Get.height * 0.6,
      width: Get.width * 0.6,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("computer-repair")
            .where("searchKey", arrayContains: resultSearch)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Container(
                      color: Colors.white,
                      child: GestureDetector(
                        child: ListTile(
                          title: Text(
                            data.data()['name'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(data: data.data())));
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        // onLongPress: () {
        //   Navigator.push(
        //     context,
        //     // MaterialPageRoute(builder: (context) => AddDataInDB()),
          // );
        // },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextLogo('C', Colors.blue),
            _buildTextLogo('o', Colors.red),
            _buildTextLogo('m', Colors.yellow),
            _buildTextLogo('p', Colors.blue),
            _buildTextLogo('u', Colors.green),
            _buildTextLogo('t', Colors.red),
            _buildTextLogo('e', Colors.yellow),
            _buildTextLogo('r', Colors.blue),
            SizedBox(
              width: 8,
            ),
            _buildTextLogo('R', Colors.red),
            _buildTextLogo('e', Colors.yellow),
            _buildTextLogo('p', Colors.blue),
            _buildTextLogo('a', Colors.green),
            _buildTextLogo('i', Colors.red),
            _buildTextLogo('r', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildTextLogo(String text, textColor) {
    return Text(
      text,
      style: GoogleFonts.rubik().copyWith(
          fontSize: 64, color: textColor, fontWeight: FontWeight.bold),
    );
  }
}
