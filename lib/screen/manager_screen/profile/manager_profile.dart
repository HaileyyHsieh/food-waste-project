import 'package:flutter/material.dart';
import '../../../firebase/db.dart';
import '../../widgets/constant.dart';
import '../../widgets/icons.dart';

class ManagerProfile extends StatefulWidget {
  const ManagerProfile({Key? key}) : super(key: key);

  @override
  State<ManagerProfile> createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  Map<String, dynamic> info = {};

  // Create 3 TextEditingController variables: _addressController, _phoneController, _nameController
  // ADD CODE HERE....
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Gets user information from Firestore and sets the controllers' text to the value if the key exists
  _getData() async {
    // Create a temp variable and call getUserInfo() function from db.dart. Add a setState function and
    // set info = temp, then check if the info variable contains each key (phone, name, address). You can
    // do so by using the containsKey function, which returns T/F (e.g. info.containsKey('phone') ). If
    // info does contain that key, then set the corresponding TextEditingController variable's text
    // to the info variable's key (e.g. info['phone']).
    // ADD CODE HERE.......

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

    // Set each key (phone, name, address) in the info variable to the corresponding
    // TextEditingController text. Then, call the buildLoading function. Next, call the
    // editUserInfo function from db.dart. Add a .then function that hides the keyboard
    // (Navigator.of(context).pop();) and call the snapBarBuilder function with the string
    // 'User Information updated.'
    // ADD CODE HERE......

    info['address'] = _addressController.text;
    info['phone'] = _phoneController.text;
    info['name'] = _nameController.text;

    buildLoading();
    editUserInfo(info).then(
      (value){
        Navigator.of(context).pop();
        snapBarBuilder('User Information updated');
      }
    );
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
        // Add appbar property and design app bar
        // ADD CODE HERE......

        appBar: AppBar(
          title: Image.asset(
            'images/school.png',
            height: 100,
            width: 100,
          ),
          toolbarHeight: 180,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add 3 TextFormField widgets: school name, school address, school phone number and
                // add a 'Add' button using the Button widget from icons.dart file, when button is pressed
                // call _updateProfile function
                // ADD CODE HERE.....

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
              ],
            ),
          ),
        ));
  }
}
