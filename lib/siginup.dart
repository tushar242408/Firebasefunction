
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'datashow.dart';
import 'fuctions.dart';
import 'login.dart';


class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  reg r=new reg();
  bool check=false;

  late String _name,_password;
  Widget form({required String text,required var onchaged}){
    return    TextFormField(
      decoration: InputDecoration(
          labelText: text
      ),
      onChanged: onchaged,
    );
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width/100;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(height: w*4,),
              Column(
                children: [
                  SizedBox(height: w*4,),
                  Textshow(text:"Sign Up",FontSize: w*5,),
                  form(text:"Enter user name",onchaged:((value){
                    _name = value;
                  })),
                  form(text:"Password",onchaged:(value){
                    _password = value;
                  }),
                  SizedBox(height: w*15,),
                  button(text:check?"Please wait...":"LOGIN",width: w*90,height:w*10,txtcolor: Colors.white,ontap:()async{
                    check=true;
                    setState(() {});
                    var  c=await r.singup(_name,_password);
                     if (c!=null)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(c),),);
                     else{check=false;
                     setState(() {});
                     AlertDialog dialog=AlertDialog(
                       content: new Text("wrong input re input again"),
                     );
                     showDialog(context:context, builder: (BuildContext context) {
                       return dialog;
                     });
                     }
                  },),
                  SizedBox(height: w*5,),

                  SizedBox(height: w*8,),  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap:()async{
                            check=true;
                            setState(() {

                            });
                            var a=await r.googlr();
                            if(a!=null)
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(a),),);

                          },
                          child: Image.network( "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/368px-Google_2015_logo.svg.png",height: w*10,width: w*30,)),
                   ],
                  ), SizedBox(height: w*12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textshow(text: " have an account?",color: Colors.grey,FontSize: w*3),
                      Textshow(text: "Login",color: Colors.black,FontSize: w*4,ontap:(){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Login(),
                          ),
                        );
                      },),
                    ],
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
