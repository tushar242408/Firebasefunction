import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fuctions.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  String id;
  Dashboard(this.id);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var a;
  getdata()async {
    final  documentReference=await FirebaseFirestore.instance.collection("data").doc(widget.id).get();

 a=( documentReference.data())!;
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
  getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(child: IconButton(icon: Icon(Icons.logout)
        ,onPressed: (){
            reg r=new reg();
            r.signout();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),),);

          },),),
      ),
      body:  Container(
            child: a==null?CircularProgressIndicator():ListView.builder(
                itemCount: a['rem'].length,

                itemBuilder: (context,index){
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),    margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10,
                  border: Border.all(width: 2,color: Colors.deepPurple),
                ),
                child: Text("${a['rem'][index]}"),
              );
            }) ,
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          String d='';
          AlertDialog dialog=AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              height:MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/1.5,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2.0, color: Colors.purpleAccent),
              ),
              padding: EdgeInsets.all(10),


              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("ADD TASK",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                            fontSize: 22,
                            letterSpacing: 0,
                            wordSpacing: 0
                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: ' Task'
                        ),
                        onChanged: (val){
                          d=val;
                        },
                      ),
                    ) ,
                    GestureDetector(
                      onTap:(){
                        if(d!='') {
                          var a = FirebaseFirestore.instance.collection("data")
                              .doc(widget.id);
                          a.set({
                            "rem":
                            FieldValue.arrayUnion([d])
                          }, SetOptions(merge: true));
                          getdata();

                        }},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                              color: Colors.blue,
                          
                        ),
                        child: Text("Submit"),
                      ),
                    )

                  ],
                ),
              ),
            ),);
          showDialog(context:context, builder: (BuildContext context) {
            return dialog;
          });
        },
      ),
    );
  }
}
