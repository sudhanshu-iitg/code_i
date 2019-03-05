// assuming username as Uname
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'challenges.dart' as challenges;
import 'record.dart';

String cstatus='';
String le(String lev)
{
if(lev==null)
return "";
else return "Level  "+lev.toUpperCase();


}

void getStatus(String cname) async {
  DocumentSnapshot snapshot= await Firestore.instance.collection("User").document(uname).collection("Challenges").document(cname).get();
  cstatus = snapshot['status'].toString(); 
  
}


class Stats extends StatefulWidget {
    
 @override
 _StatsState createState() {
   return _StatsState();
 }
}
Widget mystats = Container(
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
              height: 250.0,
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
            child: Text('stats.',
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


class _StatsState extends State<Stats> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
   
     body:Flex(
       direction: Axis.vertical,
       children:[
         mystats,
        Expanded(child:  _buildBody(context),)
       ]
     ) 
    
   );
 }

 Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream:Firestore.instance.collection('User').document(uname).collection("Challenges").where('status', isLessThan: "n").snapshots(),  
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

   return Column (children :[
   Padding(
     key: ValueKey(record.name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),  
      child: ListTile(
        title: Text(record.name,
          style: TextStyle(fontWeight: FontWeight.w500)),
        trailing:Text(record.status),
        subtitle: Text(le(record.level)),
        
    //title: Text(record.name,style: TextStyle(color: Colors.grey),),
      ),
        
 
     ),
     Divider()])
    ;
 }
 }
class Record {
 final String name;
final String status;
final String level;
 
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),assert(map['status'] != null),
       
       name = map['name'],status = map['status'],level=map['level'];
       

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name:$status>";
}

