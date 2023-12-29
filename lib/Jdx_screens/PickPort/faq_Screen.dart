import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:job_dekho_app/Jdx_screens/MyProfile.dart';

import 'package:http/http.dart' as http;

import '../../Helper/session.dart';
import '../../Model/GetTmc.dart';
import '../../Utils/Color.dart';



class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  GetTmc? gettmc;
  getTermCondition() async {
    var headers = {
      'Cookie': 'ci_session=6cdba869dc94ddb17fa72596ee8f632530eddbb1'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}Users/TermsCondition'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var ResultTMC = GetTmc.fromJson(jsonDecode(result));
      print(" this is tmccccccccccccccccc${ResultTMC}");
      setState(() {
        gettmc = ResultTMC;
      });
    }
    else {
    print(response.reasonPhrase);
    }
  }

  // getTermCondition()async{
  //   var headers = {
  //     'Cookie': 'ci_session=e27b9a709e79f067f9b5f2e6f6541ff1595521a5'
  //   };
  //   var request = http.MultipartRequest('GET', Uri.parse('${ApiPath.baseUrl}Users/TermsCondition'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResponse = await response.stream.bytesToString();
  //     final jsonResponse = json.decode(finalResponse);
  //     setState(() {
  //       termData = jsonResponse['data'][0]['html'].toString();
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getTermCondition();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: primaryColor,
           
            body : Column(
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
              Text(getTranslated(context, "FAQS"),style: TextStyle(color: whiteColor),),
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
                              const SupportNewScreen()));
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 2,
                  itemBuilder: (context,i){
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor)
                    ),
                    child: const ExpansionTile(
                      title: Text('Faq'),
                      children: [
                        ListTile(
                          title: Text('Subitem 2'),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )


        ),
        )

      ],
    ),
    )
    );
  }
}
