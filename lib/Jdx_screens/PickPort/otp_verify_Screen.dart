import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customButton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/session.dart';
import '../../Utils/Color.dart';
import 'package:http/http.dart'as http;

import '../../Utils/api_path.dart';
import '../Dashbord.dart';
import '../HomeScreen.dart';

class VerrifyScreen extends StatefulWidget {
   VerrifyScreen({Key? key,this.mobile,this.otp}) : super(key: key);
  String? mobile,otp;

  @override
  State<VerrifyScreen> createState() => _VerrifyScreenState();
}

class _VerrifyScreenState extends State<VerrifyScreen> {

   bool isLoading = false;
  verifyOtpApi() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=1fae43cb24be06ee09e394b6be82b42f6d887269'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/checkUserOtp'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'otp': widget.otp.toString(),
      'firebaseToken':token.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);
      if (jsonresponse['error'] == true){
        String userid = jsonresponse['data']['user_id'];
        String email = jsonresponse['data']['user_email'];
        String phone = jsonresponse['data']['user_phone'];
        prefs.setString('userid', userid.toString());
        prefs.setString('email', email.toString());
        prefs.setString('phone', phone.toString());
        Fluttertoast.showToast(msg: '${jsonresponse['message']}',);

      }
      else{
        Fluttertoast.showToast(msg: "${jsonresponse['message']}",);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyStatefulWidget()));
        setState(() {
          isLoading =  false;
        });

      }
    }
    else {
      setState(() {
        isLoading =  false;
      });
      print(response.reasonPhrase);
    }
  }
  String? newPin ;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
   getToken() async {
     var fcmToken = await FirebaseMessaging.instance.getToken();
     setState(() {
       token = fcmToken.toString();
     });
     print("FCM ID Is______________ $token");
   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColor,
      body:  Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(

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
                  SizedBox(width: 20,),
                  Text(getTranslated(context, "Verification"),style: TextStyle(color: whiteColor),),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
                decoration: BoxDecoration(
                    color: backGround,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50))
                ),
                child:
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage("assets/images/punbabComman.png"),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(right:20,left: 20,top: 50),
                      child: Column(
                        children: [

                           Text(getTranslated(context, "Code has sent to"),style: TextStyle(color: Colors.black),),
                          Text("+${widget.mobile.toString()}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text("OTP: ${widget.otp.toString()}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          // controller.otp == "null" ?
                          // Text('OTP: ',style: const TextStyle(fontSize: 20,color: AppColors.whit),):
                         // Text('OTP: ${otp}',style: const TextStyle(fontSize: 20,color: Colors.white),),

                          const SizedBox(height: 50,),
                          PinCodeTextField(

                            //errorBorderColor:Color(0xFF5ACBEF),
                            //defaultBorderColor: Color(0xFF5ACBEF),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                             widget.otp = value.toString() ;
                              newPin = value.toString();
                            },
                            textStyle: const TextStyle(color: Colors.black),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              activeColor: primaryColor,
                              inactiveColor: primaryColor,
                              selectedColor: primaryColor,
                              fieldHeight: 60,
                              fieldWidth: 60,
                              selectedFillColor: primaryColor,
                              inactiveFillColor: primaryColor,
                              activeFillColor: primaryColor,
                            ),
                            //pinBoxRadius:20,
                            appContext: context, length: 4 ,
                          ),

                          const SizedBox(height: 20,),
                           Text(getTranslated(context, "Haven't received the verification code?"),style: TextStyle(color: Colors.black54,fontSize: 16),),
                          InkWell(onTap: (){
                            //resendSendOtp();
                            //sendOtp(mobile: controller.data[0].toString());
                          },
                              child:  Text(getTranslated(context, "Resend"),style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),)),
                          const SizedBox(height: 50,),
                          // Obx(() => Padding(padding: const EdgeInsets.only(left: 25, right: 25), child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) :
                          //
                          // )
                          CustomButton1(
                            onTap: (){

                               if(newPin != widget.otp){
                                 Fluttertoast.showToast(msg: "Please enter correct pin");

                               } else if(newPin == null) {
                                 Fluttertoast.showToast(msg: "Please enter pin");
                               }
                               else{
                                 verifyOtpApi();
                               }
                            },
                            buttonText: getTranslated(context, "Verify Code"),
                          )


                        ],
                      ),
                    ),
                  ),
                ),

            ),
          )

        ],
      ),
    );
  }

}