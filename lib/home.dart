import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nomadlist/constanse/linearprogressbar.dart';
import 'package:nomadlist/data/data.dart';
import 'package:nomadlist/detail/detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with TickerProviderStateMixin{
  List<CityModel> cities = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController filterController = TextEditingController();
  bool is_show = false;
  final List<String> city = [
    'Warm now',
    'cold now',
    'Fast internet',
    'Mild now'
  ];
  List<Data> searchlist = [];
  bool enable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CityModel cityModel = new CityModel(
        title: "Warm now",
        icon: Icons.wb_sunny,
        temp: 50.0,
        wifi: 15,
        color: Colors.yellow,
        city: "Gran Canarial",
        image: "assets/images/gran.jpg",
        cold: 57,
        costvalue:" 0.3",
        fun: "0.6",
        allvalue: "0.9");
    CityModel cityModel1 = new CityModel(
        title: "Warm now",
        icon: Icons.wb_cloudy,
        temp: 20.0,
        wifi: 20,
        color: Colors.lightBlueAccent,
        city: "Ko Pha Ngan",
        image: "assets/images/kopha.jpg",
        cold: 48,
        costvalue:" 0.5",
        fun: "0.7",
        allvalue: "0.9");
    CityModel cityModel2 = new CityModel(
        title: "Warm now",
        icon: Icons.wb_cloudy_outlined,
        temp: 10.0,
        wifi: 50,
        color: Colors.lightBlueAccent,
        city: "Lisbon",
        image: "assets/images/lisbon.jpg",
        cold: 15,
        costvalue:" 0.6",
        fun: "0.4",
        allvalue: "0.8");
    CityModel cityModel3 = new CityModel(
        title: "Warm now",
        icon: Icons.wb_sunny,
        temp: 23.4,
        wifi: 5,
        color: Colors.yellow,
        city: "Visit Canada",
        image: "assets/images/gran.jpg",
        cold: 12,
        costvalue:" 0.5",
        fun: "0.9",
        allvalue: "10");
    CityModel cityModel4 = new CityModel(
        title: "Warm now",
        icon: Icons.wb_sunny,
        temp: 90.0,
        wifi: 120,
        color: Colors.yellow,
        city: "Gran Canarial",
        image: "assets/images/lisbon.jpg",
        cold: 10,
        costvalue:" 0.3",
        fun: "0.6",
        allvalue: "0.9");
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();

    cities.add(cityModel);
    cities.add(cityModel1);
    cities.add(cityModel2);
    cities.add(cityModel3);
    cities.add(cityModel4);
  }

  String id = "";
  late AnimationController controller;



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Nomadlist")),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  filterfield(),
                   Padding(
                    padding: EdgeInsets.only(right: 30, left: 30, top: 43),
                    child: Visibility(
                      visible: enable,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 250,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text(
                                  "Show all filter",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                )),
                              ),
                              searchlist.length != 0 ||
                                      filterController.text.isNotEmpty ||
                                      searchlist.length > 0
                                  ? ListView.builder(
                                      itemCount: searchlist.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, int index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Text(
                                                  searchlist[index].title)),
                                        );
                                      })
                                  : ListView.builder(
                                      itemCount: choices.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            sortdata(index);
                                            setState(() {});
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child:
                                                  Text(choices[index].title)),
                                        );
                                      }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.0,
                  mainAxisSpacing: 18.0,
                  children: List.generate(cities.length, (index) {
                    return Center(
                      child:Stack(
                        children: [
                          GestureDetector(
                            onTap: (){
                              is_show = true;
                              id = index.toString();
                              setState(() {

                              });
                            },
                            child: SelectCard(cityModel: cities[index], is_show: is_show,),
                          ),
                      index.toString() == id ?     GestureDetector(
                            onTap: (){
                              
                            },
                            child: SelectvisibleCard(is_show: false,title: 'All',icon: Icons.star,value:cities[index].fun.toString(),costvalue:cities[index].costvalue,wifivalue: cities[index].wifi.toString(),all: cities[index].allvalue  ,color: Colors.green, cityModel: choices[index]),
                          ) : Container()
                        ],
                      )
                    );
                  })),
            ],
          ),
        ));
  }

  void sortdata(int index) {
    if (index == 0) {
      cities.sort((a, b) {
        var adate = a.temp;
        var bdate = b.temp;
        return bdate.compareTo(adate);
      });
    } else if (index == 1) {
      cities.sort((a, b) {
        var adate = a.temp;
        var bdate = b.temp;
        return adate.compareTo(bdate);
      });
    } else if (index == 2) {
      cities.sort((a, b) {
        var adate = a.wifi;
        var bdate = b.wifi;
        return bdate.compareTo(adate);
      });
    }

    enable = false;
    setState(() {});
  }

  serchfield() {
    return Row(
      children: [
        Container(
          width: 100,
          child: Image.asset("assets/images/icon.png"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 100,
            color: Colors.red,
            child: Container(
              width: 100,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal),
                  controller: searchController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search",
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  List<Data> list = [];

  filterfield() {
    return GestureDetector(
      onTap: () {
        enable ? enable = false : enable = true;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(200)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 45,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(200)),
                  child: Center(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      onChanged: onSearchTextChanged,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal),
                      controller: filterController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Search or Filter",
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                enable == true
                    ? GestureDetector(
                        onTap: () {
                          enable = false;
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          enable = true;
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchlist.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    choices.forEach((userDetail) {
      if (userDetail.title.contains(text)) searchlist.add(userDetail);
    });

    setState(() {});
  }
}

class Choice {
  const Choice(
      {required this.title,
      required this.icon,
      required this.temp,
      required this.wifi,
      required this.color,
      required this.city,
      required this.image,
      required this.cold,
        required this.costvalue,
        required this.fun,
        required this.allvalue,
      });

  final String title;
  final IconData icon;
  final String temp;
  final String wifi;
  final Color color;
  final String city;

  final String image;
  final String cold;
  final String? costvalue;
  final String? fun;
  final String? allvalue;

//  final coldnow

}

class CityModel {
  const CityModel(
      {required this.title,
      required this.icon,
      required this.temp,
      required this.wifi,
      required this.color,
      required this.city,
      required this.image,
      required this.cold,
        required this.costvalue,
        required this.fun,
        required this.allvalue,

      });

  final String title;
  final IconData icon;
  final double temp;
  final double wifi;
  final Color color;
  final String city;

  final String image;
  final double cold;
  final String? costvalue;
  final String? fun;
  final String? allvalue;

}
String MAIN = "Main";
String INTERESTED = "Interested";
String DONE = "Done";
String SKIP = "Skip";
String MOUNTAIN = "Mountain";
String BEACH = "Beach";
String PARK = "Park";
var choices = [
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

// const List<Data> choices =  <Data>[
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1574950578143-858c6fc58922?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
//       title: "Mountain",
//       option: MAIN,
//       lat: 0,
//       lon: 0,
//       area: 1500,
//       density: 5,
//       category: MOUNTAIN, id: 1,
//       t_title: 'cold now',
//       icon: Icons.wb_sunny,
//       temp: "10.0 °C",
//       wifi: "20mb",
//       color: Colors.yellow,
//       city: "Ko Pha Ngan",
//       image: "assets/images/kopha.jpg",
//       cold: "5 °",
//       costvalue:" 0.5",
//       fun: "0.7",
//       allvalue: "0.8"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1536048810607-3dc7f86981cb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
//       title: "River",
//       option: MAIN,
//       lat: 10,
//       lon: 10,
//       area: 1000,
//       density: 5,
//       category: MOUNTAIN,id: 0,
//       t_title: 'Warm now',
//       icon: Icons.wb_sunny,
//       temp: "50.0 °C",
//       wifi: "15 mb",
//       color: Colors.yellow,
//       city: "Gran Canarial",
//       image: "assets/images/gran.jpg",
//       cold: "15 °",
//       costvalue:" 0.3",
//       fun: "0.6",
//       allvalue: "0.9"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1561016696-094e2baeab5e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
//       title: "Waterfall",
//       option: MAIN,
//       lat: 20,
//       lon: 20,
//       area: 150,
//       density: 5,
//       category: MOUNTAIN,id: 1,
//       t_title: 'cold now',
//       icon: Icons.wb_sunny,
//       temp: "10.0 °C",
//       wifi: "20mb",
//       color: Colors.yellow,
//       city: "Ko Pha Ngan",
//       image: "assets/images/kopha.jpg",
//       cold: "5 °",
//       costvalue:" 0.5",
//       fun: "0.7",
//       allvalue: "0.8"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1541789094913-f3809a8f3ba5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
//       title: "Dessert",
//       option: MAIN,
//       lat: 30,
//       lon: 30,
//       area: 800,
//       density: 5,
//       category: BEACH,id: 3,
//       t_title: 'Fast internet',
//       icon: Icons.wb_sunny,
//       temp: "20.0 °C",
//       wifi: "50mb",
//       color: Colors.yellow,
//       city: "Lisbon",
//       image: "assets/images/lisbon.jpg",
//       cold: "35 °",
//       costvalue:" 0.2",
//       fun: "0.8",
//       allvalue: "0.9"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
//       title: "City",
//       option: MAIN,
//       lat: 40,
//       lon: 40,
//       area: 1500,
//       density: 5,
//       category: BEACH,id: 4,
//       t_title: 'cold now',
//       icon: Icons.wb_sunny,
//       temp: "12.0 °C",
//       wifi: "30mb",
//       color: Colors.yellow,
//       city: "Austin",
//       image: "assets/images/kopha.jpg",
//       cold: "7 °",
//       costvalue:" 0.5",
//       fun: "0.7",
//       allvalue: "0.8"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1528826542659-27db5adea13c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1759&q=80",
//       title: "Village",
//       option: MAIN,
//       lat: 50,
//       lon: 50,
//       area: 1400,
//       density: 5,
//       category: BEACH,id: 5,
//       t_title: ' Fast internet',
//       icon: Icons.wb_sunny,
//       temp: "16.0 °C",
//       wifi: "22mb",
//       color: Colors.yellow,
//       city: "Budapest",
//       image: "assets/images/kopha.jpg",
//       cold: "7 °",
//       costvalue:" 0.5",
//       fun: "0.7",
//       allvalue: "0.8"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=307&q=80",
//       title: "Ocean",
//       option: MAIN,
//       lat: 60,
//       lon: 60,
//       area: 1800,
//       density: 5,
//       category: PARK,id: 6,
//       t_title: 'cold now',
//       icon: Icons.wb_sunny,
//       temp: "20.0 °C",
//       wifi: "28mb",
//       color: Colors.yellow,
//       city: "Ericeira",
//       image: "assets/images/kopha.jpg",
//       cold: "15 °",
//       costvalue:" 0.5",
//       fun: "0.7",
//       allvalue: "0.6"),
//   Data(
//       url:
//       "https://images.unsplash.com/photo-1543470388-80a8f5281639?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
//       title: "Icebreg",
//       option: MAIN,
//       lat: 70,
//       lon: 70,
//       area: 1500,
//       density: 5,
//       category: PARK,id: 7,
//       t_title: 'cold now',
//       icon: Icons.wb_sunny,
//       temp: "20.0 °C",
//       wifi: "28mb",
//       color: Colors.yellow,
//       city: "Ericeira",
//       image: "assets/images/kopha.jpg",
//       cold: "15 °",
//       costvalue:" 0.5",
//       fun: "0.7",
//       allvalue: "0.6"),
// ];
class SelectCard extends StatelessWidget {
  // Data model;
   SelectCard({Key? key, required this.cityModel,required this.is_show}) : super(key: key);
  final CityModel cityModel;
  bool is_show = false;

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme;
    return Card(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken),
              image: AssetImage(cityModel.image),
              fit: BoxFit.fill)),
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.wifi,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(cityModel.wifi.toString()+" Mbps",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  )),
              Expanded(
                  child: Center(
                      child: Text(cityModel.city.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w700)))),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      cityModel.icon,
                      size: 20.0,
                      color: cityModel.color,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Center(
                        child: Text(cityModel.temp.toString()+" °C",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700))),
                    SizedBox(
                      width: 3,
                    ),
                  ],
                ),
              )
            ]),
      ),
    ));
  }
 
}

