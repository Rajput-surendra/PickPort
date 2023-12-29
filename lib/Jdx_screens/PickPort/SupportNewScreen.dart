import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../Helper/session.dart';
import '../../Model/contactus.dart';
import '../../Utils/Color.dart';
import '../../Utils/api_path.dart';
import '../notification_Screen.dart';


class SupportNewScreen extends StatefulWidget {

  const SupportNewScreen({Key? key}) : super(key: key);


  @override
  State<SupportNewScreen> createState() => _SupportNewScreenState();
}

class _SupportNewScreenState extends State<SupportNewScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();


  Contactus? Contact;

  contactus() async {
    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${ApiPath.baseUrl}Users/ContactUs'));
    request.fields.addAll({
      'name': '${nameController.text}',
      'email': '${emailcontroller.text}',
      'subject': '4',
      'message': '56'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("bbbbbbbbbbbbbbbbbbbb${response}");

      final result = await response.stream.bytesToString();
      var resultcontactus = Contactus.fromJson(jsonDecode(result));

      setState(() {
        Contact = resultcontactus;
      });

    }

    else {
      print(response.reasonPhrase);
    }

  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 30),(){
      return contactus();
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,

            body:  Column(
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
                        Text(getTranslated(context, "Support"),style: TextStyle(color: whiteColor),),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   decoration:  BoxDecoration(
                        //       color: splashcolor,
                        //       borderRadius:
                        //       BorderRadius.circular(100)),
                        //   child: InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                 const NotificationScreen()));
                        //       },
                        //       child: Center(
                        //         child: Image.asset(
                        //           'assets/ProfileAssets/support.png',scale: 1.3,
                        //         ),
                        //       )),
                        // ),
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
                      child: Contact ==  null || Contact == "" ? Center(child: CircularProgressIndicator(),) : ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(data: "${Contact!.data!.pgDescri}"),
                        ],
                      )

                  ),
                )

              ],
            ),



          // body: Column(
          //   children: [
          //     Row(
          //       children: [
          //         Text("${Contact!.data!.pgDescri}"),
          //       ],
          //     ),
          //
          //     // Image.asset("assets/ContactUsAssets/contactusIcon.png",scale: 1.2,),
          //     // SizedBox(height: 30,),
          //     // Text("Incase of any queries or assistance\nKindly what's app us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lora'),textAlign: TextAlign.center,),
          //     // SizedBox(height: 30,),
          //     // Padding(padding: EdgeInsets.symmetric(horizontal: 30),
          //     // child: Column(
          //     //   children: [
          //     //     // Html(data: "${Contact!.data!.pgDescri}", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.9,));
          //     //     LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.9,)),
          //     //     LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/whatsapp.png', scale: 1.9,),),
          //     //
          //     //     // LogoWithText(labelText: "${Contact!.data!.pgDescri}", imageIcon: Image.asset('assets/ContactUsAssets/email.png', scale: 1.2,)),
          //     //     // LogoWithText(labelText: "@jdxconnectofficial", imageIcon: Image.asset('assets/ContactUsAssets/instagram.png', scale: 1.2,)),
          //     //     // LogoWithText(labelText: "@jdxconnct_official", imageIcon: Image.asset('assets/ContactUsAssets/facebook.png', scale: 1.2,))
          //     //   ],
          //     // ),)
          //   ],
          //
          // )
    ));
  }
}
