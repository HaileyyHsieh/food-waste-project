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
    // Map tempVoteLog = await getVote(); // gets vote document
    await getVote().then((data) {
      Map tempVoteLog = data;

      List<String> tempStaticsPeriod = [];
      print("tempVoteLog: $tempVoteLog");
      tempVoteLog.forEach((date, items) { // queries through the vote doc and saves each date in tempStaticsPeriod array
        print("date: $date");
        print("items: $items");
        tempStaticsPeriod.add(date);
      });
      print("dates");
      print(tempStaticsPeriod);
      setState(() {
        staticsPeriod = tempStaticsPeriod; // list of statistics date in vote
        staticsPeriod.sort((a, b) => b.compareTo(a));
        if (staticsPeriod!.isNotEmpty) {
          selectedStaticsPeriod = staticsPeriod[0]; // sets the selected statistics date
          voteLog = tempVoteLog; // saves vote doc in voteLog
          updateData();
        }
      });
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
      backgroundColor: kDarkWhite,
      // Design app bar can you listTile widget to add leading and title properties
      appBar: AppBar(
        title: Text("voting statistics"),
        leading: Image.asset('images/school.png'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
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
                  // Design a container section to display the vote statistics, which will include a title and dropdown menu on one line
                  // and a circle chart with it's key to read the chart below (if dataMap.isNotEmpty, you will use the RecordStatistics widget
                  // from chart.dart to display the chart, else you will use a SizedBox widget and display the text 'no data'.
                  // ADD CODE HERE......
                  Container(
                    decoration: BoxDecoration(
                      color: kDarkWhite,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("voting statistics",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 100,
                              height: 100,

                              child: DropdownButtonHideUnderline(
                                child: getStatisticsPeriod(),
                              ),
                            ),
                          ],
                        ),
                        dataMap.isNotEmpty ?
                        RecordStatistics(dataMap:dataMap,colorList: colorList,) :
                        SizedBox(child:Text("no data"),),
                      ],
                    )
                  ),


                  // Design a container section to display the list of vote items information.
                  // Use a ListView.builder widget to display each food picture, name, and number of votes.
                  // ADD CODE HERE......
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

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    Key? key,
    required this.iconColor,
    required this.title,
    required this.value,
  }) : super(key: key);

  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 16.0,
          color: iconColor,
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kTextStyle.copyWith(color: kSubTitleColor),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              value,
              style: kTextStyle.copyWith(
                  color: kNeutralColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
