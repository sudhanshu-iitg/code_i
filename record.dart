import 'package:cloud_firestore/cloud_firestore.dart';



class Record {
 final String name;
 final DocumentReference reference;
 final int accepted;
 final int completed;
 String link;
 String tag1;
 String tag2;
 final String description;
 
 

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     :// assert(map['name'] != null),
       
       name = map['name'],
       accepted = map['accepted'],
       completed = map['completed'],
       description = map['description'],
       link = map['link'],
       tag1 = map['tag1'],
       tag2 = map['tag2'];
                     

       
       
       

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name:$description>";
}

