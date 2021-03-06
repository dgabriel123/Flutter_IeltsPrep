import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/models/reading.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/admob_service.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class ReadingDetailScreen extends StatefulWidget {
  final Reading reading;
  ReadingDetailScreen({
    Key key,
    this.reading,
  }) : super(key: key);

  @override
  _ReadingDetailScreenState createState() => _ReadingDetailScreenState(reading);
}

class _ReadingDetailScreenState extends State<ReadingDetailScreen>
    with SingleTickerProviderStateMixin {
  final Reading reading;
  _ReadingDetailScreenState(this.reading);

  String initialQuestionResult;
  String endingQuestionResult;
  String answersResult;
  final ams = AdMobService();
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            reading.title.replaceAll(
              "_n",
              "\n",
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(16))),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          // MenuPage(),
          Material(
            animationDuration: duration,
            // borderRadius: BorderRadius.all(Radius.circular(40)),
            elevation: 8,
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).secondaryHeaderColor,
                              blurRadius: 10)
                        ],
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(ScreenUtil().setWidth(75))),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(40),
                            ),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(8)),
                                child: Text(
                                  reading.whatToDo.replaceAll("_n", "\n \n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(16),
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10),
                                    right: ScreenUtil().setWidth(10),
                                    top: ScreenUtil().setHeight(10)),
                                child: Text(
                                  reading.paragraph.replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).accentColor,
                                      fontSize: ScreenUtil().setSp(13)),
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(15)),
                              Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(8)),
                                child: Text(
                                  reading.intialQuestionNumbers
                                      .replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(18),
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: reading.initialQuestions.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      initialQuestionResult =
                                          reading.initialQuestions[index];

                                      return ListTile(
                                        title: Text(
                                          initialQuestionResult.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(13),
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      );
                                    },
                                  )),

                              // Summary
                              Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(12)),
                                child: Text(
                                  reading.summary.replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).accentColor,
                                      fontSize: ScreenUtil().setSp(16)),
                                ),
                              ),

                              Visibility(
                                visible: reading.extraData == true,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(ScreenUtil().setHeight(8)),
                                  child: Text(
                                    reading.endingQuestionNumbers
                                        .replaceAll("_n", "\n"),
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(18),
                                        color: Color(0xFF21BFBD)),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: reading.extraData == true,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setHeight(10),
                                        right: ScreenUtil().setHeight(10),
                                        top: ScreenUtil().setHeight(10)),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: reading.endingQuestions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        endingQuestionResult =
                                            reading.endingQuestions[index];
                                        return ListTile(
                                          title: Text(
                                            endingQuestionResult.replaceAll(
                                                "_n", "\n"),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(13),
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ),

                              Visibility(
                                visible: premium_user != true,
                                child: AdmobBanner(
                                    adUnitId: ams.getBannerAdId(),
                                    adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    openBookingDetailsSheet(context, reading);
                                  },
                                  child: Text('Answers',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20),
                                        fontFamily: 'Montserrat',
                                      )),
                                  color: Colors.deepPurpleAccent,
                                  textColor: Colors.white,
                                  elevation: 5,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openBookingDetailsSheet(BuildContext context, Reading reading) {
    showModalBottomSheet<Widget>(
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) => ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reading.answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = reading.answers[index];
                  return ListTile(
                    title: Text(
                      answersResult.replaceAll("_n", "\n"),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: ScreenUtil().setSp(13),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
