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

class DonateFood extends StatefulWidget {
  const DonateFood({Key? key}) : super(key: key);

  @override
  State<DonateFood> createState() => _DonateFoodState();
}

class _DonateFoodState extends State<DonateFood> {
  Map<String, dynamic> foodMap = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  // gets food data from Firestore and displays the data for today on the screen
  getData() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now); // formatted date

    Map foodLog = await getFood();

    setState(() {
      if (foodLog.containsKey(formatted)) {
        foodMap = foodLog[formatted];
      }
    });
  }

  Future<void> _addItemBuilder(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    File? image;
    TextEditingController quantity_controller = TextEditingController();
    TextEditingController item_controller = TextEditingController();

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
                    Row(
                      children: [
                        const Text("Select Image"),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => finish(context),
                          child: const Icon(Icons.cancel),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imgFromCamera();
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              const Icon(
                                Icons.camera_enhance_rounded,
                                color: kPrimaryColor,
                                size: 40,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Take Photo',
                                style: kTextStyle.copyWith(
                                    color: kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _imgFromGallery();
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              const Icon(
                                Icons.image,
                                color: kLightNeutralColor,
                                size: 40,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Photo Gallery',
                                style:
                                kTextStyle.copyWith(color: kLightNeutralColor),
                              ),
                            ],
                          ),
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

          // Function that calls the imagePopupDialog() to display on the screen
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
                    Image.asset('images/addFood.png', height: 100),
                    TextField(
                        controller: item_controller,
                        decoration: InputDecoration(
                          labelText: "item name",
                        )
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        controller: quantity_controller,
                        decoration: InputDecoration(
                          labelText: "quantity",
                        )
                    ),
                    SizedBox(height: 20,),
                    Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          imageBuilder(),
                          GestureDetector(
                            onTap: () => showImagePopup(),
                            child:Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: kWhite,
                                shape: BoxShape.circle,
                                border: Border.all(color: kPrimaryColor),
                              ),
                              child: const Icon(
                                Icons.camera_enhance_rounded,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ]
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    uploadFood(
                        image, item_controller.text, quantity_controller.text);
                  });
                  Navigator.of(context).pop();
                },
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

  // Function that uploads the food item information that the user submitted to Firebase and
  // adds the item to the actual screen as well.
  uploadFood(image, item, quantity) {
    final destination = 'food/ $item';
    changeFileNameOnly(image!, item).then((filename) {
      image = filename;
      uploadFile(destination, image!)!.then((snapshot) {
        snapshot.ref.getDownloadURL().then((url) {
          print(url);
          Map<String, dynamic> food = {
            'item': item,
            'image': url,
            'quantity': quantity
          };

          setState(() {
            foodMap[item] = food;
            addFood(foodMap);
          });
        });
      });
    });
  }

  // Function that displays the food quantity pop up dialog when user tries to update the quantity
  // of a food displayed
  Future<void> _quantityBuilder(BuildContext context, item) {
    TextEditingController quantity_controller = TextEditingController();
    print(item);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        quantity_controller.text = '${foodMap[item]['quantity']}';
        return AlertDialog(
          title: const Text('Add Item'),
          content: TextField(
              controller: quantity_controller,
              decoration:
              InputDecoration(labelText: item, hintText: 'quantity')
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  foodMap[item]['quantity'] = quantity_controller.text;
                  addFood(foodMap);
                });

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            )
          ],
        );
      },
    );
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
        title: Image.asset('images/foodLogo.png'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
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
                    return Card(
                      child: ListTile(
                        leading: Image.network(foodMap[key]['image']!),
                        title: Text(foodMap[key]['item']!),
                        subtitle: Text('Quantities: ${foodMap[key]['quantity']}'),
                        trailing: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: kPrimaryColor,
                          ),
                          child: GestureDetector(
                            onTap: () => _quantityBuilder(context, key),
                            child: Text(
                              'Update',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextStyle.copyWith(
                                  color: kWhite, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItemBuilder(context);
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
