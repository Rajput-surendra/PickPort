import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_dekho_app/Jdx_screens/Payment%20method.dart';
import 'package:job_dekho_app/Jdx_screens/parcelStetus.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customDrawerTile.dart';
import 'package:job_dekho_app/Utils/color.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Jdx_screens/changepassword_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/contactus_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/notification_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/signin_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/privacypolicy_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/termsandcondition_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/session.dart';
import '../Model/getprofilemodel.dart';
import '../Utils/api_path.dart';
import 'Mywallet.dart';
import 'PickPort/ReferAndEran.dart';
import 'PickPort/faq_Screen.dart';
import 'Support.dart';
import 'UserProfile.dart';
import 'Dashbord.dart';
import 'Generate Ticket.dart';
import 'feedbackscreen.dart';
import 'parcel_history.dart';
import '../Utils/iconUrl.dart';
import 'package:http/http.dart' as http;

import 'support_chat/chat_page.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {



  var profileImage;

  Getprofilemodel? getprofile;
  getuserProfile() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userid = preferences.getString("userid");
    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}User_Dashboard/getUserProfile'));
    request.fields.addAll({
      'user_id': userid.toString()
    });
    print("this is userId=========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = Getprofilemodel.fromJson(json.decode(finalResult));
      print("this is userIddddddddddddddd=========>${jsonResponse}");
      print("this is userIbbbbbbbbbbbbbbbbbbbbb=========>${finalResult}");
      setState(() {
        getprofile = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  openLogoutDialog(){
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          title: Text("Are you sure want to logout app ?",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  prefs.setString('userid', "");
                  setState((){
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child:  Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'Lora'),),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.red,
                  ),
                  child:  Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'Lora'),),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Share',
        // text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App',style: TextStyle(fontFamily: 'Lora'),),
        content: const Text('Do you want to exit an App?',style: TextStyle(fontFamily: 'Lora'),),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No',style: TextStyle(fontFamily: 'Lora'),),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: (){
              exit(0);
              // Navigator.pop(context,true);
              // Navigator.pop(context,true);
            },
            //return true when click on "Yes"
            child:Text('Yes',style: TextStyle(fontFamily: 'Lora'),),
          ),
        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
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
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  var gaurdianData;


  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getuserProfile();

    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(

        backgroundColor: primaryColor,
      body:  Column(
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
                  Text(getTranslated(context, "My Account"),style: TextStyle(color: whiteColor),),
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
                child:   getprofile == null || getprofile == "" ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    /* showModalBottomSheet(
                                context: context,
                                builder: (context){
                                  return Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Take Image From", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                        ListTile(leading: Image.asset('assets/ProfileAssets/cameraicon.png', scale: 1.5,),
                                          title: Text('Camera', style: TextStyle(fontWeight: FontWeight.bold)),
                                          onTap: (){
                                            _getFromCamera();
                                          },
                                        ),
                                        ListTile(leading: Image.asset('assets/ProfileAssets/galleryicon.png', scale: 1.5,),
                                          title: const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold)),
                                          onTap: (){
                                            _getFromGallery();
                                          },
                                        ),
                                        ListTile(leading: Image.asset('assets/ProfileAssets/cancelicon.png', scale: 1.5,),
                                          title: const Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold)),
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                });*/
                                  },
                                  child: Align(
                                    // alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        getprofile == null || getprofile == "" || getprofile != null ?  Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: whiteColor
                                          ),
                                          child:getprofile?.data?[0].userImage != null ? ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child:Image.network("${getprofile!.data![0].userImage}")) : Image.asset('assets/ProfileAssets/sampleprofile.png'),
                                        ) :
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: whiteColor
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child:Image.network("${getprofile?.data![0].userImage}",fit: BoxFit.fill,),
                                          ),
                                        ),
                                        /*Positioned(
                                  bottom: 20,
                                  right: 10,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                    ),
                                    child: Image.asset('assets/ProfileAssets/camera_Icon.png', scale: 1.8,),
                                  ),),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${getprofile?.data?[0].userFullname}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text("${getprofile?.data?[0].userEmail}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  // Text("Jdx1234@gmail.com",),
                                ],
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  Get.to(UserProfile(
                                    getprofile: getprofile,
                                  ));
                                },
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                      color: purpleColor,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Image.asset('assets/ProfileAssets/editIcon.png',color: primaryColor, scale: 1.3,),
                                ),
                              ),

                            ],
                          ),
                          CustomDrawerTile(tileName: getTranslated(context, "Pickport Wallet"), tileIcon: Image.asset(wattetIcons,color: Secondry, scale: 1.3,), onTap: (){Get.to(MyWallet());},),
                          CustomDrawerTile(tileName: getTranslated(context, "Payment"), tileIcon: Image.asset(paymentIcons,color: Secondry, scale: 1.3,),onTap: (){Get.to(PaymentMethod1());},),
                          CustomDrawerTile(tileName: getTranslated(context, "Refer and earn"), tileIcon: Image.asset(referAndEran,color: Secondry, scale: 1.3,),onTap: (){Get.to(ReferAndEranScreen());},),
                        //  CustomDrawerTile(tileName: 'Parcel History ', tileIcon: Icon(Icons.history_sharp,color: primaryColor,),onTap: (){Get.to(ParcelHistory());},),
                          CustomDrawerTile(tileName: getTranslated(context, "Change Password"), tileIcon: Image.asset(changepasswordIconR,color: Secondry, scale: 1.3,), onTap: (){Get.to(ChangePasswordScreen());},),
                          // CustomDrawerTile(tileName: 'Generate Ticket', tileIcon: Image.asset(changepasswordIconR,color: primaryColor, scale: 1.3,),onTap: (){Get.to(GenerateTicket());},),

                          // CustomDrawerTile(tileName: 'Support', tileIcon: Image.asset(shareappIconR,color: primaryColor, scale: 1.3,),onTap: (){Get.to(share());},),
                          ///  CustomDrawerTile(tileName: 'Support', tileIcon: Image.asset(shareappIconR,color: primaryColor, scale: 1.3,),onTap: (){Get.to(SupportScreens());},),
                          //  CustomDrawerTile(tileName: 'Feedback', tileIcon: Image.asset(privactpolicyIconR,color: primaryColor, scale: 1.3,), onTap: (){Get.to(FeedbackScreen());},),
                          /*CustomDrawerTile(tileName: 'Parcel Status', tileIcon: Image.asset(privactpolicyIconR,color: primaryColor, scale: 1.3,), onTap: (){Get.to(ParcelStetus());},),*/
                          //  CustomDrawerTile(tileName: 'Notification', tileIcon: Image.asset(notificationIconR, scale: 1.3,),onTap: (){Get.to(NotificationScreen());}),
                          CustomDrawerTile(tileName: getTranslated(context, "Privacy Policy"), tileIcon: Image.asset(privactpolicyIconR,color: Secondry, scale: 1.3,), onTap: (){Get.to(PrivacyPolicyScreen());},),
                          CustomDrawerTile(tileName: getTranslated(context, "Terms and Conditions"), tileIcon: Image.asset(termsandconditionIconR,color: Secondry, scale: 1.3,),onTap: (){Get.to(TermsAndConditionScreen());},),
                          CustomDrawerTile(tileName: getTranslated(context, "FAQS"), tileIcon: Image.asset(termsandconditionIconR,color: Secondry, scale: 1.3,),onTap: (){Get.to(FaqScreen());},),
                          //  CustomDrawerTile(tileName: 'Contact Us', tileIcon: Image.asset(contactusIconR,color: primaryColor, scale: 1.3,), onTap: (){Get.to(const ContactUsScreen());},),
                          // CustomDrawerTile(tileName: 'Sign Out', tileIcon: Image.asset(signoutIconR,color: primaryColor, scale: 1.3,),onTap: (){
                          //
                          //   },),

                          SizedBox(height: 20,),
                          InkWell(
                              onTap: () {

                                openLogoutDialog();
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
                                child:  Text(getTranslated(context, "Logout"), style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,),),
                              )),
                          SizedBox(height: 20,),
                        ],
                      )
                    ],
                  ),
                ),


            ),
          )

        ],
      ),


    ));
  }
}

