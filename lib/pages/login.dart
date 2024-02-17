import 'package:ecomerceprojecr/pages/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  final TextEditingController _editingController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late SharedPreferences preferences;
  late bool loading = false;
  bool isLogedIn = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  ////USED THE METHOD LOGIN
  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLogedIn = await googleSignIn.isSignedIn();
    if (isLogedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => emcomerce()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignUp() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);
    User? user = (await firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseAuth != null) {
      // final QuerySnapshot result = FirebaseFirestore.instance
      //     .collection('users')
      //     .where('id', isEqualTo: user.uid)
      //     .get() ;
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user?.uid)
          .get();
      List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        //insert user to collection
        FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
          "id": user!.uid,
          "username": user.displayName,
          "photourl": user.photoURL
        });
        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName!);
        await preferences.setString("photourl", user.photoURL!);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photourl", documents[0]['photourl']);
        // await preferences.setString("id", documents[0].data()['id']);
        // await preferences.setString("username", documents[0].data()['username']);
        // await preferences.setString("photourl", documents[0].data()['photoUrl']);
      }
      Fluttertoast.showToast(msg: "Login Was successful");
      setState(() {
        loading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => emcomerce()));
    } else {
      Fluttertoast.showToast(msg: "Login Failed");
      setState(() {
        loading = false;
      });
    }
    return User;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/happy girl.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/logo.png',
              width: 150.0,
              height: 150.0,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                                controller: _editingController,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.alternate_email),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    String pattern =
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                    RegExp regExp = RegExp(pattern);
                                    if (!regExp.hasMatch(value)) {
                                      return 'Please make sure your email is valid';
                                    } else {
                                      return null;
                                    }
                                  }
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The password field cannot  be empty";
                                } else if (value.length < 6) {
                                  return "the password has to be at least 6 character long";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0),
                      child: Text('Forgot password',textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                      Padding(padding: EdgeInsets.all(8.0),
                        child:InkWell(
                            onTap: ()
                            {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                            },
                            child: const Text("Sign up",style:
                            TextStyle(color: Colors.red ,fontWeight: FontWeight.bold,fontSize: 20),)),
                      )
  ]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
