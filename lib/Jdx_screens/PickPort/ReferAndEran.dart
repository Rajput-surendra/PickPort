import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Helper/session.dart';

import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/notifymodel.dart';

import 'package:http/http.dart' as http;

import '../../Utils/Color.dart';
import '../notification_Screen.dart';

class ReferAndEranScreen extends StatefulWidget {
  const ReferAndEranScreen({Key? key}) : super(key: key);

  @override
  State<ReferAndEranScreen> createState() => _ReferAndEranScreenState();
}

class _ReferAndEranScreenState extends State<ReferAndEranScreen> {


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(milliseconds: 300),(){
    //   return getNotification();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(child: Icon(Icons.arrow_back)),
                        ),
                      ),
                      Text(getTranslated(context, "Refer and earn"),style: TextStyle(color: whiteColor),),
                      Container(
                        height: 40,
                        width: 40,
                        decoration:  BoxDecoration(
                            color: splashcolor,
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const NotificationScreen()));
                            },
                            child: Center(
                              child: Image.asset(
                                'assets/ProfileAssets/support.png',scale: 1.3,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: Container(
                    decoration: BoxDecoration(
                        color: backGround,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50))
                    ),
                    child:  Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/ProfileAssets/OBJECTS.png"),
                              Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Text(getTranslated(context, "Refer and earn"),
                                  style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: backColor),
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(context, "Invite your friends to join and get the reward as soon as your friend first order placed"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.only(top: 28.0),
                                child: Text(
                                  getTranslated(context, "Your Referral Code"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration:  BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Secondry,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "",
                                      style: TextStyle(color: backColor),
                                    ),
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                      new BorderRadius.all(const Radius.circular(4.0))),
                                  child: Text("Tap to copy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: whiteColor),
                                  ),),
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(text: getTranslated(context, "Referral code")));
                                  // setSnackbar('Refercode Copied to clipboard');
                                  Fluttertoast.showToast(msg: getTranslated(context, "Refer code Copied to clipboard"),
                                      backgroundColor: primaryColor
                                  );
                                },
                              ),
                              SizedBox(height: 10),

                              InkWell(
                                  onTap: () {
                                    share(referCode: "dssdfsdfdsf");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor
                                    ),
                                    child:  Text(getTranslated(context, "Share"), style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,),),
                                  )),

                              // SimBtn(
                              //   size: 0.8,
                              //   title: "Share",
                              //   onBtnSelected: () {
                              //     var str =
                              //         "$appName\nRefer Code:$"REFER_CODE"\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n${getTranslated(context, 'IOSLBL')}\n$iosLink$iosPackage";
                              //     Share.share(str);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),

                ),
              )

            ],
          ),



        ));
  }

  GlobalKey keyList = GlobalKey() ;
  bool iconVisible = true;
  Future<void> share({String? referCode}) async {

    await FlutterShare.share(
        title: 'Refer and Eran',
        text: '$referCode',
        linkUrl: 'Refer and Eran',
        chooserTitle: 'Example Chooser Title'
    );
  }
}
