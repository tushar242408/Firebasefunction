import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class reg{
  late String email, password;
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future googlr() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
          .authentication;


      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      var result = await auth.signInWithCredential(credential);
      print(result.user);
      final DocumentReference documentReference= FirebaseFirestore.instance.collection("data").doc(result.user!.uid);
      var b=await FirebaseFirestore.instance.collection("data").doc(result.user!.uid).get();
      var a= ( b.data())!;
  if(a==null){
    Map<String, dynamic> l={
      "rem":[],
    };

    await documentReference.set(l).whenComplete(() => print("done"));
  }
      return result.user!.uid;
    }
  }

  Future singIn(String email, String pass) async {
    try {
      var result =await auth.signInWithEmailAndPassword(email: email, password: pass);
      return result.user!.uid;

    } catch (err) {
      print(err);
    }

  }

  signout() async {
    var user = await auth.signOut();


  }


  Future singup(String email, String pass) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print(result.user);
      Map<String, dynamic> l={
        "rem":[],
      };



      final DocumentReference documentReference= FirebaseFirestore.instance.collection("data").doc(result.user!.uid);
      await documentReference.set(l).whenComplete(() => print("done"));
      return result.user!.uid;
    } catch (err) {
      print(err);
    }
  }
}