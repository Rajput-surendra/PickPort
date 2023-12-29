import 'package:flutter/material.dart';
import 'package:job_dekho_app/Jdx_screens/signin_Screen.dart';
import 'package:job_dekho_app/Utils/color.dart';
import '../Helper/session.dart';
import '../main.dart';
import 'Utils/color.dart';
import 'Utils/color.dart';
import 'Utils/color.dart';

class ChangeLanguage extends StatefulWidget {
  bool? back;
  ChangeLanguage({this.back});


  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {

  int? selectLan;

  @override
  void initState() {
    new Future.delayed(Duration.zero, () {
      languageList = [
        getTranslated(context, 'ENGLISH_LAN'),
        getTranslated(context, 'HINDI_LAN'),
        getTranslated(context, 'MARATHI_LAN'),

      ];
      setState(() {

      });
    });

    super.initState();

  }
  final GlobalKey<FormState> _changePwdKey = GlobalKey<FormState>();
  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_LANGUAGE_LBL"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:15.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(onPressed: (){
                             // Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInScreen()));
                            },style: ElevatedButton.styleFrom(backgroundColor:Color(0xFF3700b3) ), child:Icon(Icons.arrow_forward))),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
  Widget getHeading(String title) {
    print("here is title value ${title}");
    return Text(
      getTranslated(context, title).toString(),
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }
  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget bottomsheetLabel(String labelName) => Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
    child: getHeading(labelName,),
  );
  List<String> langCode = ["en", "hi","mr"];
  List<String?> languageList = [];
  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              if (mounted)
                setState(() {
                  selectLan = index;
                  _changeLan(langCode[index], ctx);
                });
              setModalState((){});
            },
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    border: selectLan == index ? Border.all(color: primaryColor):Border.all(color:Colors.transparent)
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                       leading: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 10.0,
                            ),
                            child: Text(
                              languageList[index].toString(),
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                  color: Colors.black),
                            )),
                        trailing: Container(
                          height: 25.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectLan == index
                                  ? Colors.transparent
                                  : Colors.white,
                              border: Border.all(color: Secondry)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: selectLan == index
                                ? Icon(
                              Icons.check,
                              size: 17.0,
                              color:selectLan == index
                                  ? primaryColor
                                  : Colors.white,
                            )
                                : Icon(
                                Icons.check_box_outline_blank,
                                size: 15.0,
                                color:whiteColor
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // index == languageList.length - 1
                //     ? Container(
                //         margin: EdgeInsetsDirectional.only(
                //           bottom: 10,
                //         ),
                //       )
                //     : Divider(
                //         color: Theme.of(context).colorScheme.lightBlack,
                //       ),
              ],
            ),
          )),
    )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);
  print('__________${_locale}_________');
    MyApp.setLocale(ctx, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primaryColor,
      appBar: AppBar(backgroundColor:primaryColor ,
        toolbarHeight: 60,
        centerTitle: true,
        title: bottomsheetLabel("CHOOSE_LANGUAGE_LBL",),
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
              color: backGround
            ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _changePwdKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 30,),
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setModalState) {
                              return SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: getLngList(context, setModalState)),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  getTranslated(context,'CONTINUES'),
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: primaryColor
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              )
          )

      ),
    );
  }

// _createLanguageDropDown() {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: Colors.black),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: DropdownButton<LanguageModel>(
//         iconSize: 30,
//         underline: SizedBox(),
//         hint: Text(getTranslated(context, 'CHOOSE_LANGUAGE_LBL')),
//         onChanged: (LanguageModel? language) {
//           changeLanguage(context, language!.languageCode);
//         },
//         items: LanguageModel.languageList()
//             .map<DropdownMenuItem<LanguageModel>>(
//               (e) => DropdownMenuItem<LanguageModel>(
//             value: e,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Text(
//                   e.flag,
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 Text(e.name)
//               ],
//             ),
//           ),
//         )
//             .toList(),
//       ),
//     ),
//   );
// }
}