class SelectvisibleCard extends StatefulWidget {
  String? title;
  IconData icon;
  String? value;
  Color color;
  String? costvalue;
  String? wifivalue;
  String? all;
  Data cityModel;
   SelectvisibleCard({Key? key,required this.is_show,this.title,required this.icon,required this.value,required this.color,
   this.costvalue,this.wifivalue,this.all,required this.cityModel}) : super(key: key);
  bool is_show = false;

  @override
  State<SelectvisibleCard> createState() => _SelectvisibleCardState();
}

class _SelectvisibleCardState extends State<SelectvisibleCard>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: visiblecard(),
    );
  }

  visiblecard(){
    return Container(
      height:200,
      color: Colors.black.withOpacity(0.90),
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(widget.icon,color: Colors.yellow,size: 18,),
              SizedBox(width: 10,),
              Text("All",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
              SizedBox(width: 10,),
              Container(
                width: 70,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green
                ),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustomLinearProgressbar(value: double.parse(widget.all.toString()),color: widget.color,)
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.money,color: Colors.green,size: 18,),
              Text("Cost",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
              Container(
                width: 70,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red
                ),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child:CustomLinearProgressbar(value: double.parse(widget.costvalue.toString()),color: widget.color,)
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.wifi,color: Colors.blueAccent,size: 18,),
              Text("Wifi",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
              Container(
                width: 70,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green
                ),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child:CustomLinearProgressbar(value: double.parse(widget.wifivalue.toString()),color: widget.color,),
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             // Icon(Icons.face,color: Colors.yellow,size: 18,),
              Text("😄",style: TextStyle(color: Colors.yellow,fontSize: 15,fontWeight: FontWeight.w600)),
              Text("Fun",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
              Container(
                width: 70,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green
                ),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustomLinearProgressbar(value: double.parse(widget.value.toString()),color: widget.color,),
                ),
              )
            ],
          ),
          SizedBox(height: 14,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(widget.cityModel)));
            },
            child: Container(
              height: 22,width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red
              ),
              child: Center(child: Text("Tap to open",style: TextStyle(color: Colors.white,fontSize: 13),)),
            ),
          )
        ],
      ),
    );
  }
}



