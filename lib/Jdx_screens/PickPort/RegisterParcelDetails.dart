import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/Editrecipentcart.dart';
import 'package:job_dekho_app/Jdx_screens/HomeScreen.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
//import 'package:place_picker/entities/location_result.dart';
//import 'package:place_picker/widgets/place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Jdx_screens/PickPort/select_Vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/session.dart';
import '../../Model/MaterialCategoryModel.dart';
import '../../Model/ParcelWeightModel.dart';
import '../../Model/getprofilemodel.dart';
import '../../Model/registerparcelmodel.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../notification_Screen.dart';

class RegisterParcelDetails extends StatefulWidget {
   RegisterParcelDetails({Key? key,this.dropLocation,this.picLocation,this.lat1,this.long1,this.lat2,this.long2}) : super(key: key);
   String ? dropLocation,picLocation;
   double? lat1 = 0.0;
   double? long1 = 0.0;
   double? lat2 = 0.0;
   double? long2 = 0.0;
  @override
  State<RegisterParcelDetails> createState() => _RegisterParcelDetailsState();
}

class _RegisterParcelDetailsState extends State<RegisterParcelDetails> {
  // TextEditingController senderNameController = TextEditingController();

  //
  // TextEditingController recipientAddressCtr = TextEditingController();
  // TextEditingController recipientnewAddressCtr = TextEditingController();
  // TextEditingController senderAddressCtr = TextEditingController();
  // TextEditingController nameC = TextEditingController();
  // TextEditingController senderfulladdressCtr = TextEditingController();

  // TextEditingController pincodeC = TextEditingController();
  // TextEditingController cityC = TextEditingController();
  // TextEditingController valueController = TextEditingController();
  //
  // // TextEditingController addressC = TextEditingController();
  // TextEditingController receiverfulladdressCtr = TextEditingController();
  //
  // TextEditingController stateC = TextEditingController();
  // TextEditingController countryC = TextEditingController();
  // TextEditingController latitudeC = TextEditingController();
  // TextEditingController longitudeC = TextEditingController();

   TextEditingController recipientMobileController = TextEditingController();
  TextEditingController senderMobileController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
   TextEditingController picUpController = TextEditingController();
   TextEditingController picTimeController = TextEditingController();
   TextEditingController homeController = TextEditingController();



  // String radioButtonItem = 'ONE';
  int id = 0;

  Registerparcelmodel? parcelDetailsModel;

 List receiverList = [];

