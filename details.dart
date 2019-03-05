import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'record.dart';
import 'package:url_launcher/url_launcher.dart';
String status="";

 void getStatus(String ch) async {
  
 DocumentSnapshot snapshot= await Firestore.instance.collection('User').document(uname).collection("Challenges").document(ch).get();
 status= snapshot['status'].toString();

      }

class DetailScreen extends StatefulWidget{
  
 
Record todo;
DetailScreen({Key key, @required this.todo}) : super(key: key);
   
@override
_MyDetails createState() =>_MyDetails(todo: todo);
}
class _MyDetails extends State<DetailScreen>{
  _MyDetails({ @required this.todo}) : super();

  Record todo;
 Widget build(BuildContext context) {
    //status='';
    String tim="";
    Future.delayed(const Duration(milliseconds: 5), () {

    setState(() {
    
    tim=status;

  });
});

String textfunc(){
  getStatus(todo.name);
  if(status=="null")
  return "accept";
  if (status=="accepted")
  return "complete";
  else if (status=="completed")
  return "already completed";
  else return "Getting status...";
}

     func(){
	setState((){

 if(status=="accepted")
{
complete(todo.name, context);
}
else if (status=="completed")
Null;
else accept(todo.name, context);


});
 }

  int acce = todo.accepted;
    int comp = todo.completed;
    double c_width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: Container(
        //padding: const EdgeInsets.fromLTRB(0, 0, 3.0, 5.0),
        child:ListView(
          children: <Widget>[
            Stack(
              
              children: <Widget>[
                Container(
                  height: 170.0,
                 width: c_width,
                  color:Colors.grey[500],
                ),
                Positioned(
                  top:45.0,
                  left:10.0,
                  width: c_width ,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text(todo.name,
                      style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize:47.0,
                        fontFamily: 'Segoe UI',
                        color:Colors.black,
                      ),
                      ),
                    ],  
                  ),
                )
              ],
            ),
            SizedBox(height: 5.0,),
            ListTile(
              title: Text('Description',
              style:TextStyle(
                fontWeight: FontWeight.w500,
                fontSize:25.0,
                fontFamily: 'Comfortaa',
                color:Colors.grey,
              ),
              ),
            ),
            
            Divider(),
            SizedBox(height: 10.0),
            SizedBox(width: 9.0),
            Padding(
              padding: EdgeInsets.all(8),
              child:Text(todo.description,
            style:TextStyle(
              fontWeight: FontWeight.w200,
              fontSize:19.0,
              fontFamily: 'Segoe UI',
              color:Colors.black,
            ),
            ),),
              
            SizedBox(height: 20.0),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.purple,
              onPressed: () {launch(todo.link);},
              child: Text(
                'View more',
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white),
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.purple,
              onPressed: () =>func(),
              child: Text(
                textfunc(),
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white),
              ),
            ),FlatButton(
              
              shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.purple,
              onPressed: () =>reset(todo.name),
              child: Text(
                "reset",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white),
              ),
            ),
            
            SizedBox(height: 15.0),
            Divider(),
            SizedBox(height: 10.0),
            ListTile(
              title:Text('Categories',
              style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize:25.0,
                fontFamily: 'Comfortaa',
                color:Colors.grey,
              ),
              ),
            ),
            SizedBox(height: 0.0),
            Divider(),
            SizedBox(height: 7.0),
            Row(
              children: <Widget>[
                SizedBox(width: 25.0),
                tag1(),
                 SizedBox(width: 13.0),
                tag2(),
              ],),

               
            SizedBox(height: 5.0),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title:Text('Challenge accepted ',
                  style:TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize:19.0,
                    fontFamily: 'Comfortaa',
                    color:Colors.grey,
                  ),
                  ),
                  trailing: 
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.purple,
                    onPressed: () {},
                    child: Text(
                      '$acce',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 10.0),
                ListTile(
                  title:Text('Challenge done ',
                  style:TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize:19.0,
                    fontFamily: 'Comfortaa',
                    color:Colors.grey,
                  ),
                  ),
                  trailing: 
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.purple,
                    onPressed: () {},
                    child: Text(
                      '$comp',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),  
    ) ;

    } 
        
        
reset(cname){Firestore.instance.collection("User").document(uname).collection("Challenges").document(cname).setData(
      {
        "name" : cname ,
	      "status": "null",
      }
    );
     Firestore.instance.collection("feed").document(uname+cname).delete(
      
    );


}
   
    tag1(){
      if(todo.tag1=="null")
      {return Text("coming soon");}
      else return button(todo.tag1);
    }

     tag2(){
      if(todo.tag2=="null")
      return Text("coming soon");
      else return button(todo.tag2);
    }

   Widget button(String text){return FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.purple,
                  onPressed: () {},
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white
                    ),
                  ),
                );}
    
    accept(String cname,BuildContext context)
  {
    print("in accepte");
    Firestore.instance.collection("User").document(uname).collection("Challenges").document(cname).updateData(
      {
        "name" : cname ,
	      "status": "accepted",

      }
    );
    Firestore.instance.collection("challenges").document(cname).updateData(
      {
        "accepted" : todo.accepted + 1 ,
      });
    
  }

 complete(String cname,BuildContext context)
  {
    print("in complete");
    Firestore.instance.collection("User").document(uname).collection("Challenges").document(cname).updateData({
      
        "name" : cname ,"status" : "completed",

      }
    );
    Firestore.instance.collection("challenges").document(cname).updateData(
      {
        "completed" : todo.completed + 1 ,
      });
       Firestore.instance.collection('feed').document(uname+cname).setData({
          
         "username" : uname ,
        "challengename" : cname ,
        "timestamp":FieldValue.serverTimestamp(),
       });
        


    
  }}
 