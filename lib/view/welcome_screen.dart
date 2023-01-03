import 'package:flutter/material.dart';
import 'package:weight_recording/widgets/text_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: TextUtils(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  text: 'Welcome To',
                  color: Colors.grey,
                  underLine: TextDecoration.none,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextUtils(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    text: "Weight",
                    color: Colors.blue,
                    underLine: TextDecoration.none,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  TextUtils(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    text: "Tracker",
                    color: Colors.grey,
                    underLine: TextDecoration.none,
                  ),
                ],
              ),
              const SizedBox(
                height: 250,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    )),
                onPressed: () async{
                  UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                },
                child:Text('Login'),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}