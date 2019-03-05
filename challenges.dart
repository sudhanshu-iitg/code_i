// assuming user ka name is Uname
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'stat.dart' as my_stats;
import 'details.dart'as details;
import 'record.dart';



void main() => runApp(MyApp());





class MyApp extends StatelessWidget {
 
 
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'challenge list',
     home: LevelA(),
   );
 }
}




class LevelA extends StatefulWidget {
//LevelA({Key key, this.user}) : super(key: key);

//String user;


 @override
 _LevelAState createState() {
   return _LevelAState();
 }
}

class _LevelAState extends State<LevelA> with SingleTickerProviderStateMixin {



  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
Widget myfeed = Container(
  child:Column(
    children:[
      Stack(
        children: <Widget>[
          Container(
            height: 160.0,
            width: double.infinity,
            color:Colors.grey[500],
          ),
          Positioned(
            top: 30.0,
           left: 10.0,
            child: Text('my',
              style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize:50.0,
                fontFamily: 'Segoe UI',
                color:Colors.black,
              ),
            ),
          ),
          Positioned(
            top:50.0,
            left: 100.0,
            child: Container(
              height: 180.0,
              width: 180.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300.0),
                  color: Colors.white10,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 200.0,
            child: Container(
              height:250.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300.0),
                color: Colors.white10
              ),
            ),  
          ),
          Positioned(
            top: 65.0,
            left: 5.0,
            child: Text('list.',
              style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize:90.0,
                fontFamily: 'Rockwell',
                color:Colors.purple[300],
              ),
            ),
          ),  
        ],
      ),
    ],
  ),
);




 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Flex(
       direction: Axis.vertical,
       children: <Widget>[
          myfeed,
          Expanded(
            child: buildy(context),
          )
       ],
     ),
   );

 }
 Widget buildy(BuildContext context) {
   return Scaffold(
     appBar:// AppBar(
      
     //  bottom: 
       TabBar(
         labelColor: Colors.purple[500],
         unselectedLabelColor: Colors.black12,
         indicatorColor: Colors.purple[500],
         controller: controller,
         tabs: <Widget>[
           Tab(icon: Icon(Icons.filter_1)),
           Tab(icon: Icon(Icons.filter_2)),
           Tab(icon: Icon(Icons.filter_3)),
           Tab(icon: Icon(Icons.filter_4)),
           Tab(icon: Icon(Icons.filter_5)),
         ],
       ),
     body: new TabBarView(
        controller: controller,
        children: <Widget>[
        _buildBody(context,"a"),
        _buildBody(context,"b"),
        _buildBody(context,"c"),
        _buildBody(context,"d"),
        _buildBody(context,"e"), 
        ],
      ),
     
   );
 }

 Widget _buildBody(BuildContext context,String level) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance.collection('challenges').where('level', isEqualTo: level).snapshots(),  
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();

     return _buildList(context, snapshot.data.documents);
   },
 );
}

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
   final record = Record.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.name),
        
         onTap: () {
          // details.getStatus(record.name);
         
Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => details.DetailScreen(todo: record),),);
                 

}

       ),
     ),
   );
 }
}
class UserCh{
 final String name;
final String status;
 
 final DocumentReference reference;

 UserCh.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),assert(map['status'] != null),
       
       name = map['name'],status = map['status'];
       

 UserCh.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 
}

