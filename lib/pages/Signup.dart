import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../db/users.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email;
  var username;
  var password;
  FirebaseAuth auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String gender = "";
  bool loading = false;
  String groupValue = 'male';
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
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
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Center(
            child: Form(
              key: formkey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextFormField(
                        controller: _nameTextController,
                        decoration: const InputDecoration(
                          hintText: "Full Name",
                          border: InputBorder.none,
                          icon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The name field cannot  be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                  padding: const EdgeInsets.fromLTRB(14, 8.0, 14.0, 8.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.4),
                    child: Row(children: [
                      Expanded(
                        child: ListTile(
                            title: const Text(
                              "Male",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Radio(
                                value: "male",
                                groupValue: groupValue,
                                onChanged: (e) => valueChanged(
                                      male: e,
                                    ))),
                      ),
                      Expanded(
                        child: ListTile(
                            title: const Text(
                              "female",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Radio(
                                value: "female",
                                groupValue: groupValue,
                                onChanged: (e) => valueChanged(
                                      female: e,
                                    ))),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          controller: _passwordController,
                          obscureText: hidePass,
                          decoration: const InputDecoration(
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The password field cannot  be empty";
                            } else if (value.length < 6) {
                              return "the password has to be at least 6 character long";
                            }
                            return null;
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              hidePass = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: hidePass,
                          decoration: const InputDecoration(
                              hintText: "Confirm Password",
                              icon: Icon(Icons.lock_outline),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The password field cannot  be empty";
                            } else if (value.length < 6) {
                              return "the password has to be at least 6 character long";
                            } else if (_passwordController.text != value) {
                              return "the password not match";
                            }
                            return null;
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              hidePass = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red.shade700,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () {
                          validateForm();
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        )
      ]),
    );
  }

  valueChanged({male, female}) {
    if (male == 'male') {
      groupValue = male;
      setState(() {
        gender = male;
        print(gender);
      });
    } else if (female == "female") {
      groupValue = female;
      setState(() {
        gender = female;
        print(gender);
      });
    }
  }

  Future<void> validateForm() async {
    if (formkey.currentState!.validate()) {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        firebaseAuth.createUserWithEmailAndPassword(
            email: _editingController.text, password: _passwordController.text);
        _userServices.createUser({
          "username": _nameTextController.text,
          "email": _editingController.text,
          "userId": user.uid,
          "gender": gender,
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const emcomerce()));
      }
    }
  }
}
