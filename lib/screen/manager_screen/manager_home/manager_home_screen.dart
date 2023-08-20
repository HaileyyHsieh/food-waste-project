import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:food_waste_proj_v1/screen/widgets/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../firebase/db.dart';
import '../../widgets/chart.dart';

class ManagerHomeScreen extends StatefulWidget {
  const ManagerHomeScreen({Key? key}) : super(key: key);

  @override
  State<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen> {
  List<String> staticsPeriod = [];
  String? selectedStaticsPeriod;
  Map voteLog = {};
  Map<String, double> dataMap = {};

  Map<String, dynamic> voteMap = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Map tempVoteLog = await getVote(); // gets vote document
    List<String> tempStaticsPeriod = [];

    tempVoteLog.forEach((date, items) { // queries through the vote doc and saves each date in tempStaticsPeriod array
      tempStaticsPeriod.add(date);
    });
    setState(() {
      staticsPeriod = tempStaticsPeriod; // list of statistics date in vote
      staticsPeriod.sort((a, b) => b.compareTo(a));
      if (staticsPeriod!.isNotEmpty) {
        selectedStaticsPeriod = staticsPeriod[0]; // sets the selected statistics date
        voteLog = tempVoteLog; // saves vote doc in voteLog
        updateData();
      }
    });
  }

  updateData() {
    voteMap = voteLog[selectedStaticsPeriod]; // voteMap is set to the vote doc of the selected statistics date
    print(voteMap);
    Map<String, double> temDataMap = {};
    voteMap.forEach((key, value) { // for each vote item in the selected statistic date and saves the food item name and number of votes for that item info
      temDataMap[voteMap[key]['item']] = voteMap[key]['numberVote'].toDouble();
    });

    print(dataMap);

    setState(() {
      dataMap = temDataMap;
    });
  }

  //__________statistics_time_period_____________________________________________________
  DropdownButton<String> getStatisticsPeriod() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in staticsPeriod) { // for each statistic date from vote doc, add as an item to drop drop menu
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: kTextStyle.copyWith(color: kSubTitleColor),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton( // creates that actual drop down button with list of statistics date; with the default set to the selected date and allowing the user to select and change the data from the drop down
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedStaticsPeriod,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedStaticsPeriod = value!;
        });
        updateData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text("voting statistics"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset('images/school.png'),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kDarkWhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("voting statistics",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              SizedBox(
                                child: DropdownButtonHideUnderline(
                                  child: getStatisticsPeriod(),
                                ),
                              ),
                            ],
                          ),
                          dataMap.isNotEmpty ?
                          RecordStatistics(dataMap:dataMap,colorList: colorList,) :
                          SizedBox(
                            child:Text(
                                textAlign: TextAlign.center, "no data"),
                            height: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListView.builder(
                        itemCount: voteMap.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index){
                          String key = voteMap.keys.elementAt(index);
                          return ListTile(
                              leading:Image.network(voteMap[key]['image']),
                              title:Text('${voteMap[key]['item']}'),
                              trailing:Text('${voteMap[key]['numberVote']}'),
                          );
                        }
                    ),
                  ),
                ]),
          ),
        ),
      ),
    ));
  }
}