//
// class DetailPage extends StatefulWidget {
//   CityModel citymodel;
//    DetailPage({Key? key,required this.citymodel}) : super(key: key);
//
//   @override
//   _DetailPageState createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin{
//   int currentindex = 0;
//   late TabController _controller ;
//   TabBar get _tabBar => TabBar(
//     controller: _controller,
//     physics: AlwaysScrollableScrollPhysics(),
//     padding: EdgeInsets.zero,
//     indicatorColor: Colors.red,
//     indicatorPadding: EdgeInsets.zero,
//     unselectedLabelColor: Colors.grey,
//     labelColor: Colors.red,
//     //   labelPadding:  EdgeInsets.zero,
//     unselectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500) ,
//     labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
//     isScrollable: true,
//     onTap: (index) {
//       // print(index);
//       // currentindex = index;
//       setState(() {});
//     },
//     // indicator: UnderlineTabIndicator(
//     //   borderSide: BorderSide(width: 3.0, color: Mycolor.yellow),
//     //   insets: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//     // ),
//     //indicatorSize: TabBarIndicatorSize.label,
//     tabs: [
//       Container(
//          // width:50,
//           height: 55,
//           alignment: Alignment.topLeft,
//           child: Center(child: Text("Scores",style: TextStyle(color: currentindex == 0? Colors.black: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),))),
//       Container(
//         //  width:80,
//           height: 55,
//           alignment: Alignment.topLeft,
//           child: Center(child: Text("Digital Nomad Guide",style: TextStyle(color:currentindex == 1?  Colors.black: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),))),
//       Container(
//         //  width:60,
//           height: 55,
//           alignment: Alignment.topLeft,
//           child: Center(child: Text("People",style: TextStyle(color:currentindex == 2?  Colors.black: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),))),
//       Container(
//           width:90,
//           height: 55,
//           alignment: Alignment.topLeft,
//           child: Center(child: Text("Transactions",style: TextStyle(color:currentindex == 3? Colors.black: Colors.black,fontSize: 15 ,fontWeight: FontWeight.w500),)))
//     ],
//   );
//
//   void _handleTabController(){
//     setState(() {
//       currentindex = _controller.index;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = TabController(length: 4, vsync: this,initialIndex: 0);
//     _controller.addListener(_handleTabController);
//     _controller.animateTo(0);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//        ),
//         child: Stack(
//           children: [
//             Container(
//               height: 230,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/canada.jpg"),
//                   fit: BoxFit.cover
//                 ),
//
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 40),
//                     GestureDetector(
//                         onTap: (){
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                             alignment: Alignment.topLeft,
//                             child: Icon(Icons.clear,color: Colors.white,size: 40,))),
//                     SizedBox(height: 10,),
//                     Container(
//                       alignment: Alignment.topLeft,
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Text("${widget.citymodel.city}",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),),
//                     ),
//                 SizedBox(height: 30,),
//                 Container(
//                   height: 35,
//                   child: ElevatedButton(
//                     child: Text('Work remotely from Gran Canaria',style: TextStyle(color: Colors.white),),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.red,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         textStyle: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//                     SizedBox(height: 40,),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 240),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15) ),
//                 color: Colors.white
//               ),
//               child: Column(
//                 children: [
//                   PreferredSize(
//                     preferredSize: _tabBar.preferredSize,
//                     child: ColoredBox(
//                         color: Colors.white,
//                         child: _tabBar
//                     ),
//                   ),
//                   Container(
//                     height: 450,
//                     child: TabBarView(
//                       physics: AlwaysScrollableScrollPhysics(),
//                       controller: _controller,
//                       children: [
//                        Container(
//                          height: 300,
//                          child: ListView(
//
//                            children: [
//                              Container(
//                                height: 120,
//                                width: double.infinity,
//                                decoration: BoxDecoration(
//                                  image: DecorationImage(
//                                    image: AssetImage("assets/images/HILmr.png"),
//                                    fit: BoxFit.cover
//                                  ),
//
//                                ),
//                              ),
//                              SizedBox(height: 20,),
//                              Cuatomcard(Icons.star, "Total score", "0.9", "4.62/5(Rank #2)"),
//                              SizedBox(height: 20,),
//                              Cuatomcard(Icons.thumb_up_alt, "Quality of life score", "0.7", "Good"),
//                              SizedBox(height: 20,),
//                              Cuatomcard(Icons.face, "Family score", "0.9", "4.62/5(Rank #2)"),
//                              SizedBox(height: 20,),
//                              Cuatomcard(Icons.money, "Cost", "0.9", "4.62/5(Rank #2)"),
//                              SizedBox(height: 20,),
//                              Cuatomcard(Icons.wifi, "Total score", "0.9", "4.62/5(Rank #2)"),
//                            //  Cuatomcard(Icons.star, "Total score", "0.9", "4.62/5(Rank #2)")
//                            ],
//                          ) ,
//                        ),
//                         Container(),
//                         Container(),
//                         Container()
//                       ],
//
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Widget Cuatomcard(IconData icon, String title, String value, String valuetitle){
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child:    Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Icon(icon,color: Colors.yellow,size: 30,),
//          // Text(icon,style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.w600)),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             width: 180,
//               alignment: Alignment.topLeft,
//               child: Text(title,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),)),
//           Container(
//             width: 100,
//             height: 25,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: Colors.green
//             ),
//             child:  ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child:  LinearProgressIndicator(
//               //  valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
//                 value: double.parse(value.toString()),
//                 color: Colors.green,
//                 // minHeight: minHeight,
//                 semanticsLabel: valuetitle,
//                 //   semanticsValue: semanticsValue,
//                 backgroundColor: Colors.green[100],
//               ) ,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
