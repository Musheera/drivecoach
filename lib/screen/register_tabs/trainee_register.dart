import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';



class TraineeRegister extends StatefulWidget {
  @override
  _TraineeRegisterState createState() => _TraineeRegisterState();
}

class _TraineeRegisterState extends State<TraineeRegister> {
  FirebaseAuthenticationController authentiable = FirebaseAuthenticationController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String selectedGender = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 13),
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                scale: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 48,
                right: 48,
              ),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Phone",
              ),
            ),
            GenderSelector(
              margin: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10,),
              selectedGender: Gender.FEMALE,
              onChanged: (gender) async {

                setState(() {
                  if(gender == Gender.FEMALE) {
                    selectedGender = "female";
                  } else {
                    selectedGender = "male";
                  }
                });

              },

            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.purple,
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16, letterSpacing: 1),
                    ),
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      //var user = await authentiable.register(email, password);
                      print(email);
                      print(password);
                      var user = await authentiable.register(email, password);
                      print(user);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
