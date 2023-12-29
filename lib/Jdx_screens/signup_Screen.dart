//
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:job_dekho_app/Jdx_screens/signin_Screen.dart';
// //import 'package:place_picker/entities/location_result.dart';
// //import 'package:place_picker/widgets/place_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Helper/session.dart';
// import '../Utils/api_path.dart';
// import '../Utils/color.dart';
// import 'Dashbord.dart';
// import 'package:http/http.dart' as http;
//
// class SignUpScreen extends StatefulWidget {
//   SignUpScreen({this.id});
//   final String? id;
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController addressC = TextEditingController();
//   TextEditingController nameC = TextEditingController();
//   TextEditingController mobileC = TextEditingController();
//   TextEditingController pincodeC = TextEditingController();
//   TextEditingController cityC = TextEditingController();
//   TextEditingController stateC = TextEditingController();
//   TextEditingController buildingC = TextEditingController();
//   TextEditingController countryC = TextEditingController();
//   double lat = 0.0;
//   double long = 0.0;
//   // String radioButtonItem = 'ONE';
//   int id = 0;
//
//   final _formKey = GlobalKey<FormState>();
//
//   SharedPreferences? preferences;
//   String userID = '';
//   String userEmail = '';
//   String userName = '';
//   String userMobile = '';
//   String userCity = '';
//   String userPic = '';
//   String wallet = '';
//
//   String? token;
//   getToken() async {
//     var fcmToken = await FirebaseMessaging.instance.getToken();
//     setState(() {
//       token = fcmToken.toString();
//     });
//     print("FCM ID Is $token");
//   }
//
//   registerUser() async{
//     SharedPreferences prefs  = await SharedPreferences.getInstance();
//     var headers = {
//       'Cookie': 'ci_session=aa0c171db25cefd1a0e5b170be945d1492f56aba'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/registration'));
//     request.fields.addAll({
//       'user_fullname': '${nameController.text}',
//       'user_phone': '${mobileController.text}',
//       'user_email': '${emailController.text}',
//       'user_password': '${passwordController.text}',
//       'firebaseToken': token.toString(),
//       'user_bdate': '5',
//       'referral_code': '5',
//       'user_city': '${addressC.text}',
//
//     });
//     print("Checking All Details fields ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       print('___________${finalResponse}__________');
//       final jsonResponse = json.decode(finalResponse);
//       Fluttertoast.showToast(msg: '${jsonResponse['message']}');
//
//      // String userid = jsonResponse['data']['user_id'];
//
//      // prefs.setString('userid', userid.toString());
//
//       if(jsonResponse['status'] == true){
//         Fluttertoast.showToast(msg: '${jsonResponse['message']}');
//         setState(() {
//         });
//         Fluttertoast.showToast(msg: "${jsonResponse['message']}");
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
//       }
//       else{
//         Fluttertoast.showToast(msg: "${jsonResponse['message']}");
//         setState(() {});
//       }
//     }
//     else {
//       setState(() {});
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print("rrrrrrrrrrrrrrrrrrrr==============>${finalResponse}");
//       print(jsonResponse.toString());
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Form(
//       key: _formKey,
//       child: SafeArea
//         (child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     decoration: BoxDecoration(color: primaryColor,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(getTranslated(context, 'LOGIN'),
//                                   style: TextStyle(
//                                       color: whiteColor, fontSize: 15)),
//                               Container(
//                                 height: 30,
//                                 width: 70,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: whiteColor),
//                                 child: Center(
//                                     child: Text(
//                                       getTranslated(context, 'GET_HELP'),
//                                       style: TextStyle(
//                                           color: primaryColor, fontSize: 15),
//                                     )),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             "Lorem ipsum dolor sit amet, consectetur commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
//                             style: TextStyle(color: whiteColor, fontSize: 13),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Container(
//                 //
//                 //   height: 60,
//                 //   decoration: BoxDecoration(
//                 //     color: primaryColor,
//                 //   ),
//                 //   child: Center(
//                 //     child: Text(
//                 //       'Sign Up',
//                 //       style: TextStyle(
//                 //         fontWeight: FontWeight.bold, fontSize: 22,color: whiteColor,),
//                 //     ),
//                 //   ),
//                 //   // child: Image.asset(
//                 //   //   'assets/egate_logo.png', color: primaryColor,
//                 //   //   // scale: 1.5,
//                 //   // ),
//                 //
//                 // ),
//
//
//
//                 // Container(
//                 //   height: size.height / 5.5 ,
//                 //   decoration: BoxDecoration(
//                 //     color: primaryColor,
//                 //   ),
//                 //   child: Image.asset('assets/egate_logo.png', scale: 1.3,),
//                 // ),
//                 Expanded(
//                   flex: 6,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 20.0,right: 20),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
//                         color: whiteColor,
//                       ),
//
//                       child:  ListView(
//                           shrinkWrap: true,
//                           children: [
//                             const Align(
//                               alignment:Alignment.center,
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Column(children: [
//                               Container(
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 20,),
//                                     Material(
//                                       elevation: 10,
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width / 1.2,
//                                         height: 60,
//                                         child: TextFormField(
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Please Enter Name';
//                                             }
//                                             return null;
//                                           },
//                                           controller: nameController,
//                                           decoration: InputDecoration(
//                                             border: const OutlineInputBorder(
//                                                 borderSide: BorderSide.none
//                                             ),
//                                             hintText: "User Name",
//                                             prefixIcon: Image.asset('assets/AuthAssets/Icon awesome-user.png', scale: 2.1, color: primaryColor,),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 20,),
//                                     Material(
//                                       elevation: 10,
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width / 1.2,
//                                         height: 60,
//                                         child: TextFormField(
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Please Enter Email';
//                                             }
//                                             return null;
//                                           },
//                                           controller: emailController,
//                                           decoration: InputDecoration(
//                                             border: const OutlineInputBorder(
//                                                 borderSide: BorderSide.none
//                                             ),
//                                             hintText: "Email",
//                                             prefixIcon: Image.asset('assets/AuthAssets/Icon material-email.png', scale: 2.1, color: primaryColor,),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20,),
//                                     Material(
//                                       elevation: 10,
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width / 1.2,
//                                         height: 60,
//                                         child: TextFormField(
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Please Enter Phone No.';
//                                             }
//                                             return null;
//                                           },
//                                           keyboardType: TextInputType.number,
//                                           controller: mobileController,
//                                           decoration: InputDecoration(
//                                             border: const OutlineInputBorder(
//                                                 borderSide: BorderSide.none
//                                             ),
//                                             hintText: "Mobile No.",
//                                             prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-call.png', scale: 2.1, color: primaryColor,),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20,),
//                                     // _addressField(context),
//                                     Material(
//                                       elevation: 10,
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width / 1.2,
//                                         height: 60,
//                                         child: TextFormField(
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Please Enter Your Location';
//                                             }
//                                             return null;
//                                           },
//                                           readOnly: true,
//                                           controller: addressC,
//                                           maxLines: 1,
//                                           onTap: (){
//                                             //_getLocation();
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => PlacePicker(
//                                                   apiKey: Platform.isAndroid
//                                                       ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
//                                                       : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
//                                                   onPlacePicked: (result) {
//                                                     print(result.formattedAddress);
//                                                     setState(() {
//                                                       addressC.text =
//                                                           result.formattedAddress.toString();
//                                                       lat = result.geometry!.location.lat;
//                                                       long = result.geometry!.location.lng;
//                                                     });
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                   initialPosition: LatLng(
//                                                       22.719568,75.857727),
//                                                   useCurrentLocation: true,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           textInputAction: TextInputAction.next,
//
//                                           decoration: InputDecoration(
//                                             border: const OutlineInputBorder(
//                                                 borderSide: BorderSide.none
//                                             ),
//                                             hintText: "Location",
//                                             prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 1.5, color: primaryColor,),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20,),
//                                     Material(
//                                       elevation: 10,
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width / 1.2,
//                                         height: 60,
//                                         child: TextFormField(
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Please Enter Your Password';
//                                             }
//                                             return null;
//                                           },
//                                           controller: passwordController,
//                                           decoration: InputDecoration(
//                                             border: const OutlineInputBorder(
//                                               borderSide: BorderSide.none,
//                                             ),
//                                             hintText: "Password",
//                                             prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 2.1, color: primaryColor,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // SizedBox(height: 20,),
//                                     // Material(
//                                     //   elevation: 10,
//                                     //   borderRadius: BorderRadius.circular(10),
//                                     //   child: Container(
//                                     //     width: MediaQuery.of(context).size.width / 1.2,
//                                     //     height: 50,
//                                     //     child: TextField(
//                                     //       controller: passwordController,
//                                     //       decoration: InputDecoration(
//                                     //         border: const OutlineInputBorder(
//                                     //           borderSide: BorderSide.none,
//                                     //         ),
//                                     //         hintText: "Confirm Password",
//                                     //         prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 2.1, color: primaryColor,
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     const SizedBox(height: 30,),
//                                     InkWell(
//                                       onTap: () {
//                                         if (_formKey.currentState!.validate()) {
//                                           registerUser();
//                                         }
//                                       },
//                                       child: Container(
//                                         height: 60,
//                                         width: MediaQuery.of(context).size.width/1.4,
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(30),
//                                             color: Secondry
//                                         ),
//                                         // child: isloader == true ? Center(child: CircularProgressIndicator(color: Colors.white,),) :
//                                         child: Text("Sign up",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),),
//                                       ),
//                                     ),
//                                     // InkWell(
//                                     //   onTap: (){
//                                     //     registerUser();
//                                     //   },
//                                     //   child: Container(
//                                     //     height: 50,
//                                     //     width: MediaQuery.of(context).size.width/1.4,
//                                     //     alignment: Alignment.center,
//                                     //     decoration: BoxDecoration(
//                                     //         borderRadius: BorderRadius.circular(30),
//                                     //         color: Secondry
//                                     //     ),
//                                     //     child: Text("Sign up",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),),
//                                     //   ),
//                                     // ),
//                                     SizedBox(height: 20,),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         const Text(
//                                           "Already have an account? ",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             Get.to(SignInScreen());
//                                           },
//                                           child: Text(
//                                             "Login",
//                                             style: TextStyle(
//                                                 color: primaryColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 50,),
//                                     // CustomTextButton(buttonText: 'Sign In', onTap: (){
//                                     //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> SeekerDrawerScreen()));
//                                     // }),
//                                   ],
//                                 ),
//                               ),
//                             ],)
//                           ]
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//         ),
//       )),
//     );
//   }
//   Widget _addressField(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, right: 30),
//       child:  Container(
//         color: Colors.red,
//         width: MediaQuery.of(context).size.width / 1.2,
//         height: 50,
//         child: TextField(
//           readOnly: true,
//           controller: addressC,
//           maxLines: 1,
//           onTap: (){
//             _getLocation();
//           },
//           textInputAction: TextInputAction.next,
//           decoration: InputDecoration(
//
//             border: const OutlineInputBorder(
//                 borderSide: BorderSide.none
//             ),
//             hintText: "Location",
//             prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 2.1, color: primaryColor,),
//           ),
//         ),
//       ),
//       // Container(
//       //   child: TextFormField(
//       //     readOnly: true,
//       //     controller: addressC,
//       //     maxLines: 1,
//       //     // labelText: "Address",
//       //     // hintText: "Enter Address",
//       //     // textInputAction: TextInputAction.next,
//       //     // suffixIcon: Icon(Icons.location_searching),
//       //
//       //   ),
//       // ),
//     );
//   }
//
//
//   _getLocation() async {
//    /* LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => PlacePicker(
//           "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
//         )));
//     print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
//     setState(() {
//       addressC.text = result.formattedAddress.toString();
//       cityC.text = result.locality.toString();
//       stateC.text = result.administrativeAreaLevel1!.name.toString();
//       countryC.text = result.country!.name.toString();
//       lat = result.latLng!.latitude;
//       long = result.latLng!.longitude;
//       pincodeC.text = result.postalCode.toString();
//     });*/
//   }
// // Future<AddAddressModel?> addAddress() async {
// //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/Kabadi/api/add_address'));
// //   request.fields.addAll({
// //     'user_id': '$userID',
// //     'address': '${addressC.text.toString()}',
// //     'building': '${buildingC.text.toString()}',
// //     'city': '${cityC.text.toString()}',
// //     'state': '${stateC.text.toString()}',
// //     'country': '${countryC.text.toString()}',
// //     'is_default': '1',
// //     'type': '$id',
// //     'lat': '$lat',
// //     'lng': '$long',
// //     'name': '${nameC.text.toString()}',
// //     'pincode': '${pincodeC.text.toString()}',
// //     'alt_mobile': '${mobileC.text.toString()}',
// //   });
// //
// //   print(request);
// //   print(request.fields);
// //
// //   http.StreamedResponse response = await request.send();
// //
// //   if (response.statusCode == 200) {
// //     final str = await response.stream.bytesToString();
// //     return AddAddressModel.fromJson(json.decode(str));
// //   }
// //   else {
// //     return null;
// //   }
// // }
//
//
// }
//
//
// // import 'dart:convert';
// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:intl/intl.dart';
// // import 'package:job_dekho_app/Utils/CustomWidgets/jobseeker_Tab.dart';
// // import 'package:job_dekho_app/Utils/CustomWidgets/recruiter_Tab.dart';
// // import 'package:job_dekho_app/Views/signin_Screen.dart';
// // import '../Utils/ApiModel/ShowDetailsModel.dart';
// // import '../Utils/ApiModel/SignUpModel.dart';
// // import '../Utils/CustomWidgets/SchoolTab.dart';
// // import '../Utils/CustomWidgets/TextFields/authTextField.dart';
// // import '../Utils/CustomWidgets/customTextButton.dart';
// // import '../Utils/api_path.dart';
// // import '../Utils/color.dart';
// // import 'accountcreated_Screen.dart';
// // import 'package:http/http.dart' as http;
// // // import '../Utils/style.dart';
// //
// // class SignUpScreen extends StatefulWidget {
// //   const SignUpScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<SignUpScreen> createState() => _SignUpScreenState();
// // }
// //
// // class _SignUpScreenState extends State<SignUpScreen> {
// //   TextEditingController codeController = TextEditingController();
// //
// //   Data? detailsModel;
// //
// //   showDetails() async {
// //     print("Show Details Api@@@@@@");
// //     var headers = {
// //       'Cookie': 'ci_session=e51f2b8d8f46fc0ca9897e617308398adca216f1'
// //     };
// //     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}show_details'));
// //     request.fields.addAll({
// //       'search_keyword': codeController.text.toString(),
// //     });
// //     request.headers.addAll(headers);
// //     http.StreamedResponse response = await request.send();
// //
// //     if (response.statusCode == 200) {
// //       print("working@@@@@@@");
// //       var finalResponse = await response.stream.bytesToString();
// //       final jsonResponse = ShowDetailsModel.fromJson(json.decode(finalResponse));
// //       setState(() {
// //        detailsModel = jsonResponse.data;
// //       });
// //     print("details are here now ${detailsModel!.driverId} and ${detailsModel!.schoolId} and ${detailsModel!.parentId}");
// //     }
// //     else {
// //       print(response.reasonPhrase);
// //     }
// //   }
// //
// //
// //
// //
// //   final _formKey = GlobalKey<FormState>();
// //
// //   registerUser() async {
// //    // Shared
// //     print("Register User Api>>>>>>");
// //     var headers = {
// //       'Cookie': 'ci_session=922f5c650083c77ae33c78aca232c748038bffe8'
// //     };
// //     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}add_student'));
// //     request.fields.addAll({
// //       'name': studentnameController.text,
// //       'dob': dateOfBirth.toString(),
// //       'age': ageController.text,
// //       'add_class': classController.text,
// //       'religion': religionController.text,
// //       'driver_id': detailsModel!.driverId.toString(),
// //       'school_id': detailsModel!.schoolId.toString(),
// //       'relation': parentrelationController.text,
// //       'occupation': parentOccupation.text,
// //       'sex': gender.toString(),
// //       'parent_id': detailsModel!.parentId.toString(),
// //       'birth_no': addharController.text,
// //       'roll_no':rollNoController.text,
// //       'blood':bloodGroupController.text,
// //       'division': divisionController.text,
// //       'emergency_no': emergencyController.text
// //     });
// //     request.headers.addAll(headers);
// //
// //     print("checking parameters of user register ${request.fields}");
// //     print("api here ${ApiPath.baseUrl}add_student");
// //     http.StreamedResponse response = await request.send();
// //     print("Working Api Here>>>>>");
// //     if (response.statusCode == 200) {
// //       var finalResponse = await response.stream.bytesToString();
// //       final jsonResponse = SignUpModel.fromJson(json.decode(finalResponse));
// //       setState(() {
// //         print("final response is here>>>>> ${jsonResponse.data.toString()}");
// //       });
// //      Fluttertoast.showToast(msg: "${jsonResponse.message}");
// //     Navigator.pop(context,true);
// //     }
// //     else {
// //       // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
// //       print(response.reasonPhrase);
// //     }
// //   }
// //
// //   TextEditingController studentnameController = TextEditingController();
// //   TextEditingController ageController = TextEditingController();
// //   TextEditingController religionController = TextEditingController();
// //   TextEditingController parentOccupation = TextEditingController();
// //   TextEditingController dateOfBirthController = TextEditingController();
// //   TextEditingController classController  = TextEditingController();
// //   TextEditingController parentrelationController = TextEditingController();
// //   TextEditingController addharController = TextEditingController();
// //   TextEditingController divisionController = TextEditingController();
// //   TextEditingController rollNoController = TextEditingController();
// //   TextEditingController emergencyController = TextEditingController();
// //   TextEditingController bloodGroupController = TextEditingController();
// //   String? profileImage;
// //   String? gender;
// //   String? dateOfBirth;
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     return SafeArea
// //       (child: DefaultTabController(
// //       length: 2,
// //       child: Scaffold(
// //           backgroundColor: primaryColor,
// //           body: Form(
// //             key: _formKey,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Container(
// //                   height: size.height / 10.5,
// //                   alignment: Alignment.center,
// //                   // padding: EdgeInsets.only(top: 15),
// //                   decoration: BoxDecoration(
// //                     color: primaryColor,
// //                   ),
// //                   child: Text('Student Registration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white,fontFamily: 'Lora'),textAlign: TextAlign.center,)
// //                 ),
// //                 Expanded(
// //                   child: Container(
// //                     padding: EdgeInsets.all(10),
// //                     width: size.width,
// //                     decoration: BoxDecoration(
// //                         color: whiteColor,
// //                         // borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
// //                     ),
// //                     child: ListView(
// //                       shrinkWrap: true,
// //                     padding: EdgeInsets.symmetric(horizontal: 12),
// //                     //  mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         // Text('Student Registration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),textAlign: TextAlign.center,),
// //                         // SizedBox(height: 10,),
// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.center,
// //                           children: [
// //                             Text("Gaurdian Code",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17,fontFamily: 'Lora'),),
// //                             SizedBox(height: 8,),
// //                             Material(
// //                               elevation: 10,
// //                               borderRadius: BorderRadius.circular(10),
// //                               child: Container(
// //                                 width: MediaQuery.of(context).size.width / 1.4,
// //                                 height: 48,
// //                                 child: TextFormField(
// //                                   validator: (value) {
// //                                     if (value == null || value.isEmpty) {
// //                                       return 'Cant Empty';
// //                                     }
// //                                     return null;
// //                                   },
// //                                   controller: codeController,
// //                                   decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                           borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Gaurdian Code",
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         SizedBox(height: 15,),
// //                         CustomTextButton(buttonText: 'Submit', onTap: (){
// //                         //  Get.to(showDetails());
// //                           if(codeController.text.isEmpty){
// //                             Fluttertoast.showToast(msg: "Please enter code");
// //                           }
// //                           else{
// //                             showDetails();
// //                           }
// //                           },
// //                         ),
// //                         SizedBox(height: 15,),
// //                         detailsModel != null ?
// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text("School Name", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.schName}'),
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("School Mobile", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.mobile}'),
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("School Email", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.email}',style: TextStyle(fontFamily: 'Lora'),),
// //                               ),
// //                             ),
// //                             // SizedBox(height: 12,),
// //                             // Text("School Name"),
// //                             // Material(
// //                             //   elevation: 4,
// //                             //   borderRadius: BorderRadius.circular(11),
// //                             //   child: Container(
// //                             //     padding: EdgeInsets.all(15),
// //                             //     width: MediaQuery.of(context).size.width
// //                             //     height: 50,
// //                             //     decoration: BoxDecoration(
// //                             //         color: Colors.white,
// //                             //         borderRadius: BorderRadius.circular(40)
// //                             //     ),
// //                             //     child: Text('${detailsModel!.gender}'),
// //                             //   ),
// //                             // ),
// //                             SizedBox(height: 12,),
// //                             Text("School Dise Code", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.schCode}'),
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("Driver Name", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.driName}'),
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("Driver Email", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.driEmail}')
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("Driver Shift",style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text('${detailsModel!.driShift}')
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("Driver Vehicle Number",style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text("${detailsModel!.driVehicleNumber}")
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                             Text("Driver Vehicle Type", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                             Material(
// //                               elevation: 4,
// //                               borderRadius: BorderRadius.circular(11),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(15),
// //                                 width: MediaQuery.of(context).size.width,
// //                                 height: 50,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(40)
// //                                 ),
// //                                 child: Text("${detailsModel!.driVehicleType}")
// //                               ),
// //                             ),
// //                             SizedBox(height: 12,),
// //                           ],
// //                         )
// //                         : SizedBox.shrink(),
// //                         SizedBox(height: 15,),
// //                        // JobSeekerTab(),
// //                        /// student detail
// //                   detailsModel == null ?  SizedBox.shrink() :
// //                   Container(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text("Student Section",style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora'),),
// //                               SizedBox(height: 25,),
// //                               Text("Student Name", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: studentnameController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter name';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Student name",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Student Age", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: ageController,
// //                                     maxLength: 2,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter age';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     keyboardType: TextInputType.number,
// //                                     decoration: const InputDecoration(
// //                                       counterText: "",
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Student Age",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               // SizedBox(height: 10,),
// //                               // Text("Student religion", style: TextStyle(fontWeight: FontWeight.w800)),
// //                               // Material(
// //                               //   elevation: 10,
// //                               //   borderRadius: BorderRadius.circular(10),
// //                               //   child: Container(
// //                               //     width: MediaQuery.of(context).size.width,
// //                               //     height: 60,
// //                               //     child: TextFormField(
// //                               //       controller: religionController,
// //                               //       validator: (value) {
// //                               //         if (value == null || value.isEmpty) {
// //                               //           return 'Please enter religion';
// //                               //         }
// //                               //         return null;
// //                               //       },
// //                               //       decoration: const InputDecoration(
// //                               //         border: OutlineInputBorder(
// //                               //           borderSide: BorderSide.none,
// //                               //         ),
// //                               //         hintText: "Student religion",
// //                               //       ),
// //                               //     ),
// //                               //   ),
// //                               // ),
// //                               SizedBox(height: 10,),
// //                               Text("Parant Occupation", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: parentOccupation,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter parents occupation';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Parents occupation",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Date Of Birth", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               InkWell(
// //                                 onTap: ()async{
// //                                   final DateTime? pickedDate = await showDatePicker(
// //                                     context: context,
// //                                     initialDate: DateTime.now(),
// //                                     firstDate: DateTime(1950),
// //                                     //DateTime.now() - not to allow to choose before today.
// //                                     lastDate: DateTime(2100),
// //                                     builder: (context, child) {
// //                                       // print("this is current date ${dateInput.toString()}");
// //                                       return Theme(
// //                                         data: Theme.of(context).copyWith(
// //                                           colorScheme: ColorScheme.light(
// //                                             // primary: primary, // <-- SEE HERE
// //                                             // onPrimary: Colors.redAccent, // <-- SEE HERE
// //                                             // onSurface: Colors.blueAccent, // <-- SEE HERE
// //                                           ),
// //                                           textButtonTheme: TextButtonThemeData(
// //                                             style: TextButton.styleFrom(
// //                                               // primary: primary, // button text color
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         child: child!,
// //                                       );
// //                                     },
// //
// //                                   );
// //                                   if (pickedDate != null) {
// //                                     print( "This is picked date" + pickedDate.toString());
// //                                   //  pickedDate output format => 2021-03-10 00:00:00.000
// //                                     dateOfBirth = DateFormat('dd-MM-yyyy').format(pickedDate);
// //                                     print("final formated date here" +
// //                                         dateOfBirth.toString()); //formatted date output using intl package =>  2021-03-16
// //                                     setState(() {
// //                                       // dateInput.text =
// //                                       //     formattedDate; //set output date to TextField value.
// //                                     });
// //                                   } else {}
// //                                 },
// //                                 child: Material(
// //                                   elevation: 10,
// //                                   borderRadius: BorderRadius.circular(10),
// //                                   child: Container(
// //                                     padding: EdgeInsets.symmetric(horizontal: 10),
// //                                     alignment: Alignment.centerLeft,
// //                                     width: MediaQuery.of(context).size.width,
// //                                     height: 60,
// //                                     child: dateOfBirth == null || dateOfBirth == "" ? Text("Select date",style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'),) : Text("${dateOfBirth}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'),)
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Admission Class", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: classController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter Admission class';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Admission Class",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Parant Relation", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: parentrelationController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter parents relation';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Parents relation",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Addhar Number", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: addharController,
// //                                     keyboardType: TextInputType.number,
// //                                     maxLength: 12,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter adhar number';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       counterText: "",
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Addhar Number",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Roll Number", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: rollNoController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter roll no';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Roll Number",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Container(
// //                                 child: Row(
// //                                   children: [
// //                                     Expanded(
// //                                       child: RadioListTile(
// //                                         title: Text("Male",style: TextStyle(fontFamily: 'Lora'),),
// //                                         value: "male",
// //                                         groupValue: gender,
// //                                         onChanged: (value){
// //                                           setState(() {
// //                                             gender = value.toString();
// //                                           });
// //                                         },
// //                                       ),
// //                                     ),
// //                                     Expanded(
// //                                       child: RadioListTile(
// //                                         title: Text("Female",style: TextStyle(fontFamily: 'Lora'),),
// //                                         value: "female",
// //                                         groupValue: gender,
// //                                         onChanged: (value){
// //                                           setState(() {
// //                                             gender = value.toString();
// //                                           });
// //                                         },
// //                                       ),
// //                                     )
// //                                   ],
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Blood Group", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: bloodGroupController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter blood group';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Blood Group",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Division", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     controller: divisionController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter division';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Division",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                               Text("Emergency Number", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Lora')),
// //                               Material(
// //                                 elevation: 10,
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 child: Container(
// //                                   width: MediaQuery.of(context).size.width,
// //                                   height: 60,
// //                                   child: TextFormField(
// //                                     maxLength: 10,
// //                                     keyboardType: TextInputType.number,
// //                                     controller: emergencyController,
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter emergency number';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: InputDecoration(
// //                                   counterText: "",
// //                                       border: OutlineInputBorder(
// //                                         borderSide: BorderSide.none,
// //                                       ),
// //                                       hintText: "Emergency Number",
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 10,),
// //                             ],
// //                           ),
// //                         ),
// //
// //                         SizedBox(
// //                           height: 15,
// //                         ),
// //                      detailsModel == null ? SizedBox.shrink() : InkWell(
// //                           onTap: (){
// //                             if(_formKey.currentState!.validate()){
// //                             if(detailsModel == null || detailsModel == ""){
// //                               Fluttertoast.showToast(msg: "Please enter driver and school detail with code");
// //                             }
// //                             else if(addharController.text.length != 12){
// //                               Fluttertoast.showToast(msg: "Please enter valid addhar number");
// //                             }
// //                             else if(emergencyController.text.length !=10){
// //                               Fluttertoast.showToast(msg: "Enter valid mobile number");
// //                             }
// //                             else{
// //                               registerUser();
// //                             }
// //                             }
// //                             else{
// //                               Fluttertoast.showToast(msg: "All fields are required");
// //                             }
// //                           },
// //                           child: Container(
// //                             height: 45,
// //                             width: MediaQuery.of(context).size.width/2.5,
// //                             alignment: Alignment.center,
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(10),
// //                               color: primaryColor
// //                             ),
// //                             child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'Lora'),),
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           height: 15,
// //                         ),
// //                         // SizedBox(height: MediaQuery.of(context).size.height / 1.65,
// //                         //   child: TabBarView(
// //                         //       children: [
// //                         //         JobSeekerTab(),
// //                         //       ]),
// //                         // ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //       ),
// //     ));
// //   }
// // }
//
import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/signin_Screen.dart';

import '../Model/animal_cat_model_response.dart';
import '../Utils/Color.dart';
import 'Dashbord.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  //singUpModel? information;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  TextEditingController VhicleController = TextEditingController();
  TextEditingController VhicletypeController = TextEditingController();
  TextEditingController LicenceController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double? lat;
  double? long;

  getNewSignUp() async {
    var headers = {
      'Cookie': 'ci_session=cd3c13dc5a076f38e4c94afe64948ac08bf8b17c'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/pickport/api/Authentication/deliveryBoyRegistration'));
    request.fields.addAll({
      'user_fullname':
      '210                                                                         ',
      'user_email': 'test11@gmail.com',
      'user_password': '12345678',
      'user_phone': '6879889798',
      'firebaseToken': '4',
      'aadhaar_card_no': '6486',
      'vehicle_type': '9+',
      'vehicle_no': '7',
      'driving_licence_no': '7',
      'account_holder_name': '5',
      'account_number': '7',
      'ifsc_code': '4',
      'user_image': '',
      'driving_licence_photo': ''
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {
      print(response.reasonPhrase);
    }
  }

  // signUpApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=441db6d062b9f121348edb7be09465992a51c601'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://developmentalphawizz.com/pickport/api/Authentication/deliveryBoyRegistration'));
  //
  //   request.fields.addAll({
  //     'user_fullname': nameController.text,
  //     'user_email': emailController.text,
  //     'user_password': passController.text,
  //     'user_phone': mobController.text,
  //     'firebaseToken': '4',
  //     'aadhaar_card_no': aadharController.text,
  //     'vehicle_type': VhicletypeController.text,
  //     'vehicle_no': VhicleController.text,
  //     'driving_licence_no': LicenceController.text,
  //     'account_holder_name': '5',
  //     'account_number': '7',
  //     'ifsc_code': '4',
  //     'user_image': '',
  //     'address': addressController.text,
  //     'lat': '${lat}',
  //     'lang': '${long}'
  //   });
  //
  //   request.files.add(await http.MultipartFile.fromPath(
  //       'driving_licence_photo', imageFile?.path ?? ''));
  //   print(
  //       " thos sonsafsdfds=>${Urls.baseUrl}Authentication/deliveryBoyRegistration}");
  //   print('Data is-------${request.fields}');
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   print(" mthis is  Re=---=>${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     final str = await response.stream.bytesToString();
  //     var finalData = json.decode(str);
  //     print('this is a reso========>${finalData}');
  //     Fluttertoast.showToast(msg: "${finalData['message']}");
  //
  //     setState(() {
  //       nameController.clear();
  //       emailController.clear();
  //       mobController.clear();
  //       passController.clear();
  //       VhicleController.clear();
  //       VhicletypeController.clear();
  //       LicenceController.clear();
  //       aadharController.clear();
  //     });
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getFromCamera();
                },
                //return false when click on "NO"
                child: const Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery();
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: const Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  Position? location;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityApi();
    //inIt();
  }
  bool isVisible = false;
  bool isTerm = false;
  int  selected =  0;
  int _value = 1;
  bool isNonAvailable = false;
  bool isAvailable = false;
  inIt() async {
    //location = await getUserCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                //  padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                //decoration: const BoxDecoration(color: primaryColor),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, "signUp"),
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            getTranslated(context, "GET_HELP"),
                            style:
                            TextStyle(color: primaryColor, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'It is a long established fact Lorem Ipsum is that distribution of letters it has a more-or-less normal distribution of letters',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: backGround,
                  borderRadius:  BorderRadius.only(
                      topRight: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.TransparentColor),
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Icon(
                                  Icons.person,
                                  color: CustomColors.accentColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 20, left: 5),
                              border: InputBorder.none,
                              hintText: getTranslated(context, "Name"),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Name is required";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.TransparentColor),
                          child: TextFormField(
                            maxLength: 10,
                            controller: mobController,
                            keyboardType: TextInputType.phone,
                            decoration:  InputDecoration(
                              counterText: "",
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(
                                  Icons.call,
                                  color: CustomColors.accentColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 18, left: 5),
                              border: InputBorder.none,
                              hintText: getTranslated(context, "ENTER_MOBILE"),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Mobile Number is required";
                              }
                              if (v.length != 10) {
                                return "Mobile Number must be of 10 digit";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.TransparentColor),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:  InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(
                                  Icons.email,
                                  color: CustomColors.accentColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 18, left: 5),
                              border: InputBorder.none,
                              hintText: getTranslated(context, "Entre_Email"),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Email id is required";
                              }
                              if (!v.contains("@")) {
                                return "Enter Valid Email Id";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        elevation: 1,
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.TransparentColor),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: Icon(Icons.location_city,color: CustomColors.accentColor,),
                                    )),
                                Expanded(
                                  flex: 10,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<AnimalCatList>(
                                      isExpanded: true,
                                      hint:  Text(getTranslated(context, "State"),
                                        style: const TextStyle(
                                          color: Colors.black54,fontWeight: FontWeight.w500,
                                        ),),
                                      value: animalCat,

                                      // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                      style:   TextStyle(color: Secondry,fontWeight: FontWeight.bold),
                                      underline: Padding(
                                        padding: const EdgeInsets.only(left: 0,top: 4),
                                        child: Container(

                                          // height: 2,
                                          color:whiteColor,
                                        ),
                                      ),
                                      onChanged: (AnimalCatList? value) {
                                        setState(() {
                                          animalCat = value!;
                                          catId =  animalCat?.id;
                                          //animalCountApi(animalCat!.id);
                                        });
                                      },
                                      items: animalCatResponse?.data?.map((items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2),
                                                child: Container(

                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 0),
                                                      child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:Colors.black),),
                                                    )),
                                              ),

                                            ],
                                          ),
                                        );
                                      })
                                          .toList(),
                                    ),

                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        elevation: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.TransparentColor),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Icon(Icons.location_city,color: CustomColors.accentColor,),
                                  )),
                              Expanded(
                                flex: 10,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<AnimalCatList>(
                                    isExpanded: true,
                                    hint:  Text(getTranslated(context, "City"),
                                      style: const TextStyle(
                                        color: Colors.black54,fontWeight: FontWeight.w500,
                                      ),),
                                    value: animalCat,

                                    // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                    style:   TextStyle(color: Secondry,fontWeight: FontWeight.bold),
                                    underline: Padding(
                                      padding: const EdgeInsets.only(left: 0,top: 4),
                                      child: Container(

                                        // height: 2,
                                        color:whiteColor,
                                      ),
                                    ),
                                    onChanged: (AnimalCatList? value) {
                                      setState(() {
                                        animalCat = value!;
                                        catId =  animalCat?.id;
                                        //animalCountApi(animalCat!.id);
                                      });
                                    },
                                    items: animalCatResponse?.data?.map((items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Container(

                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 0),
                                                    child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:Colors.black),),
                                                  )),
                                            ),

                                          ],
                                        ),
                                      );
                                    })
                                        .toList(),
                                  ),

                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        elevation: 1,
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              1.1,
                          height: 60,
                          child: TextField(
                            obscureText: isVisible ? false : true,
                            controller: passController,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(top: 8),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: getTranslated(
                                  context, "Password"),
                              prefixIcon: Image.asset(
                                'assets/AuthAssets/Icon ionic-ios-lock.png',
                                scale: 1.3,
                                color: Secondry,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible ? isVisible = false : isVisible = true;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        elevation: 1,
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              1.1,
                          height: 60,
                          child: TextField(
                            obscureText: isVisible ? false : true,
                            controller: cPassController,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(top: 8),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: getTranslated(
                                  context, "confirmPassword"),
                              prefixIcon: Image.asset(
                                'assets/AuthAssets/Icon ionic-ios-lock.png',
                                scale: 1.3,
                                color: Secondry,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible ? isVisible = false : isVisible = true;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.TransparentColor),
                          child: TextFormField(
                            controller: referalController,
                            obscureText: true,
                            decoration:  InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Icon(
                                  Icons.refresh_sharp,
                                  color: CustomColors.accentColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 22, left: 5),
                              border: InputBorder.none,
                              hintText: getTranslated(context, "Referral Code (Optional"),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Referral Code(Optional) is required";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(getTranslated(context, "GST Number (Optional)")),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Secondry),
                            activeColor: Secondry,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                isNonAvailable = false;
                              });
                            },
                          ),
                          Text(
                            getTranslated(context, "Non Available Available"),
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Radio(
                              value: 2,
                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => Secondry),
                              activeColor: Secondry,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  isAvailable = true;
                                });
                              }),
                          // SizedBox(width: 10.0,),
                          Text(
                            getTranslated(context, "Available"),
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      selected == 0
                          ? Container(
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isTerm = !isTerm;
                              });
                            },
                            child: Icon(
                              isTerm
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank,
                              color: Secondry,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'I agree to all ',
                            style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            getTranslated(context, "Terms and Conditions"),
                            style:TextStyle(fontSize:12,fontWeight: FontWeight.bold, color: primaryColor,),
                          ),
                          SizedBox(width: 2,),
                          Text(
                            'and ',
                            style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 2,),
                          Text(
                            getTranslated(context, "Privacy Policy"),
                            style: TextStyle(fontSize:12,fontWeight:FontWeight.bold, color:primaryColor,),
                          ),
                        ]),
                      )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStatefulWidget()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child:  Center(
                              child: Text(
                                getTranslated(context, "signUp"),
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      Row(
                        children: [
                           Text(getTranslated(context, "Already have an accounting"),style: TextStyle(
                             fontSize: 12
                           ),),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()));
                              },
                              child: Text(
                                getTranslated(context, "LogIn"),
                                style: TextStyle(color: Secondry,fontSize: 14),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }




  String? catId;
  AnimalCatList? animalCat;
  AnimalCatResponse? animalCatResponse;
  getCityApi() async {
    var headers = {
      'Cookie': 'ci_session=72caa85cedaa1a0d8ccc629445189f73af6a9946'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/goat_farm/app/v1/api/animal_category'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  AnimalCatResponse.fromJson(json.decode(result));
      setState(() {
        animalCatResponse =  finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
