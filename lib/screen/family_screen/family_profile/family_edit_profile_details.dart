import 'package:flutter/material.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';
import 'package:food_waste_proj_v1/screen/widgets/button_global.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../manager_screen/profile/manager_profile.dart';
import '../../widgets/constant.dart';
import 'family_profile_details.dart';

class FamilyEditProfile extends StatefulWidget {
  const FamilyEditProfile({Key? key, required this.info}) : super(key: key);

  final Map<String, dynamic> info;

  @override
  State<FamilyEditProfile> createState() => _FamilyEditProfileState();
}

class _FamilyEditProfileState extends State<FamilyEditProfile> {
  // Create 4 TextEditingController variables: _addressController, _phoneController, _firstNameController, _lastNameController.
  // You cen refer to login.dart on how to create them properly.
  // ADD CODE HERE....
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Create a _getData function, inside set each TextEditingController variable's text to
  // corresponding info (you can get the original user info by using `widget.info!['phone]`, etc)
  // This function is meant to display the original profile info in the text fields when called.
  // ADD CODE HERE.....
  _getData(){
    _addressController.text = widget.info!['address'];
    _phoneController.text = widget.info!['phone'];
    _firstNameController.text = widget.info!['firstName'];
    _lastNameController.text = widget.info!['lastName'];
  }

  // This function is meant to update the user's profile information with the new things they
  //  typed in each text field.
  _updateProfile() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    // Set each widget.info (ex: `widget.info['phone']`) to the corresponding TextEditingController
    // variable's text. Then call the buildLoading function. Call the editUserInfo function from
    // db.dart, passing in the `widget.info`. Add a .then function that returns to the profile page
    // (`Navigator.of(context).pop();`) and call the snapBarBuilder function with a message that
    // lets the user know that their info was updated.
    // ADD CODE HERE......
    widget.info['address'] = _addressController.text;
    widget.info['phone'] = _phoneController.text;
    widget.info['firstName'] = _firstNameController.text;
    widget.info['lastName'] = _lastNameController.text;
    buildLoading();
    editUserInfo(widget.info).then((value){
      Navigator.of(context).pop();
    });
    snapBarBuilder("your info was updated");
  }

  // Function that loads a circular progress indicator
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

  // Function that displays the message passed in as a pop up message at the bottom of the screen.
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
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'Edit Profile',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: context.width(),
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Design the edit profile screen, where there will be a picture of the user along with
                    // the user's name and email. Beneath that, there should be 4 TextFormField widgets, one
                    // for each field (first name, last name, phone number, and address). You can refer to
                    // login.dart or signup.dart for examples on the TextFormField widget.
                    // ADD CODE HERE....
                    Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('images/profile2.png'),
                            radius: 40,
                          ),
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     border: Border.all(color: kLightGrayColor),
                          //     image: const DecorationImage(
                          //         image: AssetImage('images/profile2.png'),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_firstNameController.text} ${_lastNameController.text}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Text(widget.info!['email']),
                              ],
                            ),
                          ),
                        ],
                    ),
                    const SizedBox(height: 30,),
                    TextFormField (
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'First Name',
                          hintText: 'Enter first name'
                      ),
                    ),
                    const SizedBox(height: 18,),
                    TextFormField (
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Last Name',
                          hintText: 'Enter last name'
                      ),
                    ),
                    const SizedBox(height: 18,),
                    TextFormField (
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Phone Number',
                          hintText: 'Enter phone number'
                      ),
                    ),
                    const SizedBox(height: 18,),
                    TextFormField (
                      controller: _addressController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Address',
                          hintText: 'Enter your address'
                      ),
                    ),
                    const SizedBox(height: 18,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // Add the bottomNavigationBar property and used the ButtonGlobalWithoutIcon widget from
      // button_global.dart to design an 'update profile' button at the bottom of the screen.
      // When this button is pressed, call the _updateProfile function.
      // ADD CODE HERE.....
      bottomNavigationBar: ButtonGlobalWithoutIcon(
          buttontext:"update profile",
          buttonDecoration: kButtonDecoration,
          buttonTextColor: kWhite,
          onPressed: () {
            _updateProfile();
            Navigator.pop(context);
          },
      ),
    );
  }
}
