import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../Helper/session.dart';
import '../../Model/order_detail_response.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../Payment method.dart';
import '../notification_Screen.dart';

class ReviewBookingScreen extends StatefulWidget {
  ReviewBookingScreen({Key? key,this.dropLocation,this.picLocation}) : super(key: key);
   String ? dropLocation,picLocation;
  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {


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
                  Text(getTranslated(context, "Review Booking"),style: TextStyle(color: whiteColor),),
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
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        child:
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,width: 50,
                                              child: Image.asset(
                                                'assets/ProfileAssets/2 wheeler.png',scale: 1.1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15,left: 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("2 Wheelar",style: TextStyle(
                                                  fontWeight: FontWeight.bold

                                              ),),
                                              InkWell(
                                                onTap: (){
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                        builder: (context, setState) {
                                                          bool testBool = true;
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(12.0),
                                                                side: BorderSide(
                                                                    color: primaryColor
                                                                )), //this right here
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                print(testBool);
                                                                setState((){
                                                                  testBool = !testBool;

                                                                });
                                                                print(testBool);
                                                              },
                                                              child: Container(
                                                                height: 200,
                                                                width:double.infinity,
                                                                child:  Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(getTranslated(context, "Pickup Location"),style: TextStyle(
                                                                          color: primaryColor
                                                                      ),),
                                                                     Row(
                                                                       children: [
                                                                         Container(
                                                                             width: 250,
                                                                             child: Text(widget.picLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,))
                                                                       ],
                                                                     ),
                                                                      SizedBox(height: 10,),
                                                                      Divider(color: primaryColor,),
                                                                      Text(getTranslated(context, "Drop Location"),style: TextStyle(
                                                                          color: primaryColor
                                                                      ),),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                              width: 250,
                                                                              child: Text(widget.dropLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,))
                                                                        ],
                                                                      )

                                                                    ],
                                                                  ),
                                                                )
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(getTranslated(context, "View Address Details"),style: TextStyle(
                                                  color: primaryColor
                                                ),),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(getTranslated(context, "Receiver's Name"),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Material(
                                color: whiteColor,
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.1,
                                  height: 60,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Recipent Name';
                                      }
                                      return null;
                                    },
                                    controller: recipientNameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              Text(getTranslated(context, "Receiver's Mobile Number"),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Material(
                                color: whiteColor,
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.1,
                                  height: 60,
                                  child: TextFormField(
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Phone No.';
                                      }
                                      return null;
                                    },
                                    controller: recipientMobileController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      //  hintText: "Recipient Mobile No.",
                                      counterText: '',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(getTranslated(context, "Offer & Discount"),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,width: 50,
                                          child: Image.asset(
                                            'assets/ProfileAssets/offer.png',scale: 1.1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15,left: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("2 Wheelar"),
                                            Text(getTranslated(context, "View Address Details"),style: TextStyle(
                                                color: primaryColor
                                            ),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),
                              Text(getTranslated(context, "Parcel Details"),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Material Category"),style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("Dyamic"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Parcel Weight (Total)"),style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("20 KG"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Total Distance"),style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("25 KM."),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),
                              Text(getTranslated(context, "Fare Summery"),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Trip Fare"),style: TextStyle(fontWeight: FontWeight.normal)),
                                            Text("Dyamic"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Coupon Discount"),style: TextStyle(fontWeight: FontWeight.normal),),
                                            Text("20 KG"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Amount"),style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("25 KM.Rs"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: InkWell(
                                    onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethod1()));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: primaryColor
                                      ),
                                      child:  Text("Book Now", style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,),),
                                    )),
                              ),
                              SizedBox(height: 20,)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
