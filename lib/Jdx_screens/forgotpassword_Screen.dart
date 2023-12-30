// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/customTextButton.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
// import '../Utils/color.dart';
// import 'signin_Screen.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         //centerTitle: true,
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: (){
//             Get.to(SignInScreen());
//           },
//           child: Icon(Icons.arrow_back_ios, color: primaryColor, size: 26),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Container(
//             //   width: 250,
//             //   height: 300,
//             //   child: Image.asset('assets/AuthAssets/forgotpassword.png'),
//             // ),
//             SizedBox(height: 25,),
//             Text("Forget Password?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Lora'),),
//             SizedBox(height: 20,),
//             Text('Enter email associated \n with your account', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: greyColor1,fontFamily: 'Lora'),textAlign: TextAlign.center,),
//             CustomTextFormField(label: "Email"),
//             SizedBox(height: 50,),
//             CustomTextButton(buttonText: "Submit")
//           ],
//         ),
//       ),
//     ));
//   }
// }
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/session.dart';
import '../Utils/CustomWidgets/TextFields/customTextFormField.dart';
import '../Utils/color.dart';
import 'PickPort/Update_password.dart';
import 'package:http/http.dart 'as http;



class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

  // loginwitMobile() async {
  //   String? token ;
  //   try{
  //     token  = await FirebaseMessaging.instance.getToken();
  //
  //   } on FirebaseException{
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('otp', "otp");
  //   preferences.setString('mobile', "mobile");
  //   print("this is apiiiiiiii");
  //   var headers = {
  //     'Cookie': 'ci_session=b13e618fdb461ccb3dc68f327a6628cb4e99c184'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${bal.sendForgotOtp}'));
  //   request.fields.addAll({
  //     'mobile': mobileController.text,
  //     'fcm_id' : '${token}'
  //   });
  //   ///Are ghar jaao enjoy karo
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalresponse = await response.stream.bytesToString();
  //     final jsonresponse = json.decode(finalresponse);
  //
  //     if (jsonresponse['error'] == false) {
  //       String otp = jsonresponse['data'][0]["otp"];
  //       String mobile = jsonresponse['data'][0]["mobile"];
  //
  //       Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: Secondry);
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => UpdatePassword(OTP: otp.toString(),MOBILE:mobile.toString() ,)
  //           ));
  //     }
  //     else{
  //       Fluttertoast.showToast(msg: "${jsonresponse['message']}",backgroundColor: Secondry);
  //     }
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body:Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          SizedBox(width: 10,),
                          Text(getTranslated(context, "Forgot_pass"),style: TextStyle(color: whiteColor),),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor),
                        child: Center(
                            child: Text(
                              getTranslated(context, 'GET_HELP'),
                              style: TextStyle(
                                  color: primaryColor, fontSize: 15),
                            )),
                      ),
                    ],
                  ),
                  Text("")
                ],
              )
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                  color: backGround,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(50))),
              child:   Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        child: Center(
                          child: TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            validator: (v) {
                              if (v!.length != 10) {
                                return "mobile number is required";
                              }
                            },
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              contentPadding:
                              EdgeInsets.only(left: 15, top: 15),
                              hintText: "Mobile Number",hintStyle: TextStyle(color: primaryColor),
                              prefixIcon: Icon(
                                Icons.call,
                                color:Secondry,
                                size: 20,
                              ),

                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                        onTap: (){
                          setState((){
                            isLoading = true;
                          });
                          if(mobileController.text.isNotEmpty && mobileController.text.length == 10){
                          //  loginWitMobile();
                          }else{
                            setState((){
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: "Please enter valid mobile number!",backgroundColor: Secondry);
                          }
                        },
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 0,top: 10,bottom: 10),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width/1.2,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Secondry),
                            child:
                            Center(child: Text(getTranslated(context, "Send Otp"), style: TextStyle(fontSize: 18, color: Secondry))),
                          ),
                        )
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
}
