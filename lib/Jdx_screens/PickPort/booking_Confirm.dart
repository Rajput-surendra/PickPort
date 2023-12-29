import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Jdx_screens/HomeScreen.dart';
import '../../Helper/session.dart';
import '../../Model/order_detail_response.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../Dashbord.dart';
import '../Payment method.dart';
import '../notification_Screen.dart';

class BookingConfirmScreen extends StatefulWidget {
  BookingConfirmScreen({Key? key,this.dropLocation,this.picLocation}) : super(key: key);
   String ? dropLocation,picLocation;
  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientMobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            flex: 2,
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
                  Text(getTranslated(context, "Booking Confirmed"),style: TextStyle(color: whiteColor),),
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
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Container(
                    height: 250,
                      child: Image.asset("assets/ProfileAssets/bokingConfirm.png", width: double.infinity)),
                  Text(getTranslated(context, "Booking Done"),style: TextStyle(
                    color: primaryColor
                  ),),
                  Text(getTranslated(context, "Searching for a driver 5 min"),style: TextStyle(
                    color: backColor,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return StatefulBuilder(
                                //       builder: (context, setState) {
                                //         bool testBool = true;
                                //         return Dialog(
                                //           shape: RoundedRectangleBorder(
                                //               borderRadius:
                                //               BorderRadius.circular(12.0),
                                //               side: BorderSide(
                                //                   color: primaryColor
                                //               )), //this right here
                                //           child: GestureDetector(
                                //             onTap: (){
                                //               print(testBool);
                                //               setState((){
                                //                 testBool = !testBool;
                                //
                                //               });
                                //               print(testBool);
                                //             },
                                //             child: Container(
                                //                 height: 120,
                                //                 width:double.infinity,
                                //                 child:  Padding(
                                //                   padding: const EdgeInsets.all(8.0),
                                //                   child: Column(
                                //                     children: [
                                //                        Padding(
                                //                          padding: const EdgeInsets.all(8.0),
                                //                          child: Text('Are you sure you want to Cancel Trip the booking'),
                                //                        ),
                                //                         SizedBox(height: 10,),
                                //                        Row(
                                //                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                          children: [
                                //                            TextButton(
                                //                              onPressed: () {
                                //                                Navigator.of(context).pop(false); // Cancel exit
                                //                              },
                                //                              child: Text('No'),
                                //                            ),
                                //                            TextButton(
                                //                              onPressed: () {
                                //                                Navigator.of(context).pop(true); // Confirm exit
                                //                              },
                                //                              child: Text('Yes'),
                                //                            ),
                                //                          ],
                                //                        )
                                //
                                //                     ],
                                //                   )
                                //                 )
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   },
                                // );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(getTranslated(context, "Cancel Trip")),
                                      content: Text(getTranslated(context, "Are you sure you want to Cancel Trip the booking?")),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false); // Cancel exit
                                          },
                                          child: Text(getTranslated(context, "NO")),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                           Fluttertoast.showToast(msg: "Cancel Trip Successfuly");
                                          },
                                          child: Text(getTranslated(context, "Yes")),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: primaryColor)
                                ),
                                child:  Text(getTranslated(context, "Cancel Trip"), style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,),),
                              )),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStatefulWidget()));
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor
                                ),
                                child:  Text(getTranslated(context, "Back to home"), style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,),),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ),
          )

        ],
      ),


    );
  }

String? amt;
  _getCompensationAmmount()async{
    var headers = {
      'Cookie': 'ci_session=406d67c24c747ae88a88a5809e8b6a01e72d97c6'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}Authentication/get_compensation'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      amt = jsonResponse['data']['compensation'];
      print('__________${amt}_____________');
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
