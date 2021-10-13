import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nt118/Screens/signin.dart';
import 'package:nt118/Screens/signup.dart';
import 'package:nt118/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp>_initialization = Firebase.initializeApp();
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          print('Something went wrong');
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
          
          ),
          home: WelcomePage(),
        );
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/iconLogo.png'),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 11.0,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
              ),

              // main text
              Text(
                'ehaba',
                style: TextStyle(
                  // shadows: <Shadow> [
                  //   Shadow(
                  //     offset: Offset(1.0, 1.0),
                  //     blurRadius: 1.0,
                  //     color: Colors.grey.shade400,
                  //   ),
                  // ],
                  fontSize: 56.0,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              Text(
                'Ế hả bạn? Vào đây cái là hết ế!',
                style: TextStyle(
                  color: kLightTextColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 25),

              Column(
                children: <Widget>[
                  // the sign in button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 55,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: kPrimaryColor
                      ),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  //the sign up button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 55,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'Đăng kí',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Text(
                'Chính sách và quyền riêng tư',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
