import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nomadlist/data/data.dart';
import 'package:nomadlist/databasehelper.dart';
import 'package:nomadlist/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class DetailPage extends StatefulWidget {
  Data item;
//   int addindex;
// //  final controller = CardController();
//   List<Data> list = [];
//  Function onSwipe;
  DetailPage(this.item);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  // Data item;
  // _DetailPageState(this.item);
  int currentindex = 0;
  late TabController _controller ;
  final loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eget mauris pharetra et ultrices.";

  String str = "";
  int current_index = 0;

  void _handleTabController(){
    setState(() {
      currentindex = _controller.index;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    //index = widget.addindex;
    print("index...${index}");
    setState(() {

    });
    super.dispose();
  }
  static  List<Widget> _widgetOptions = <Widget>[
    //  FoodDetails(widget.item),

    Text(
      'Index 1: Business',

    ),
    Text(
      'Index 2: School',

    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      current_index = index;
    });
  }
  var model;
  final TextStyle _style =
  TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black);

  final double circularRadius = 30;
  final String weatherApiId = "ffac25e9af1c1e5fa0b22aaf5723a8d9";
  late WeatherData _weatherData;
  bool isWeatherloaded = false;
  late CurrentAir _air;
  bool isAirLoaded = false;
  final moreArray = [false, false, false, false, false, false, false,false,false];
  late List<String> moreData;
  late double distance;
  bool distanceLoaded = false;
  int _page = 0;
  late Widget body;
  late List<Data> currentList;
  late int current;

  Future<void> optionSelected(int index, String option, List<Data> list) async {
    widget.item.option = option;
    DataBaseHelper.instance.updateOption(widget.item);
    list.add(widget.item);
    //widget.onSwipe();
    Navigator.pop(context);
  }
  // final pages = [
  //   FoodDetails(widget.item),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   SeeAll(),
  // ];

  void initState() {
    super.initState();
    //l
    moreData=[
      "first $loremIpsum $loremIpsum",
      "second $loremIpsum",
      "thrid $loremIpsum",
      "fourth $loremIpsum",
      "fivth$loremIpsum",
      "sixth $loremIpsum",
      "seventh $loremIpsum",
    ];
    // index = widget.addindex;
    //print("index...${widget.addindex}");
    loadWeather();
    loadAir();
    loadDistance();
    // _controller = TabController(length: 7, vsync: this,initialIndex: 0);
    // _controller.addListener(_handleTabController);
    // _controller.animateTo(0);
  }

  int index = 0;
  void optionPageCalled(String title, List<Data> list) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => OptionPage(title, list,widget.onSwipe)),
    // );
  }

   String MAIN = "Main";
   String INTERESTED = "Interested";
   String DONE = "Done";
   String SKIP = "Skip";
   String MOUNTAIN = "Mountain";
   String BEACH = "Beach";
   String PARK = "Park";

  // Future<void> changeBody(int index) async {
  //   print("nbjjjjjj"+index.toString());
  //   List<Data> list = [];
  //   if (index == 0) {
  //     mainList.forEach((element) async {
  //       if (element.option == MAIN) {
  //         list.add(element);
  //       }
  //     });
  //   } else if (index == 1) {
  //     mainList.forEach((element) async {
  //       if (element.category == PARK && element.option == MAIN) {
  //         list.add(element);
  //       }
  //     });
  //   } else if (index == 2) {
  //     mainList.forEach((element) async {
  //       if (element.category == BEACH && element.option == MAIN) {
  //         list.add(element);
  //       }
  //     });
  //   } else if (index == 3) {
  //     mainList.forEach((element) async {
  //       if (element.category == MOUNTAIN && element.option == MAIN) {
  //         list.add(element);
  //         print("zhgbdgkd${list.length}");
  //       }
  //     });
  //   } else {
  //     var list = await DataBaseHelper.instance.queryAll();
  //     setState(() {
  //       _page = index;
  //       print("intrestlist${interestedList.length }${skipList.length}${doneList.length}");
  //       body = DashBoardScreen(
  //         interested: interestedList.length,
  //         skipped: skipList.length,
  //         doneList: doneList,
  //         totalList: list,
  //       );
  //     });
  //     return;
  //   }
  //
  //   currentList = list;
  //   print("cureentlist.......${currentList.length}");
  //   current = currentList.length - 1;
  //   print("current  $current");
  //   setState(() {
  //     _page = index;
  //     print(_page);
  //     // body = gridview(currentList);
  //     //swiperWidget(currentList);
  //   });
  // }

  Future<void> checkFirst() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var first = sharedPreferences.getBool('First') ?? true;
    var list = [
      Data(
          url:
          "https://images.unsplash.com/photo-1574950578143-858c6fc58922?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
          title: "Mountain",
          option: MAIN,
          lat: 0,
          lon: 0,
          area: 1500,
          density: 5,
          category: MOUNTAIN, id: 1,
          t_title: 'cold now',
          icon: Icons.wb_sunny,
          temp: "10.0 °C",
          wifi: "20mb",
          color: Colors.yellow,
          city: "Ko Pha Ngan",
          image: "assets/images/kopha.jpg",
          cold: "5 °",
          costvalue:" 0.5",
          fun: "0.7",
          allvalue: "0.8"),
      Data(
          url:
          "https://images.unsplash.com/photo-1536048810607-3dc7f86981cb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
          title: "River",
          option: MAIN,
          lat: 10,
          lon: 10,
          area: 1000,
          density: 5,
          category: MOUNTAIN,id: 0,
          t_title: 'Warm now',
          icon: Icons.wb_sunny,
          temp: "50.0 °C",
          wifi: "15 mb",
          color: Colors.yellow,
          city: "Gran Canarial",
          image: "assets/images/gran.jpg",
          cold: "15 °",
          costvalue:" 0.3",
          fun: "0.6",
          allvalue: "0.9"),
      Data(
          url:
          "https://images.unsplash.com/photo-1561016696-094e2baeab5e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
          title: "Waterfall",
          option: MAIN,
          lat: 20,
          lon: 20,
          area: 150,
          density: 5,
          category: MOUNTAIN,id: 1,
          t_title: 'cold now',
          icon: Icons.wb_sunny,
          temp: "10.0 °C",
          wifi: "20mb",
          color: Colors.yellow,
          city: "Ko Pha Ngan",
          image: "assets/images/kopha.jpg",
          cold: "5 °",
          costvalue:" 0.5",
          fun: "0.7",
          allvalue: "0.8"),
      Data(
          url:
          "https://images.unsplash.com/photo-1541789094913-f3809a8f3ba5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          title: "Dessert",
          option: MAIN,
          lat: 30,
          lon: 30,
          area: 800,
          density: 5,
          category: BEACH,id: 3,
          t_title: 'Fast internet',
          icon: Icons.wb_sunny,
          temp: "20.0 °C",
          wifi: "50mb",
          color: Colors.yellow,
          city: "Lisbon",
          image: "assets/images/lisbon.jpg",
          cold: "35 °",
          costvalue:" 0.2",
          fun: "0.8",
          allvalue: "0.9"),
      Data(
          url:
          "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          title: "City",
          option: MAIN,
          lat: 40,
          lon: 40,
          area: 1500,
          density: 5,
          category: BEACH,id: 4,
          t_title: 'cold now',
          icon: Icons.wb_sunny,
          temp: "12.0 °C",
          wifi: "30mb",
          color: Colors.yellow,
          city: "Austin",
          image: "assets/images/kopha.jpg",
          cold: "7 °",
          costvalue:" 0.5",
          fun: "0.7",
          allvalue: "0.8"),
      Data(
          url:
          "https://images.unsplash.com/photo-1528826542659-27db5adea13c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1759&q=80",
          title: "Village",
          option: MAIN,
          lat: 50,
          lon: 50,
          area: 1400,
          density: 5,
          category: BEACH,id: 5,
          t_title: ' Fast internet',
          icon: Icons.wb_sunny,
          temp: "16.0 °C",
          wifi: "22mb",
          color: Colors.yellow,
          city: "Budapest",
          image: "assets/images/kopha.jpg",
          cold: "7 °",
          costvalue:" 0.5",
          fun: "0.7",
          allvalue: "0.8"),
      Data(
          url:
          "https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=307&q=80",
          title: "Ocean",
          option: MAIN,
          lat: 60,
          lon: 60,
          area: 1800,
          density: 5,
          category: PARK,id: 6,
          t_title: 'cold now',
          icon: Icons.wb_sunny,
          temp: "20.0 °C",
          wifi: "28mb",
          color: Colors.yellow,
          city: "Ericeira",
          image: "assets/images/kopha.jpg",
          cold: "15 °",
          costvalue:" 0.5",
          fun: "0.7",
          allvalue: "0.6"),
      Data(
          url:
          "https://images.unsplash.com/photo-1543470388-80a8f5281639?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
          title: "Icebreg",
          option: MAIN,
          lat: 70,
          lon: 70,
          area: 1500,
          density: 5,
          category: PARK,id: 7,
          t_title: 'cold now',
          icon: Icons.wb_sunny,
          temp: "20.0 °C",
          wifi: "28mb",
          color: Colors.yellow,
          city: "Ericeira",
          image: "assets/images/kopha.jpg",
          cold: "15 °",
          costvalue:" 0.5",
          fun: "0.7",
          allvalue: "0.6"),
    ];
    if (first) {
      list.forEach((element) async {
        await DataBaseHelper.instance.insert(element);
      });
    }
    await sharedPreferences.setBool("First", false);
    return;
  }

  tab(){
    return  Column(
      children: [
        // widget(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  index = 0;
                  this.setState(() {

                  });
                },
                child: moreListItem(
                    Icons.info, "About",  index == 0 ? Colors.blueGrey.shade400 : Colors.white),
              ),
              GestureDetector(
                onTap: (){
                  index = 1;
                  this.setState(() {

                  });
                },
                child: moreListItem(Icons.person, "Tipping & Customs",
                    index == 1 ?Colors.blueGrey.shade400:   Colors.white),
              ),
              GestureDetector(
                onTap: (){
                  index = 2;
                  this.setState(() {

                  });
                },
                child: moreListItem(Icons.festival, "Festivals",
                    index == 2?    Colors.blueGrey.shade400 : Colors.white),
              ),
              GestureDetector(
                  onTap: (){
                    index = 3;
                    this.setState(() {

                    });
                  },child: moreListItem(Icons.language, "Languages",index == 3?  Colors.blueGrey.shade400: Colors.white)),
              GestureDetector(
                onTap: (){
                  index = 4;
                  this.setState(() {
                  });
                },
                child: moreListItem(Icons.business_rounded, "Offical info center",
                    index == 4? Colors.blueGrey.shade400 :  Colors.white),
              ),
              GestureDetector(
                onTap: (){
                  index = 5;
                  this.setState(() {

                  });
                },
                child: moreListItem(Icons.date_range, "Days to cover",
                    index == 5 ? Colors.blueGrey.shade400 :  Colors.white),
              ),
              GestureDetector(
                onTap: (){
                  index = 6;
                  this.setState(() {

                  });
                },
                child: moreListItem(Icons.not_interested, "Things to Avoid",
                    index == 6 ? Colors.blueGrey.shade400:   Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8,left: 8),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      index = 7;
                      this.setState(() {

                      });
                    },
                    child: Container(
                      //  color: Colors.green,
                      //  width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //  width: 170,
                              alignment: Alignment.topLeft,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: index == 7 ? Colors.blueGrey.shade400 :  Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: index == 7 ? Colors.blueGrey.shade400 :  Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          //  mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "See All",
                                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                                              //_style.copyWith(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.clear_all,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              moreArray[index] = !moreArray[index];
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(""
                                                // (!moreArray[index]) ? "More" : "less",
                                                // style: _style.copyWith(fontWeight: FontWeight.bold),
                                              ),
                                              // Icon(
                                              //   (!moreArray[index])?Icons.arrow_drop_down:Icons.arrow_drop_up,
                                              //   color: Colors.white,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ]
                      ),
                    ),
                  ),
                ),





              )
            ],
          ),
        ),
        index == 7?Container(
            alignment: Alignment.topLeft,
            width: 420,
            //  height: 200,
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: moreData.length,
                shrinkWrap: true,
                itemBuilder: (context, i){
                  return Container(
                      child:  Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    i == 0 ? "About :-": i == 1? "Tipping & Customs :-": i == 2?"Festivals :-": i == 3? "Languages :-": i == 4 ?"Offical info center :-" : i == 5? "Days to cover :-" : i == 6? "Things to Avoid :-" : "See All :-",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),),

                                Container(
                                  width: 200,
                                  child: Text(
                                    moreData[i],
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]
                      )
                  );
                })):
        Container(
            child: Container(
              alignment: Alignment.topLeft,
              width: 420,
              //  height: 200,
              padding: EdgeInsets.all(8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      child: Text(
                        index == 0 ? "About :-": index == 1? "Tipping & Customs :-": index == 2?"Festivals :-": index == 3? "Languages :-": index == 4 ?"Offical info center :-" : index == 5? "Days to cover :-" : index == 6? "Things to Avoid :-" : "See All :-",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),),
                    Container(
                      width: 250,
                      child: Text(
                        moreData[index],
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )

                  ]
              ),
            )
        ),

      ],

    );
  }
 // final controller = CardController();
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  void loadDistance() async{

    var position = await GeolocatorPlatform.instance
        .getCurrentPosition();


    var currentPostion = LatLng(position.latitude, position.longitude);

    distance = calculateDistance(widget.item.lat, widget.item.lon, currentPostion.latitude, currentPostion.longitude);

    print("Distance: $distance Km");

    setState(() {
      distanceLoaded = true;
    });

  }

  void loadWeather() {
    model = widget.item;
    this.setState(() {

    });
   // print("latttttt33 ${widget.item.lat}");
    fetchCurrentWeatherData(widget.item.lat, widget.item.lon).then((value) {
      _weatherData = value;
      setState(() {
        isWeatherloaded = true;
      });
    });
  }

  static Future<void> openMap(double latitude, double longitude) async {
    print("co ords - $latitude $longitude");
    String googleUrl = 'comgooglemaps://?center=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      print('Could not open the map.');
    }
  }

  void loadAir() {
    print("latttttt33 ${widget.item.lat}");
    fetchCurrentAirData(widget.item.lat, widget.item.lon).then((value) {
      _air = value;
      setState(() {
        isAirLoaded = true;
      });
    });
  }

  Future<CurrentAir> fetchCurrentAirData(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$weatherApiId"));
    if (response != null) {
      return CurrentAir.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed of Load Current Air Data");
    }
  }
  // Future<void> checkFirst() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var first = sharedPreferences.getBool('First') ?? true;
  //   var list = [
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1574950578143-858c6fc58922?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  //         title: "Mountain",
  //         option: MAIN,
  //         lat: 0,
  //         lon: 0,
  //         area: 1500,
  //         density: 5,
  //         category: MOUNTAIN),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1536048810607-3dc7f86981cb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
  //         title: "River",
  //         option: MAIN,
  //         lat: 10,
  //         lon: 10,
  //         area: 1000,
  //         density: 5,
  //         category: MOUNTAIN),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1561016696-094e2baeab5e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
  //         title: "Waterfall",
  //         option: MAIN,
  //         lat: 20,
  //         lon: 20,
  //         area: 150,
  //         density: 5,
  //         category: MOUNTAIN),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1541789094913-f3809a8f3ba5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
  //         title: "Dessert",
  //         option: MAIN,
  //         lat: 30,
  //         lon: 30,
  //         area: 800,
  //         density: 5,
  //         category: BEACH),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
  //         title: "City",
  //         option: MAIN,
  //         lat: 40,
  //         lon: 40,
  //         area: 1500,
  //         density: 5,
  //         category: BEACH),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1528826542659-27db5adea13c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1759&q=80",
  //         title: "Village",
  //         option: MAIN,
  //         lat: 50,
  //         lon: 50,
  //         area: 1400,
  //         density: 5,
  //         category: BEACH),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=307&q=80",
  //         title: "Ocean",
  //         option: MAIN,
  //         lat: 60,
  //         lon: 60,
  //         area: 1800,
  //         density: 5,
  //         category: PARK),
  //     Data(
  //         url:
  //         "https://images.unsplash.com/photo-1543470388-80a8f5281639?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  //         title: "Icebreg",
  //         option: MAIN,
  //         lat: 70,
  //         lon: 70,
  //         area: 1500,
  //         density: 5,
  //         category: PARK),
  //   ];
  //   if (first) {
  //     list.forEach((element) async {
  //       await DataBaseHelper.instance.insert(element);
  //     });
  //   }
  //   await sharedPreferences.setBool("First", false);
  //   return;
  // }

  Future<WeatherData> fetchCurrentWeatherData(double lat, double lon) async {
    // print(
    // "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiId");
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiId"));
    return WeatherData.fromJson(jsonDecode(response.body));
  }
  bool isLoading = true;
  // Future<void> loadLists() async {
  //   await checkFirst();
  //   var list = await DataBaseHelper.instance.queryAll();
  //   print("Length: ${list.length}");
  //   list.forEach((element) async {
  //     //   print("${element.id} , ${element.option}, ${element.category}");
  //     switch (element.option) {
  //       case MAIN:
  //       case SKIP:
  //         mainList.add(element);
  //         break;
  //       case INTERESTED:
  //         interestedList.add(element);
  //         break;
  //       case DONE:
  //         doneList.add(element);
  //         break;
  //     }
  //   });
  //
  //   currentList = mainList;
  //   print("currentlist....${currentList.length}");
  //   current = currentList.length - 1;
  //   //body = gridview(currentList);
  //   //swiperWidget(currentList);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                height: screenSize.height * .8,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        widget.item.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white38,
                        child: IconButton(
                          icon: Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    padding:
                                    EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                                    height: 50,
                                    child: Text(
                                      widget.item.city,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // height: screenSize.height * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.item.city,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      loremIpsum,
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (isWeatherloaded)
                      ? basicDetailCircle("Temp",
                      "${(_weatherData.main.temp - 273.15).ceil()} °C")
                      : loadCircle("Temp"),
                  (isWeatherloaded)
                      ? basicDetailCircle(
                      "Weather", "${_weatherData.weather[0].main}")
                      : loadCircle("Weather"),
                  (isAirLoaded)
                      ? basicDetailCircle(
                      "Air Quality", "${getAirQualityString(_air.pm10)}")
                      : loadCircle("Air Quality"),
                  basicDetailCircle("Area", "${widget.item.area}"),
                  basicDetailCircle("Density", "${widget.item.density}"),
                ],
              ),
              SizedBox(
                height: 10,
              ),



              SizedBox(
                height: 10,
              ),

              Stack(
                children: [
                  Container(
                    height: 300,
                    width: screenSize.width,
                    child: FlutterMap(
                      options: MapOptions(
                        center: latlng.LatLng(widget.item.lat, widget.item.lon),
                        zoom: 5.0,
                      ),
                      layers: [
                        TileLayerOptions(
                            urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: latlng.LatLng(widget.item.lat, widget.item.lon),
                              builder: (ctx) => Container(
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,top: 12),
                      child: distanceLoaded?Container(
                          clipBehavior: Clip.hardEdge,
                          //width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      Text("Distance: ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                                      Text("${distance.toStringAsFixed(2)} Km", style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    color: Colors.indigo,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: (){
                                        print('tapped');
                                        MapsLauncher.launchCoordinates(
                                          widget.item.lat, widget.item.lon, );
                                        //openMap(widget.item.lat, widget.item.lon);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.location_on,color: Colors.white,size: 18,),
                                          Text('Open in Maps',style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ):Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white,
                          child:
                          Container(
                            width: 150,
                            height: 68,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.black
                            ),
                          )),
                    ),

                  ),


                ],
              ),
              // Container(
              //   height: 40,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       locationClip(Icons.fastfood, "food",Colors.red,Colors.white),
              //       locationClip(Icons.public, "Public Place",Colors.red,Colors.white),
              //       locationClip(Icons.home_outlined, "Heritage Sites",Colors.red,Colors.white),
              //       locationClip(Icons.local_hospital, "Hospital",Colors.red,Colors.white),
              //       locationClip(Icons.park, "park",Colors.red,Colors.white),
              //       locationClip(Icons.directions_bus_rounded, "Bus Station",Colors.red,Colors.white),
              //       locationClip(
              //           Icons.directions_railway_rounded, "Railway Station",Colors.red,Colors.white),
              //       locationClip(Icons.signal_cellular_connected_no_internet_4_bar, "Internet Service",Colors.red,Colors.white),
              //       locationClip(Icons.landscape, "Tourist Information",Colors.red,Colors.white)
              //     ],
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     OutlinedButton(
              //       onPressed: () {
              //       //  optionSelected(widget.addindex, INTERESTED, interestedList);
              //       },
              //       child: Text(
              //         "Option2",
              //       ),
              //     ),
              //     OutlinedButton(
              //       onPressed: () {
              //      //   optionSelected(widget.addindex, SKIP,skipList);
              //       },
              //       child: Text(
              //         "Skip",
              //       ),
              //     ),
              //     OutlinedButton(
              //       onPressed: () {
              //      //    optionSelected(widget.addindex, DONE, doneList);
              //       },
              //       child: Text(
              //         "Option3",
              //       ),
              //     )
              //   ],
              // ),
              // (isLoading)
              //     ? Center(
              //   child: CircularProgressIndicator(),
              // )
              //     : body,
              SizedBox(height: 15,),
              tab(),

              SizedBox(height: 50,)
              // PreferredSize(
              // preferredSize: _tabBar.preferredSize,
              // child: ColoredBox(
              // color: Colors.white,
              // child: _tabBar
              // )),
              // Container(
              //   child:  Container(
              //     child:  (moreArray[0])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[0],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[1])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[1],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[2])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[2],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[3])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[3],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[4])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[4],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[5])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[5],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[6])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[1],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):
              //       (moreArray[7])?Container(
              //         width: 400,
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           moreData[7],
              //           style: TextStyle(
              //             fontSize: 17,
              //           ),
              //         ),
              //       ):Container(),
              //
              //
              //   ),
              // )
              // Column(
              //   children: [
              //     moreListItem(
              //         Icons.info, "About", Colors.orangeAccent, 0),
              //     moreListItem(Icons.person, "Tipping & Customs",
              //         Colors.redAccent,1),
              //     moreListItem(Icons.festival, "Festivals",
              //         Colors.blueGrey.shade400, 2),
              //     moreListItem(Icons.language, "Languages", Colors.brown.shade400,3),
              //     moreListItem(Icons.business_rounded, "Offical info center",
              //         Colors.deepPurple.shade400,4),
              //     moreListItem(Icons.date_range, "Days to cover",
              //         Colors.grey.shade400, 5),
              //     moreListItem(Icons.not_interested, "Things to Avoid",
              //         Colors.deepPurple.shade400, 6),
              //     SizedBox(height: 30,)
              //   ],
              // )
            ],
          ),
        ),
        //  IndexedStack(
        //  index: current_index,
        //  children: [
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //  FoodDetails(widget.item),
        //    FoodDetails(widget.item),
        //   // FoodDetails(widget.item),
        //      SeeAllPage("See All",  widget.list)
        // // SeeAll()
        //
        //  ],
        //  )
        //   Center(
        //     child: _widgetOptions.elementAt(current_index),
      ),


      //pages[current_index]
    );
  }

  String getAirQualityString(String pm_10) {
    var aqi = double.parse(pm_10);
    if (aqi <= 100) {
      return "Good";
    } else if (aqi <= 200) {
      return "Moderate";
    } else if (aqi <= 300) {
      return "fine";
    } else {
      return "bad";
    }
  }

  Widget loadCircle(String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: circularRadius,
          backgroundColor: Colors.indigo,
          child: CircularProgressIndicator(),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        )
      ],
    );
  }

  Widget basicDetailCircle(String name, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: circularRadius,
          backgroundColor: Colors.indigo,
          child: Text(
            value,
            style: _style,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        )
      ],
    );
  }
  // Widget gridview(List<Data> list){
  //   return  (currentList.length > 0) ?SingleChildScrollView(
  //     child: Container(
  //       color: Colors.white,
  //       child: ListView(
  //         children: [
  //           Container(
  //             height: MediaQuery.of(context).size.height * .8,
  //             child: Stack(
  //               children: [
  //                 Positioned.fill(
  //                   child: Image.network(
  //                     widget.item.url,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 50,
  //                   left: 10,
  //                   child: CircleAvatar(
  //                     backgroundColor: Colors.white38,
  //                     child: IconButton(
  //                       icon: Icon(Icons.clear, color: Colors.white),
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned.fill(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(15.0),
  //                             child: BackdropFilter(
  //                               filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  //                               child: Container(
  //                                 padding:
  //                                 EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
  //                                 height: 50,
  //                                 child: Text(
  //                                   widget.item.title,
  //                                   style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontWeight: FontWeight.bold,
  //                                       letterSpacing: 2,
  //                                       fontSize: 17),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         Container(
  //                           // height: screenSize.height * 0.25,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.only(
  //                                 topLeft: Radius.circular(25),
  //                                 topRight: Radius.circular(25),
  //                               ),
  //                               color: Colors.white),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(16.0),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Text(
  //                                   widget.item.title,
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.w500, fontSize: 15),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 Text(
  //                                   loremIpsum,
  //                                 ),
  //                                 // SizedBox(
  //                                 //   height: 10,
  //                                 // ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               (isWeatherloaded)
  //                   ? basicDetailCircle("Temp",
  //                   "${(_weatherData.main.temp - 273.15).ceil()} °C")
  //                   : loadCircle("Temp"),
  //               (isWeatherloaded)
  //                   ? basicDetailCircle(
  //                   "Weather", "${_weatherData.weather[0].main}")
  //                   : loadCircle("Weather"),
  //               (isAirLoaded)
  //                   ? basicDetailCircle(
  //                   "Air Quality", "${getAirQualityString(_air.pm10)}")
  //                   : loadCircle("Air Quality"),
  //               basicDetailCircle("Area", "${widget.item.area}"),
  //               basicDetailCircle("Density", "${widget.item.density}"),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //
  //
  //
  //           SizedBox(
  //             height: 10,
  //           ),
  //
  //           Stack(
  //             children: [
  //               Container(
  //                 height: 300,
  //                 width: screenSize.width,
  //                 child: FlutterMap(
  //                   options: MapOptions(
  //                     center: latlng.LatLng(widget.item.lat, widget.item.lon),
  //                     zoom: 5.0,
  //                   ),
  //                   layers: [
  //                     TileLayerOptions(
  //                         urlTemplate:
  //                         "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  //                         subdomains: ['a', 'b', 'c']),
  //                     MarkerLayerOptions(
  //                       markers: [
  //                         Marker(
  //                           width: 80.0,
  //                           height: 80.0,
  //                           point: latlng.LatLng(widget.item.lat, widget.item.lon),
  //                           builder: (ctx) => Container(
  //                             child: Icon(
  //                               Icons.location_pin,
  //                               color: Colors.deepOrange,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               Align(
  //                 alignment: Alignment.topLeft,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(left: 8,top: 12),
  //                   child: distanceLoaded?Container(
  //                       clipBehavior: Clip.hardEdge,
  //                       //width: 80,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(8)),
  //                         color: Colors.white,
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(12.0),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             IntrinsicWidth(
  //                               child: Row(
  //                                 children: [
  //                                   Text("Distance: ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
  //                                   Text("${distance.toStringAsFixed(2)} Km", style: TextStyle(color: Colors.black),),
  //                                 ],
  //                               ),
  //                             ),
  //                             SizedBox(height: 12,),
  //                             Container(
  //                               clipBehavior: Clip.hardEdge,
  //                               width: 130,
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.all(Radius.circular(40)),
  //                                 color: Colors.indigo,
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: InkWell(
  //                                   onTap: (){
  //                                     print('tapped');
  //                                     MapsLauncher.launchCoordinates(
  //                                       widget.item.lat, widget.item.lon, );
  //                                     //openMap(widget.item.lat, widget.item.lon);
  //                                   },
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                     children: [
  //                                       Icon(Icons.location_on,color: Colors.white,size: 18,),
  //                                       Text('Open in Maps',style: TextStyle(color: Colors.white),),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       )
  //                   ):Shimmer.fromColors(
  //                       baseColor: Colors.grey[400],
  //                       highlightColor: Colors.white,
  //                       child:
  //                       Container(
  //                         width: 150,
  //                         height: 68,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.all(Radius.circular(10)),
  //                             color: Colors.black
  //                         ),
  //                       )),
  //                 ),
  //
  //               ),
  //
  //
  //             ],
  //           ),
  //           // Container(
  //           //   height: 40,
  //           //   child: ListView(
  //           //     scrollDirection: Axis.horizontal,
  //           //     children: [
  //           //       locationClip(Icons.fastfood, "food",Colors.red,Colors.white),
  //           //       locationClip(Icons.public, "Public Place",Colors.red,Colors.white),
  //           //       locationClip(Icons.home_outlined, "Heritage Sites",Colors.red,Colors.white),
  //           //       locationClip(Icons.local_hospital, "Hospital",Colors.red,Colors.white),
  //           //       locationClip(Icons.park, "park",Colors.red,Colors.white),
  //           //       locationClip(Icons.directions_bus_rounded, "Bus Station",Colors.red,Colors.white),
  //           //       locationClip(
  //           //           Icons.directions_railway_rounded, "Railway Station",Colors.red,Colors.white),
  //           //       locationClip(Icons.signal_cellular_connected_no_internet_4_bar, "Internet Service",Colors.red,Colors.white),
  //           //       locationClip(Icons.landscape, "Tourist Information",Colors.red,Colors.white)
  //           //     ],
  //           //   ),
  //           // ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               OutlinedButton(
  //                 onPressed: () {
  //                   controller.triggerLeft();
  //                 },
  //                 child: Text(
  //                   "Option2",
  //                 ),
  //               ),
  //               OutlinedButton(
  //                 onPressed: () {
  //                   controller.triggerUp();
  //                 },
  //                 child: Text(
  //                   "Skip",
  //                 ),
  //               ),
  //               OutlinedButton(
  //                 onPressed: () {
  //                   controller.triggerRight();
  //                 },
  //                 child: Text(
  //                   "Option3",
  //                 ),
  //               )
  //             ],
  //           ),
  //           (isLoading)
  //               ? Center(
  //             child: CircularProgressIndicator(),
  //           )
  //               : body,
  //           SizedBox(height: 15,),
  //           tab(),
  //
  //           SizedBox(height: 50,)
  //           // PreferredSize(
  //           // preferredSize: _tabBar.preferredSize,
  //           // child: ColoredBox(
  //           // color: Colors.white,
  //           // child: _tabBar
  //           // )),
  //           // Container(
  //           //   child:  Container(
  //           //     child:  (moreArray[0])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[0],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[1])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[1],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[2])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[2],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[3])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[3],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[4])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[4],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[5])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[5],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[6])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[1],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):
  //           //       (moreArray[7])?Container(
  //           //         width: 400,
  //           //         padding: EdgeInsets.all(8),
  //           //         child: Text(
  //           //           moreData[7],
  //           //           style: TextStyle(
  //           //             fontSize: 17,
  //           //           ),
  //           //         ),
  //           //       ):Container(),
  //           //
  //           //
  //           //   ),
  //           // )
  //           // Column(
  //           //   children: [
  //           //     moreListItem(
  //           //         Icons.info, "About", Colors.orangeAccent, 0),
  //           //     moreListItem(Icons.person, "Tipping & Customs",
  //           //         Colors.redAccent,1),
  //           //     moreListItem(Icons.festival, "Festivals",
  //           //         Colors.blueGrey.shade400, 2),
  //           //     moreListItem(Icons.language, "Languages", Colors.brown.shade400,3),
  //           //     moreListItem(Icons.business_rounded, "Offical info center",
  //           //         Colors.deepPurple.shade400,4),
  //           //     moreListItem(Icons.date_range, "Days to cover",
  //           //         Colors.grey.shade400, 5),
  //           //     moreListItem(Icons.not_interested, "Things to Avoid",
  //           //         Colors.deepPurple.shade400, 6),
  //           //     SizedBox(height: 30,)
  //           //   ],
  //           // )
  //         ],
  //       ),
  //     ),
  //   ):Center(
  //     child: Text(
  //         "List is empty now... Come back Later"),
  //
  //   );
  // }

  Widget locationClip(IconData icons, String name,Color color,Color textcolor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 10),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),

        child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(
                icons,
                color: textcolor,
              ),
              // label:
              SizedBox(width: 5,),
              Text(
                name,
                style: TextStyle(
                  color: textcolor,
                ),
              ),
              SizedBox(width: 10,),
              // style: ElevatedButton.styleFrom(
              //   primary:color,
              //   shape: StadiumBorder(),
              // ),
            ]
        ),
      ),
    );
  }

  Widget moreListItem(IconData icons, String name, Color color) {
    return Padding(
        padding: const EdgeInsets.only(right: 8,left: 8),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            //  width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //  width: 170,
                      alignment: Alignment.topLeft,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  //  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      name,
                                      style: _style.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      icons,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      moreArray[index] = !moreArray[index];
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(""
                                        // (!moreArray[index]) ? "More" : "less",
                                        // style: _style.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      // Icon(
                                      //   (!moreArray[index])?Icons.arrow_drop_down:Icons.arrow_drop_up,
                                      //   color: Colors.white,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ])
          ),
        )





    );
  }
