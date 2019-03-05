import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_letter/rounded_letter.dart';
import'profile.dart'as pofile;

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
            child: Text('feed.',
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
class LevelA extends StatefulWidget {
//LevelA({Key key, this.user}) : super(key: key);

//String user;


 @override
 _LevelAState createState() {
   return _LevelAState();
 }
}

 _LevelAState createState() {
   return _LevelAState();
 }


class _LevelAState extends State<LevelA>  {
  
@override
 Widget build(BuildContext context) {
   return Scaffold(
    
     
      body:// Column(
       //children:[
         // myfeed,
         
         Flex(direction: Axis.vertical 
           ,children:[
             myfeed,
          Expanded(child:
            _buildBody(context)
            ),])
       // ],
     // )
    );
  }
  profile(String name){
    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pofile.user(name),),);


  }



 

 @override
 Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance.collection('feed').orderBy("timestamp",descending: true).limit(10).snapshots(),  
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

  var now = new DateTime.now();
   
   return Container(
      child:Card(
        elevation: 5,
       child: Column(
          children: [
            ListTile(
              onTap: profile(record.username),
              title: Text(record.username,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                  subtitle: Text(record.challengename),
                  leading: RoundedLetter(text:record.username[0]),
                  trailing:Text(((now.difference(record.timestamp)).inHours.toString()+"  hours ago"),style:TextStyle(color:Colors.grey[500]))
            ),
            Divider(),
          ],  ),
      ) ,);
 }}
 class Record {
 final String username;
 final String challengename;
  final DateTime timestamp;
 final DocumentReference reference;
 
 

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     ://ssert(map['name'] != null),
       
       username = map['username'],
       challengename = map['challengename'],
       timestamp=map['timestamp'];
       
       
       

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 //@override
 //String toString() => "Record<$name>";
}
