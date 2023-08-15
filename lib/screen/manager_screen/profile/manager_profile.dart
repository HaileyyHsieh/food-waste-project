import 'package:flutter/material.dart';
import '../../../firebase/db.dart';
import '../../widgets/constant.dart';
import '../../widgets/icons.dart';
import '../../../firebase/authentication.dart';
import '../../welcome_screen/welcome_screen.dart';

class ManagerProfile extends StatefulWidget {
  const ManagerProfile({Key? key}) : super(key: key);

  @override
  State<ManagerProfile> createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  Map<String, dynamic> info = {};

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Gets user information from Firestore and sets the controllers' text to the value if the key exists
  _getData() async {
    Map<String, dynamic> temp = await getUserInfo();
    setState(() {
      info = temp;
      if (info.containsKey('phone')){
        _phoneController.text = info['phone'];
      } ;
      if (info.containsKey('name')) {
        _nameController.text = info['name'];
      };
      if (info.containsKey('address')) {
        _addressController.text = info['address'];
      }
    });
  }

  // Updates the user info with the text field info that the user entered
  _updateProfile() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    info['address'] = _addressController.text;
    info['phone'] = _phoneController.text;
    info['name'] = _nameController.text;

    buildLoading();
    editUserInfo(info).then((value){
        Navigator.of(context).pop();
        snapBarBuilder('User Information updated');
    });
  }

  // Loads a circular progress indicator in the center of the page
  buildLoading() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }

  // Displays the passed in string as a message on the bottom of the screen
  snapBarBuilder(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkWhite,
        appBar: AppBar(
          title: Image.asset(
            'images/school.png',
            height: 120,
            width: 120,
          ),
          toolbarHeight: 180,
          backgroundColor: kDarkWhite,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'School Name',
                      hintText: 'Enter school name'
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'School Address',
                      hintText: 'Enter school address'
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'School Phone',
                      hintText: 'Enter school phone'
                  ),
                ),
                const SizedBox(height: 15.0),
                Button(
                  containerBg: kPrimaryColor,
                  borderColor: kLightGrayColor,
                  buttonText: "Add",
                  textColor: kWhite,
                  onPressed: _updateProfile,
                ),
                Button(
                  containerBg: kPrimaryColor,
                  borderColor: kLightGrayColor,
                  buttonText: "Sign out",
                  textColor: kWhite,
                  onPressed: () {
                    AuthenticationHelper().signOut().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      );
                    });
                  }
                ),
              ],
            ),
          ),
        ));
  }
}
