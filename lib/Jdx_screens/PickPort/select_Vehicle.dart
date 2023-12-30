import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/Editrecipentcart.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/review_booking.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
//import 'package:place_picker/entities/location_result.dart';
//import 'package:place_picker/widgets/place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/session.dart';
import '../../Model/MaterialCategoryModel.dart';
import '../../Model/ParcelWeightModel.dart';
import '../../Model/registerparcelmodel.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../notification_Screen.dart';

class SelcetVhicle extends StatefulWidget {
  SelcetVhicle({Key? key,this.dropLocation,this.picLocation,this.senderName,this.senderMobile,this.receiverName,this.receiverMobile}) : super(key: key);
   String ? dropLocation,picLocation,senderName,senderMobile,receiverName,receiverMobile;
  @override
  State<SelcetVhicle> createState() => _SelcetVhicleState();
}

class _SelcetVhicleState extends State<SelcetVhicle> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

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
                  Text(getTranslated(context, "Select Vchicle"),style: TextStyle(color: whiteColor),),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                     // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,width: 30,
                                          child: Image.asset(
                                            'assets/ProfileAssets/drop location.png',scale: 1.1,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(getTranslated(context, "Pickup Location"),style: TextStyle(
                                             fontSize: 15, color: primaryColor
                                           ),),
                                           Row(
                                             children: [
                                               Text("${widget.senderName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                               SizedBox(width: 5,),
                                               Text("${widget.senderMobile}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                             ],
                                           ),
                                           Container(
                                               width: 280,
                                               child: Text("${widget.picLocation}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                         ],
                                       )

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Dash(
                                          direction: Axis.vertical,
                                          length: 50,
                                          dashLength: 2,
                                          dashColor: primaryColor),
                                    ),
                                    Row(
                                     // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,width: 30,
                                          child: Image.asset(
                                            'assets/ProfileAssets/drop location.png',scale: 1.1,
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(getTranslated(context, "Drop Location"),style: TextStyle(
                                                fontSize: 15, color: primaryColor
                                            ),),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Row(
                                                children: [
                                                  Text("${widget.receiverName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                  SizedBox(width: 5,),
                                                  Text("${widget.receiverMobile}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: 280,
                                                child: Text("${widget.dropLocation}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height/1.7,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              elevation: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedIndex == index ? whiteColor:backGround,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: selectedIndex == index ? Border.all(color: primaryColor):null
                                                ),
                                                child: ListTile(
                                                  title: Text('Item $index'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewBookingScreen(dropLocation: widget.dropLocation,picLocation: widget.picLocation,)));

                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: primaryColor
                                          ),
                                          child:  Text("Proceed", style: TextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,),),
                                        )),
                                  ),
                                  SizedBox(height: 20,)
                                ],
                              )

                            ),

                          ],
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
