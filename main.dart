import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main_screen.dart' as ms;


String uname  ;
var list=new List(38);
var jist=List(38);

/*void main() {
  print("ins main");
final FirebaseAuth auth = FirebaseAuth.instance;
Widget defaultHome=new MyHomePage(title: 'Flutter Demo Home Page');
//Widget defaultHome= Text
  if (auth.currentUser() != null) {
    print("in  if");
  defaultHome=ns.MyApp();
  }
  runApp(new  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        //primarySwatch: Colors.purple[100],
      ),
      home: defaultHome,
    ) );
      print("..");
  }
*/


void main() {
  
  
  runApp(MyApp());
  

  
  
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
   @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

 final FirebaseAuth auth = FirebaseAuth.instance;
 final GoogleSignIn googleSignIn = GoogleSignIn();
  

 Future<FirebaseUser> signin() async{
   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
   GoogleSignInAuthentication gsa = await googleSignInAccount.authentication;
   FirebaseUser user = await auth.signInWithGoogle(
     idToken: gsa.idToken   ,
     accessToken: gsa.accessToken,
   );
   uname=user.displayName;
   
  doesNameAlreadyExist() ;
  
  Navigator.pop(context);
  Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) {return ms.MyApp();}
        ),);
  
        return user ;
 }
@override
  Widget build(BuildContext context) {
    return Scaffold(
       //key: _scaffoldKey,
       
      
      body: ListView(
       children: <Widget>[
         Container(
          child:Column(
            children:[
              Stack(
                children: <Widget>[
                  
                  Container(
                    height: 510.0,
                    width: double.infinity,
                    color:Colors.white,
                  ),
                  Container(
                    height: 160.0,
                    width: double.infinity,
                    color:Colors.grey[500],
                  ),
                  Positioned(
                    top: 30.0,
                    left: 10.0,
                    child: Text('get',
                      style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize:50.0,
                        fontFamily: 'Segoe UI',
                        color:Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 65.0,
                    left: 5.0,
                    child: Text('started.',
                      style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize:90.0,
                        fontFamily: 'Rockwell',
                        color:Colors.purple[300],
                      ),
                    ),
                  ), 
                 Positioned(
            top: 200.0,
            left: 50.0,
            right: 50.0,
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                height: 270.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.white),),),),
             
         Positioned(
            top: 240.0,
            left: 154.0,
            right: 154.0,
            child: Image.asset('images/q.png',width:65.0, height:75.0,
            //fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 25.0,
            left: 80.0,
            right: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[      
                SizedBox(height: 300.0,),
                Text('Code_i',style:TextStyle(fontWeight: FontWeight.w400,color:Colors.black,fontSize: 20.0)),          
                SizedBox(height: 25.0,),
                Text('Code your journey',style:TextStyle(fontWeight: FontWeight.w300,color: Colors.black)),          
                SizedBox(height: 20.0,),
                
                 FlatButton(
                   
                  child:  Container(
                    alignment: Alignment(0, 0),
                    child:Text("Sign in"),
                    width: 70,),
                  onPressed: ()=>signin(),
                  shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                  color:  Colors.purple[300],
                  
                    ),
                SizedBox(height: 10.0),
              ],
            
          ),
              ),
                ]
                    
               
            
          ),])
        ),


        /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           RaisedButton(
             child : Text("Get Started"),
             onPressed : (){
               signin();}
           ),
          ],
          )*////yeh dekh

                /* ButtonTheme(
            minWidth: 200.0,
            height: 100.0,
            child: RaisedButton(
              onPressed: () {},
              child: Texts.black("test"),
            ),
        );*/


       ],
      ),
       
    );
  }
}
  void doesNameAlreadyExist() async {
      print("in fu");
  final QuerySnapshot result = await Firestore.instance
    .collection('User')
    .where('name', isEqualTo: uname)
    .limit(1)
    .getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  if (documents.length==1)
      {
        print("in if");
         //result.data is the returned bool from doesNameAlreadyExists
        null;

        }
      else
      {
       print("in else");
        func();
     }
}
    
      func() async{

Firestore.instance.collection("User").document(uname).setData(
      {
        "name" : uname
      });
    for(var i=0;i<=37;i++)
    {
      print("loop");
     DocumentSnapshot sss= await Firestore.instance.collection("c_names").document("$i").get();
     list[i]=sss["name"].toString();
     jist[i]=sss["level"].toString();
     
    Firestore.instance.collection("User").document(uname).collection("Challenges").document(list[i]).setData(
      {
        "name" : list[i],
        "status":"null",
        "level":jist[i]
      });}

}


   
  


