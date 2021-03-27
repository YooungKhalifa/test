import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kurdishgrammer/about.dart';
import 'package:kurdishgrammer/addWord.dart';
import 'package:kurdishgrammer/homepage.dart';
import 'package:firebase_admob/firebase_admob.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _Home();
  }
}
class _Home extends State<Home>{
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
  home: MyBottomNavigate(),
   );
  }
}

class MyBottomNavigate extends StatefulWidget{
  @override
  _MyBottomNavigateState createState() => _MyBottomNavigateState();
}
class _MyBottomNavigateState extends State<MyBottomNavigate>{
  int _currentIndex=0;
  @override
  final List<Widget> _children=[
    Dict(),
    About(),
  ];
  void onTappedBar(int index){
    setState(() {
      _currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
       floatingActionButton: FloatingActionButton(
         onPressed: () {
           myBanner..load()
             ..show(anchorOffset: 60.0,
               // Positions the banner ad 10 pixels from the center of the screen to the right
               horizontalCenterOffset: 10.0,
               // Banner Position
               anchorType: AnchorType.bottom,);
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => Addword()),
           );

         },
         child: Icon(Icons.add,color: Colors.black,),
         backgroundColor: Colors.white,

       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       bottomNavigationBar: BottomAppBar(
           shape: CircularNotchedRectangle(),
           notchMargin: 6,
           clipBehavior: Clip.antiAlias,
         child:  BottomNavigationBar(
         onTap:onTappedBar,
          selectedFontSize: 15,
          currentIndex:_currentIndex,
          backgroundColor: Colors.black87,
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.white,),
              title: Text('سەرەکی',style: TextStyle(color: Colors.amber),),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline,color: Colors.white,),
              title: Text('دەربارەی ئێمە',style: TextStyle(color: Colors.amber),),
              backgroundColor: Colors.blue,
            ),
          ],
         ))
    );
  }

}
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['games', 'apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.unknown, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId:BannerAd.testAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
