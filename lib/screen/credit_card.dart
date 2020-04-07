import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:drivecoach/authentication/firebase_auth.dart';
import 'package:drivecoach/screen/view_training_list.dart';
import 'package:drivecoach/screen/view_training_list_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:progress_dialog/progress_dialog.dart';

//void main() => runApp(CreditCardPay(getTrainings()));

class CreditCardPay extends StatefulWidget {
  String training;
 CreditCardPay(this.training);

  @override
  State<StatefulWidget> createState() {
    return CreditCardPayState();
  }
}

class CreditCardPayState extends State<CreditCardPay> {
  ProgressDialog pr;

  FirebaseAuthenticationController authentiable = FirebaseAuthenticationController();

  //String userId =
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  static String userId;

  Future<FirebaseUser> user =
  FirebaseAuth.instance.currentUser().then((onValue) {
    userId = onValue.uid;
    return onValue;
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              RaisedButton(

                color: Colors.purple,
                child: Text(
                  "JOIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1),
                ),
                onPressed: () async {

                  payTraining();

                  //validateForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {

      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;

    });
  }

  void payTraining() {

    Firestore.instance.collection('payment').document()
        .setData({
      'card_no': cardNumber,
      'expire_date': expiryDate,
      'card_holder_name': cardHolderName,
      'cvv_code': cvvCode,
      'cvv_focused': 'true',
      'trainee_id': userId,
      'training_id' : widget.training
    }).then((onValue){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("You have paid successfuly! "),
      ));
      pr.hide().then((isHidden) {
        print(isHidden);
      });
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewTrainingListUsers()));
    });


  }



}