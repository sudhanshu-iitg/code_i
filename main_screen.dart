import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart' as maine ;
import 'feed.dart'as feed;
import 'stat.dart'as stat;
import 'challenges.dart'as challenges;


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
       // primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget
 {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/*class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        fixedColor: 
        Color.fromRGBO(355, 100 , 203 , 100),
        //child: new TabBar(
            controller: controller,
            tabs: <Widget>[
            new Tab(icon: new Icon(Icons.arrow_back)),
            new Tab(icon: new Icon(Icons.arrow_back_ios)),
            new Tab(icon: new Icon(Icons.arrow_back)),
          ],
      ),
        ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
         feed.MyApp(),
         challenges.MyApp(),
         stat.Stats(),
          
         
        ],
      ),
      
      
    );
  }
}
Widget stats (){
  return Scaffold(
    body: Text("data"),
  );
}*/
class _MyHomePageState extends State<MyHomePage>{
  
  
  int _currentTabIndex=0;
  /*final FirebaseAuth auth = FirebaseAuth.instance;
  func() async{

    await auth.signOut();
    maine.MyApp();
  }
  Widget button(BuildContext context)
  {
return RaisedButton(
      child: Text("Logout"),
  onPressed: () {

        func();
    
  },
              
);

  }*/

  @override
  Widget build(BuildContext context)
  {
    /*Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => MyApp(),
        ),);*/
    final __kTabPages=<Widget>[
        
        challenges.MyApp(),
        feed.MyApp(),
        stat.Stats(),
         
    ];
      final _kBottomNavBarItems =<BottomNavigationBarItem>[
      
      BottomNavigationBarItem(icon: Icon(Icons.filter_list),title:Text("list"),),
      BottomNavigationBarItem(icon:  Icon(Icons.assignment),title:Text("feed"),),
      BottomNavigationBarItem(icon: Icon(Icons.assessment),title:Text("stats"),),
    ];

  assert(__kTabPages.length == _kBottomNavBarItems.length);
final bottomNavBar=BottomNavigationBar(
    fixedColor:        Colors.black,
      items:_kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type:BottomNavigationBarType.fixed,
      onTap: (int index){
        setState((){
          _currentTabIndex=index;
        });
},
);
print("in ms");
  return Scaffold(
 body:__kTabPages[_currentTabIndex],
    bottomNavigationBar: Theme(
      data: ThemeData(
        canvasColor:Colors.purple[50],
      ),
      child:bottomNavBar ,),
  );
  }
}