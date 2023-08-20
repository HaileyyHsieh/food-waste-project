import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';
import 'package:food_waste_proj_v1/screen/widgets/button_global.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/constant.dart';
import 'family_edit_profile_details.dart';
import '../../../firebase/authentication.dart';
import '../../welcome_screen/welcome_screen.dart';

class FamilyProfileDetails extends StatefulWidget {
  const FamilyProfileDetails({Key? key}) : super(key: key);

  @override
  State<FamilyProfileDetails> createState() => _FamilyProfileDetailsState();
}

class _FamilyProfileDetailsState extends State<FamilyProfileDetails> {
  Map<String, dynamic> info = {};

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    Map<String,dynamic> temp = await getUserInfo();
    setState(() {
      info = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'My Profile',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                AuthenticationHelper().signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                });
              },
              icon: Icon(Icons.logout_outlined, color: kPrimaryColor,)
          )
        ],
      ),
      bottomNavigationBar: ButtonGlobalWithIcon(
        buttonIcon: Icons.edit,
        buttontext: "edit profile",
        buttonDecoration: kButtonDecoration,
        buttonTextColor: kWhite,
        onPressed: (){
          setState(() {
            FamilyEditProfile(
              info: info,
            ).launch(context).then((value) => _getData());
          });
        },
      ),
      body: info.isNotEmpty?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/profile2.png'),
                    radius: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Family Member Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("First Name: ${info['firstName']}",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Last Name: ${info['lastName']}",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Email: ${info['email']}",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Address: ${info['address']}",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Phone Number: ${info['phone']}",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],

              ),

          ),
        )
      :Center(
        child: Column(children: const [
        CircularProgressIndicator(),
        Text('Loading User information')
     ]),
      )
    );
  }
}