  // List<String>  selectedvalue = [];
   String? userName,userMobile;
  // Getprofilemodel? getprofile;
  // getuserProfile() async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userid = preferences.getString("userid");
  //   var headers = {
  //     'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}User_Dashboard/getUserProfile'));
  //   request.fields.addAll({
  //     'user_id': userid.toString()
  //   });
  //
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResult = await response.stream.bytesToString();
  //     final jsonResponse = Getprofilemodel.fromJson(json.decode(finalResult));
  //     setState(() {
  //       getprofile = jsonResponse;
  //       userName = getprofile!.data!.first.firstname.toString();
  //       userMobile = getprofile!.data!.first.firstname.toString();
  //       print('____Som______${userName}_________');
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  bool isLoading =  false;
  senParcel() async {
   if(receiverList.isEmpty){
     receiverList.add(
         {"meterial_category": "${selectedValue.toString()}",
          // "parcel_weight": "${selectedValue1.toString()}",
           "parcel_weight": "",
           "receiver_address": "${widget.dropLocation.toString()}",
           "receiver_latitude": "${widget.lat2}",
           "receiver_longitude": "${widget.long2}",
           "receiver_name": "${recipientNameController.text}",
           "receiver_phone": "${recipientMobileController.text}",
           "reciver_full_address": "${homeController.text}",
           "booking_type":"${_value}",
           "booking_date":_value == 0 ? date.toString(): picUpController.text,
           "booking_time": _value == 0 ? time.toString():picTimeController.text,
           "pacel_value" : ""
         });
   }


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
      userName = prefs.getString('name');
      userMobile = prefs.getString('phone');
      print('____Som___ffff___${userMobile}_________');
    String? orderid = prefs.getString("orderid");

    print("User Id ${userid.toString()}");
    // print("this is my order id>>>>>>>>>>>>>>${orderid}");
    print("Register and Sender Parcel");
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=1b21f643064e1ac4622693b37863ecfa449561dd',
    };
    var request = http.Request(
        'POST', Uri.parse('${ApiPath.baseUrl}payment/send_parcel'));
     request.body = json.encode({
      "sender_name":userName.toString(),
      "sender_address":widget.picLocation.toString(),
      "sender_phone":userMobile.toString(),
      "sender_latitude": widget.lat1 == null ? latSender :"${widget.lat1}",
      "sender_longitude": widget.long1 == null ? longSender :"${widget.long1}",
      "sender_fulladdress":widget.picLocation.toString(),
      "user_id": "${userid}",
      "data_arr": receiverList,
    });
    print("This is request here>>>>>>>>${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Working Now Here");
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = Registerparcelmodel.fromJson(json.decode(finalResult));
      String orderid = jsonResponse.orderId.toString();
      prefs.setString('orderid', orderid.toString());
      print("thiss is order id=========>${orderid}");
      // String? orderid = preferences.getString("orderid");
      print("Result here Now@@@@@@ ${finalResult.toString()}");
      // print("Result Noww@@@@@@ ${finalResult}");
      setState(() {
        isLoading = false;
        parcelDetailsModel = jsonResponse;
        print('____Som___hai___${parcelDetailsModel?.cap?.length}_________');
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ParceldetailsScreen(orderid: orderid, isFromParcelHistory: false,)));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelcetVhicle(VichleList: parcelDetailsModel,dropLocation: widget.dropLocation,picLocation: widget.picLocation,senderName: userName,senderMobile: userMobile,
          receiverName: recipientNameController.text,receiverMobile: recipientMobileController.text
        )));
      });
    }
    else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  MaterialCategoryModel? materialCategoryModel;
  materialCategory() async {
    print('____Som_____sdsdsds_________');
    var headers = {
      'Cookie': 'ci_session=18b59dc18c8193fd4e5e1c025a6904983b2ca7e4'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ApiPath.baseUrl}Products/Category'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Material category");
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MaterialCategoryModel.fromJson(
          json.decode(finalResult));
      print("final Result>>>>>>> ${finalResult.toString()}");
      setState(() {
        materialCategoryModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  ParcelWeightModel? parcelWeightModel;

  parcelWeight() async {
    var headers = {
      'Cookie': 'ci_session=18b59dc18c8193fd4e5e1c025a6904983b2ca7e4'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ApiPath.baseUrl}Products/getweight'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = ParcelWeightModel.fromJson(json.decode(finalResult));
      print("final Result>>>>>>> ${finalResult.toString()}");
      setState(() {
        parcelWeightModel = jsonResponse;
      });
    }
    else {
      print("Enterrrrrrrrrr");
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    materialCategory();
    // Future.delayed(Duration(milliseconds: 100), () {
    //   return
    //
    // });

    // Future.delayed(Duration(milliseconds: 100), () {
    //   return parcelWeight();
    // });
    _getCompensationAmmount();

  }

  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  String? selectedValue1;
  String? amt;
  double?  lat;
  double?  long;
  int _value = 0;
  bool isCurrent = false;
  bool isSchedule = false;
  String? selectedFromDate;
   String? date ,time;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
    // date =  formattedDateTime.substring(0,11);
    // time =  formattedDateTime.substring(11,18);
    print('____Som______${date}____${time}_____');
    // Data data = materialCategoryModel!.data![0].title;
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
                  //Text(getTranslated(context, "orders"),style: TextStyle(color: whiteColor),),
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
              ListView(
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
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,width: 30,
                                  child: Image.asset(
                                    'assets/ProfileAssets/drop location.png',scale: 1.1,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.5,
                                        child: Text(widget.dropLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,))
                                  ],
                                )

                              ],
                            ),
                          ),
                          // ///senderdetails
                          // Column(
                          //   children: const [
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 20.0),
                          //       child: Text("Sender Details", style: TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold),),
                          //     ),
                          //   ],
                          // ),
                          // Center(
                          //   child: Column(
                          //     children: [
                          //       const SizedBox(height: 20,),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: SizedBox(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 60,
                          //           child: TextFormField(
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'Enter Sender Name';
                          //               }
                          //               return null;
                          //             },
                          //             controller: senderNameController,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                   borderSide: BorderSide.none
                          //               ),
                          //               hintText: "Sender Name",
                          //               prefixIcon: Image.asset(
                          //                 'assets/AuthAssets/Icon awesome-user.png',
                          //                 scale: 2.1, color: primaryColor,),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(height: 20,),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: Container(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 60,
                          //           child: TextFormField(
                          //             maxLength: 10,
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return "Enter Phone No.";
                          //               }
                          //               return null;
                          //             },
                          //             controller: senderMobileController,
                          //             keyboardType: TextInputType.number,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                   borderSide: BorderSide.none
                          //               ),
                          //               hintText: "Sender Mobile No.",
                          //               counterText: "",
                          //               prefixIcon: Image.asset(
                          //                 'assets/AuthAssets/Icon ionic-ios-call.png',
                          //                 scale: 2.1, color: primaryColor,),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(height: 20,),
                          //       // _addressField(context),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: SizedBox(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 60,
                          //           child: TextFormField(
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'Please Enter Sender Address';
                          //               }
                          //               return null;
                          //             },
                          //             readOnly: true,
                          //             controller: senderAddressCtr,
                          //             maxLines: 1,
                          //             onTap: () {
                          //               //_getLocation1();
                          //
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => PlacePicker(
                          //                     apiKey: Platform.isAndroid
                          //                         ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                          //                         : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                          //                     onPlacePicked: (result) {
                          //                       print(result.formattedAddress);
                          //                       setState(() {
                          //                         senderAddressCtr.text =
                          //                             result.formattedAddress.toString();
                          //                         lat1 = result.geometry!.location.lat;
                          //                         long1 = result.geometry!.location.lng;
                          //                       });
                          //                       Navigator.of(context).pop();
                          //                     },
                          //                     initialPosition: LatLng(
                          //                         22.719568,75.857727),
                          //                     useCurrentLocation: true,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             textInputAction: TextInputAction.next,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                   borderSide: BorderSide.none
                          //               ),
                          //               hintText: "Sender Address",
                          //               prefixIcon: Image.asset(
                          //                 'assets/ProfileAssets/locationIcon.png',
                          //                 scale: 1.5, color: primaryColor,),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(height: 20,),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: Container(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 80,
                          //           child: TextFormField(
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'This Field Is Required';
                          //               }
                          //               return null;
                          //             },
                          //             controller: senderfulladdressCtr,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                 borderSide: BorderSide.none,
                          //               ),
                          //               hintText: "flat number,floor,building name,etc",
                          //               prefixIcon: Image.asset(
                          //                 'assets/ProfileAssets/locationIcon.png',
                          //                 scale: 1.7, color: primaryColor,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],),
                          // ),

                          ///recipentdetails
                           SizedBox(height: 15,),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getTranslated(context, "House/ Apartment (Optional)"),style: TextStyle(fontSize: 13),),
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
                                        // validator: (value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return 'House/ Apartment';
                                        //   }
                                        //   return null;
                                        // },
                                        controller: homeController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Receiver's Name"),style: TextStyle(fontSize: 13),),
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
                                  Text(getTranslated(context, "Receiver's Mobile Number"),style: TextStyle(fontSize: 13),),
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
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        //  hintText: "Recipient Mobile No.",
                                          counterText: '',
                                          suffixIcon: Icon(Icons.person,color: Secondry,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Parcel Details"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Material(
                                    color: whiteColor,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 55,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.1,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: Container(),
                                        value: selectedValue,
                                        hint:  Padding(
                                          padding: EdgeInsets.only(left: 5,top: 5),
                                          child: Text(getTranslated(context, "Material Category")),
                                        ),
                                        icon: Padding(
                                          padding: const EdgeInsets.only(top: 10,right: 5),
                                          child: Icon(Icons.keyboard_arrow_down,
                                              color: Secondry,size: 30,),
                                        ),
                                        items: materialCategoryModel?.data!.map((items) {
                                          return DropdownMenuItem(
                                            value: items.id.toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(items.title.toString()
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Booking Type"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 0,
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Secondry),
                                        activeColor: Secondry,
                                        groupValue: _value,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _value = value!;
                                            isCurrent = false;
                                          });
                                        },
                                      ),
                                      Text(
                                        getTranslated(context, "Current Booking"),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Radio(
                                          value: 1,
                                          fillColor: MaterialStateColor.resolveWith(
                                                  (states) => Secondry),
                                          activeColor: Secondry,
                                          groupValue: _value,
                                          onChanged: (int? value) {
                                            setState(() {
                                              _value = value!;
                                              isCurrent = true;
                                            });
                                          }),
                                      // SizedBox(width: 10.0,),
                                      Text(
                                        getTranslated(context, "Schedule Booking"),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(getTranslated(context, "Pickup Date and Time"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  isCurrent == true ? Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Expanded(
                                        child: GestureDetector(
                                            onTap: () async {
                                              DateTime? datePicked = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2024));
                                              if (datePicked != null) {
                                                print(
                                                    'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                                String formettedDate =
                                                DateFormat('dd-MM-yyyy').format(datePicked);
                                                setState(() {
                                                  selectedFromDate = formettedDate;

                                                });
                                              }
                                            },
                                            child: Card(
                                              elevation: 1,
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),

                                                child:  TextFormField(
                                                  readOnly: true,
                                                  onTap:
                                                      () async{
                                                    DateTime? datePicked = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(2024));
                                                    if (datePicked != null) {
                                                      print(
                                                          'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                                      String formettedDate =
                                                      DateFormat('dd-MM-yyyy').format(datePicked);
                                                      setState(() {
                                                        selectedFromDate = formettedDate;
                                                        picUpController.text = formettedDate;
                                                        // getDateApi(selectedBirthDate!);
                                                      });
                                                    }
                                                  },
                                                  controller: picUpController,
                                                  decoration:  InputDecoration(
                                                    border:InputBorder.none,
                                                    contentPadding: EdgeInsets.all(10),
                                                    suffixIcon: Icon(Icons.calendar_month,color:Secondry),
                                                   // hintText: 'dd-mm-yyyy',hintStyle: TextStyle(fontSize: 13)
                                                    // border: OutlineInputBorder(
                                                    //     borderRadius: BorderRadius.circular(10)),
                                                  ),
                                                  validator: (value){
                                                    if(value==null||value.isEmpty)
                                                      return "Please enter date";
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                          child:
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: TextFormField(

                                              readOnly: true,
                                              onTap: () async {
                                                TimeOfDay? pickedTime = await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                );

                                                if (pickedTime != null) {
                                                  DateTime parsedTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
                                                      pickedTime.hour, pickedTime.minute);

                                                  print(parsedTime); // Output: 2023-12-28 14:59:00.000

                                                  String formattedTime = DateFormat('hh:mm a').format(parsedTime);
                                                  print(formattedTime); // Output: 02:59 PM

                                                  picTimeController.text = formattedTime;
                                                } else {
                                                  print("Time is not selected");
                                                }
                                              },
                                              controller: picTimeController,
                                              keyboardType: TextInputType.number,
                                              maxLength: 10,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                  suffixIcon: Icon(Icons.timer,color: Secondry,),
                                                border: InputBorder.none,
                                                fillColor: whiteColor,
                                                filled: true,
                                              //  hintText: "Time",
                                                counterText: '',
                                                labelStyle: TextStyle(color: Colors.black87),
                                                // prefixIcon: IconButton(
                                                //   onPressed: null,
                                                //   icon: Icon(
                                                //     Icons.call,
                                                //     color: MyColorName.primaryDark,
                                                //   ),
                                                // ),
                                                // enabledBorder: UnderlineInputBorder(
                                                //   borderSide:  BorderSide(
                                                //     color: colors.primary,
                                                //   ),
                                                //   borderRadius: BorderRadius.circular(8.0),
                                                // ),
                                                // focusedBorder: UnderlineInputBorder(
                                                //   borderSide:  BorderSide(
                                                //     color: colors.secondary,
                                                //   ),
                                                //   borderRadius: BorderRadius.circular(8.0),
                                                // ),
                                              ),
                                            ),
                                          ),

                                        ),
                                      ),
                                    ],),
                                  ):SizedBox(),
                                  // isCurrent == false ? Padding(
                                  //   padding: const EdgeInsets.only(left: 0,right: 20),
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: Card(
                                  //             child: Container(
                                  //               height: 50,
                                  //                 child: Center(child: Text(formattedDateTime.substring(0,11)))),
                                  //
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //         child: Card(
                                  //             child: Container(
                                  //                 height: 50,
                                  //                 child: Center(child: Text(formattedDateTime.substring(11,16))))
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ) :SizedBox(),
                                  SizedBox(height: 20,),
                                  InkWell(
                                      onTap: () {
                                        setState(() {

                                        });
                                        if(receiverList.isEmpty) {
                                          if (_formKey.currentState!.validate()) {
                                           senParcel();
                                            // Get.to(ParceldetailsScreen());
                                          }
                                        }else {

                                        senParcel();
                                        }
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
                                        child: isLoading == true
                                            ? const Center(
                                          child:
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                            :
                                        Text(getTranslated(context, "Confirm"), style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,),),
                                      )),
                                  SizedBox(height: 20,),
                                ],),
                            ),
                          ),

                          ///parceldetails
                          SizedBox(height: 20,),

                        //   Center(
                        //       child: Column(
                        //         children: [
                        //           const SizedBox(height: 20,),
                        //
                        //           const SizedBox(height: 20,),
                        //           // Material(
                        //           //   color: splashcolor,
                        //           //   elevation: 1,
                        //           //   borderRadius: BorderRadius.circular(10),
                        //           //   child: SizedBox(
                        //           //     height: 55,
                        //           //     width: MediaQuery
                        //           //         .of(context)
                        //           //         .size
                        //           //         .width / 1.2,
                        //           //     child: DropdownButton(
                        //           //       isExpanded: true,
                        //           //       hint: const Padding(
                        //           //         padding: EdgeInsets.all(5.0),
                        //           //         child: Text("Parcel weight"),
                        //           //       ),
                        //           //       underline: Container(),
                        //           //       value: selectedValue1,
                        //           //       icon: const Padding(
                        //           //         padding: EdgeInsets.only(left: 140),
                        //           //         child: Icon(Icons.keyboard_arrow_down,
                        //           //             color: Color(0xFFBF2331)),
                        //           //       ),
                        //           //       items: parcelWeightModel?.data?.map((items) {
                        //           //         return DropdownMenuItem(
                        //           //           value: items.weightTo,
                        //           //           child: Text(items.weightTo.toString()),
                        //           //         );
                        //           //       }).toList(),
                        //           //       onChanged: (newValue) {
                        //           //         setState(() {
                        //           //           print("new value ${newValue}");
                        //           //           selectedValue1 = newValue!;
                        //           //         });
                        //           //       },
                        //           //     ),
                        //           //   ),
                        //           // ),
                        // //           const SizedBox(height: 15,),
                        // //           Material(
                        // //             color: splashcolor,
                        // //             elevation: 1,
                        // //             borderRadius: BorderRadius.circular(10),
                        // //             child: SizedBox(
                        // //               width: MediaQuery
                        // //                   .of(context)
                        // //                   .size
                        // //                   .width / 1.2,
                        // //               height: 60,
                        // //               child: TextFormField(
                        // //                 validator: (value) {
                        // //                   if (value == null || value.isEmpty) {
                        // //                     return 'Enter Parcel value ';
                        // //                   }
                        // //                   return null;
                        // //                 },
                        // //                 controller: valueController,
                        // //                 decoration: InputDecoration(
                        // //                   border: const OutlineInputBorder(
                        // //                       borderSide: BorderSide.none
                        // //                   ),
                        // //                   hintText: "Parcel value",
                        // //                   prefixIcon: IconButton(
                        // //                       onPressed: null,
                        // //                       icon: Image.asset('assets/AuthAssets/rupeesIcon.png', color: primaryColor, height: 20,width: 20,)),
                        // //                 ),
                        // //               ),
                        // //             ),
                        // //           ),
                        // //           Container(
                        // //               padding: const EdgeInsets.symmetric(horizontal: 30),
                        // //               width: MediaQuery.of(context).size.width,
                        // //               child:  Text('We will compensate the value of lost item '
                        // //                   'within three working days according to rules. '
                        // //                   'maximum compensation -${amt}', style: const TextStyle(fontSize: 12, color: Colors.grey,),)),
                        // //           const SizedBox(height: 50,),
                        // //           InkWell(
                        // //             onTap: () {
                        // //               /* "receiver_name": "${recipientNameController
                        // //       .text}",
                        // //   "receiver_phone": "${recipientMobileController
                        // //       .text}",
                        // //   "receiver_address": "${recipientAddressCtr}",
                        // //   "receiver_latitude": "${lat2}",
                        // //   "receiver_longitude": "${long2}",
                        // //   "reciver_full_address": "${receiverfulladdressCtr
                        // //       .text}",
                        // //   "meterial_category": "${selectedValue
                        // //       .toString()}",
                        // //   "parcel_weight": "up to ${selectedValue1
                        // //       .toString()} kg",
                        // // }*/
                        // //
                        // //               if (_formKey.currentState!.validate()) {
                        // //                 setState(() {
                        // //                   receiverList.add({
                        // //                     "meterial_category":
                        // //                     "${selectedValue.toString()}",
                        // //                     "parcel_weight": "${selectedValue1.toString()}",
                        // //                     "receiver_address": "${recipientAddressCtr.text}",
                        // //                     "receiver_latitude": "${lat2}",
                        // //                     "receiver_longitude": "${long2}",
                        // //                     "receiver_name":
                        // //                     "${recipientNameController.text}",
                        // //                     "receiver_phone":
                        // //                     "${recipientMobileController.text}",
                        // //                     "reciver_full_address":
                        // //                     "${receiverfulladdressCtr.text}",
                        // //                     "pacel_value" : "${valueController.text}"
                        // //                   });
                        // //                 });
                        // //                 print("Checking Parcel ${selectedValue1.toString()}");
                        // //                 print(
                        // //                     "checking hereeeee ${receiverList.length} and ${receiverList}");
                        // //
                        // //                 recipientNameController.clear();
                        // //                 recipientnewAddressCtr.clear();
                        // //                 recipientAddressCtr.clear();
                        // //                 recipientMobileController.clear();
                        // //                 receiverfulladdressCtr.clear();
                        // //                 valueController.clear();
                        // //
                        // //               }
                        // //               // Navigator.pop(context);
                        // //               // setState(() {});
                        // //               //
                        // //               // int materialValue = 0;
                        // //               // int parcelValue = 0;
                        // //               // int recnameValue = 0;
                        // //               // int recaddValue = 0;
                        // //               // int recmobValue = 0;
                        // //               // int recfulladdValue = 0;
                        // //               //
                        // //               // setState(() {
                        // //               // });
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   materialValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Material Valueee ${materialValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   parcelValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${parcelValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recnameValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recnameValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recaddValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recaddValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recfulladdValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recfulladdValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recmobValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recmobValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //
                        // //               //  Get.to(MyStatefulWidget());
                        // //             },
                        // //             child: Container(
                        // //               height: 45,
                        // //               width: MediaQuery
                        // //                   .of(context)
                        // //                   .size
                        // //                   .width / 1.2,
                        // //               alignment: Alignment.center,
                        // //               decoration: BoxDecoration(
                        // //                   borderRadius: BorderRadius.circular(30),
                        // //                   color: Secondry
                        // //               ),
                        // //               child: const Text("Add More", style: TextStyle(
                        // //                 color: Colors.black,
                        // //                 fontWeight: FontWeight.bold,
                        // //                 fontSize: 14,),),
                        // //             ),
                        // //           ),
                        // //           const SizedBox(height: 20,),
                        //
                        //         ],
                        //       )),
                        //   // Center(
                        //   //   child: DropdownSearch<String>(
                        //   //     popupProps: PopupProps.menu(
                        //   //       showSelectedItems: true,
                        //   //       showSearchBox: true,
                        //   //       disabledItemFn: (String s) => s.startsWith('I'),
                        //   //     ),
                        //   //
                        //   //     items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada,'],
                        //   //     dropdownDecoratorProps: DropDownDecoratorProps(
                        //   //       dropdownSearchDecoration: InputDecoration(
                        //   //         labelText: "Menu mode",
                        //   //         hintText: "country in menu mode",
                        //   //       ),
                        //   //     ),
                        //   //     onChanged: print,
                        //   //     selectedItem: "Brazil",
                        //   //   ),
                        //   // ),
                        //   //
                        //   // DropdownSearch<String>.multiSelection(
                        //   //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                        //   //   popupProps: PopupPropsMultiSelection.menu(
                        //   //     showSelectedItems: true,
                        //   //     disabledItemFn: (String s) => s.startsWith('I'),
                        //   //   ),
                        //   //   onChanged: print,
                        //   //   selectedItems: ["Brazil"],
                        //   // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),


    );
  }


  // Widget recipietCart(int index) {
  //   return
  //     Center(
  //     child: Card(
  //       elevation: 0,
  //       color: Theme.of(context).colorScheme.surfaceVariant,
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width/ 1.2,
  //         height: 80,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //           Text("Recipient Name"),
  //           Icon(Icons.delete),
  //           Icon(Icons.edit),
  //         ],),
  //       ),
  //     ),
  //   );
  // }

 /* _getLocation1() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result
            .locality.toString()} and ${result.country!.shortName
            .toString()} ");
    setState(() {
      senderAddressCtr.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat1 = result.latLng!.latitude;
      long1 = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }*/

 /* _getLocation2() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result
            .locality.toString()} and ${result.country!.shortName
            .toString()} ");
    setState(() {
      recipientAddressCtr.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat2 = result.latLng!.latitude;
      long2 = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }*/

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


class Recipient {
  String? receiver_name;
  String? receiver_phone;
  String? receiver_address;
  String? receiver_longitude;
  String? receiver_latitude;
  String? reciver_full_address;
  String? meterial_category;
  String? parcel_weight;

  Recipient(
      {this.meterial_category, this.parcel_weight, this.receiver_phone, this.receiver_name, this.receiver_address, this.receiver_latitude, this.receiver_longitude, this.reciver_full_address});


}