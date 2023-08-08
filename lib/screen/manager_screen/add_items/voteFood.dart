import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';

import '../../widgets/constant.dart';

class VoteFood extends StatefulWidget {
  const VoteFood({Key? key}) : super(key: key);

  @override
  State<VoteFood> createState() => _VoteFoodState();
}

class _VoteFoodState extends State<VoteFood> {
  Map<String, dynamic> foodMap = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  // gets vote data from Firestore and displays the data for today on the screen
  getData() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now); // formatted date

    // Create a voteLog variable and assign the getVote function from db.dart. Then,
    // use a setState function and check if voteLog contains the formatted date key.
    // If so, set the foodMap variable to voteLog[formatted].
    // ADD CODE HERE.....
    Map<dynamic, dynamic> voteLog = await getVote();
    setState(() {
      if(voteLog.containsKey(formatted)) {
        foodMap = voteLog[formatted];
      }
    });
  }

  Future<void> _addItemBuilder(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    File? image;
    TextEditingController itemController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {

          // Function that opens up the camera to take a picture
          imgFromCamera() async {
            final imageTemp = await picker.pickImage(
                source: ImageSource.camera, imageQuality: 50);

            setState(() {
              image = File(imageTemp!.path);
            });
          }

          // Function that opens up the image gallery for you to choose a photo from
          _imgFromGallery() async {
            final imageTemp = await picker.pickImage(
                source: ImageSource.gallery, imageQuality: 50);

            setState(() {
              image = File(imageTemp!.path);
            });
          }

          // Function that displays the popup dialog to select the image from camera or photo gallery
          imagePopupDialog() {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Design the dialog. It should have a title (Select Image), an x button
                    // that you can click on and cancel (use a GestureDetector widget and set
                    // the onTap property to '() => finish(context),'. The dialog should also
                    // have 2 more GestureDetector widgets, one that calls the imgFromCamera()
                    // function when tapped and one that calls the _imgFromGallery() function
                    // when tapped.
                    // ADD CODE HERE.......
                    Row(
                      children: [
                        const Text("Select Image"),
                        GestureDetector(
                          onTap: () => finish(context),
                          child: const Icon(Icons.cancel),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => imgFromCamera(),
                          child: const Icon(Icons.camera_enhance_rounded),
                        ),
                        GestureDetector(
                            onTap: () => _imgFromGallery(),
                            child: const Icon(Icons.image)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          // Function that displays an image of a variety of food in a container
          imageBuilder() {
            print(image);
            return image != null
                ? Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: kPrimaryColor),
                      image: DecorationImage(image: FileImage(image!)),
                    ),
                  )
                : Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: kPrimaryColor),
                      image: const DecorationImage(
                          image: AssetImage('images/foodLogo.png')),
                    ),
                  );
          }

          // function that calls the imagePopupDialog() to display on the screen
          void showImagePopup() {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: imagePopupDialog(),
                );
              },
            );
          }

          // Initial dialog that displays on the screen right when user clicks on floatingActionButton
          return AlertDialog(
            content: SizedBox(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Design the initial dialog that will have a text field that asks the user to type the item
                    // name, have a image container with a clickable camera icon at the corner, so that the user
                    // can upload/select the item's photo (use a Stack widget to have the camera icon stack on
                    // top of the image container and use a GestureDetector on the camera icon that will call the
                    // showImagePopup function when tapped).
                    // ADD CODE HERE......
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Please type the item name",
                      )
                    ),
                    Stack(
                      children: <Widget>[
                        imageBuilder(),
                        Icon(Icons.camera_enhance_rounded),
                        GestureDetector(
                          onTap: () => showImagePopup()
                        ),
                      ]
                    )
                  ],
                ),
              ),
            ),
            // Set the actions property and add 2 TextButton widgets. One for canceling changes ( you can
            // write 'Navigator.of(context).pop();' for the onPressed property) and one for actually adding
            // the vote item (you can write 'uploadVoteOption(image, itemController.text);' for the onPressed
            // property).
            // ADD CODE HERE.....
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: uploadVoteOption(image, itemController.text),
                child: Text('Add'),
              )
            ],
          );
        });
      },
    );
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  // Function that uploads the vote item information that the user submitted to Firebase and
  // adds the item to the actual screen as well.
  uploadVoteOption(image, item) {
    final destination = 'vote/ ${item}';
    changeFileNameOnly(image!, item).then((filename) {
      image = filename;
      uploadFile(destination, image!)!.then((snapshot) {
        snapshot.ref.getDownloadURL().then((url) {
          print(url);
          Map<String, dynamic> food = {'item': item, 'image': url, 'numberVote':0};

          setState(() {
            foodMap[item] = food;
            addVote(foodMap);
            Navigator.of(context).pop();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      // Design the appbar (you can add a food image in the center and set the background color)
      // ADD CODE HERE.....
      appBar: AppBar(
        title: Image.asset(
          'images/vote.png',
          height: 100,
          width: 100,
        ),
        toolbarHeight: 70,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(30.0),
        //     bottomRight: Radius.circular(30.0),
          // ),
        // ),
      ),

      body: Container(
        height: context.height(),
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
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
            children: [
              const SizedBox(height: 20.0),
              ListView.builder(
                itemCount: foodMap.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10.0),
                itemBuilder: (_, index) {
                  String key = foodMap.keys.elementAt(index);
                  // Return a ListTile widget and design it to display the vote item image (foodMap[key]['image']!)
                  // and vote item name (foodMap[key]['item']!).
                  // ADD CODE HERE....
                  return ListTile(
                    leading: Image.network(foodMap[key]['image']!),
                    title: Text(foodMap[key]['item']!)
                  );
                },
              )
            ],
          ),
        ),
      ),
      // Set the floatingActionButton property to a FloatingActionButton widget and design
      // the 'Add Item' button. For the onPressed property, write '_addItemBuilder(context);'.
      // ADD CODE HERE.......
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItemBuilder(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
