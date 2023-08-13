import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';
import 'package:food_waste_proj_v1/screen/widgets/button_global.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/constant.dart';
import 'family_edit_profile_details.dart';

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

  // Create _getData() function, make it an `async` function. Inside create a temp variable that
  // calls getUserInfo() from db.dart (make sure to put `await` in front). Use a
  // setState() function and set the info variable to the temp variable.
  // ADD CODE HERE..........
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
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'My Profile',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // Create an edit profile button. First, set the bottomNavigationBar property and use the ButtonGlobalWithIcon
      // widget from button_global.dart to create the 'edit profile button'. When this button is clicked,
      // call setState function and inside use the FamilyEditProfile widget (don't forget to pass the
      // required key). Then, attach `.launch(context).then((value) => _getData());` to the FamilyEditProfile
      // widget.
      // ADD CODE HERE.....
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
      // Set the body property and design the profile info page for the user. First check if the `info.isNotEmpty`
      // (using shorthand if/else: info.isNotEmpty ? (code for when true) : (code from when false)), then design
      // the profile info (you can get each field you need by using the info variable, for example, `info['firstName']`).
      // Else if the info is empty, you will just add
      // Center(
      //     child: Column(children: const [
      //     CircularProgressIndicator(),
      //     Text('Loading User information')
      //  ])),
      // ADD CODE HERE......
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