// Future<void> optionSelected(String option, List<Data> list,int page) async {
//   print("cureentlist.....${interestedList.length}");
//   /// interestedList[widget.addindex].option = option;
//   DataBaseHelper.instance.updateOption(interestedList[page]);
//   list.add(interestedList[page]);
//   print("list....${list.length}");
// //  onSwipe();
// }




}

class WeatherData {
  WeatherData({
    required this.weather,
    required this.base,
    required this.main,
    required this.dt,
    required this.name,
  });

  List<Weather> weather;
  String base;
  Main main;
  int dt;
  String name;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    weather:
    List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    base: json["base"],
    main: Main.fromJson(json["main"]),
    dt: json["dt"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "base": base,
    "main": main.toJson(),
    "dt": dt,
    "name": name,
  };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
  };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class CurrentAir {
  final String aqi;
  final String co;
  final String no;
  final String no2;
  final String o3;
  final String so2;
  final String pm2_5;
  final String pm10;
  final String nh3;

  CurrentAir({
    required this.aqi,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  factory CurrentAir.fromJson(Map<String, dynamic> json) {
    return CurrentAir(
      aqi: json["list"][0]["main"]["aqi"].toString(),
      no: json["list"][0]["components"]["co"].toString(),
      no2: json["list"][0]["components"]["no2"].toString(),
      o3: json["list"][0]["components"]["o3"].toString(),
      so2: json["list"][0]["components"]["so2"].toString(),
      pm2_5: json["list"][0]["components"]["pm2_5"].toString(),
      pm10: json["list"][0]["components"]["pm10"].toString(),
      nh3: json["list"][0]["components"]["nh3"].toString(), co: '',
    );
  }
}
