import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nt118/Screens/signin.dart';
import 'package:nt118/constants.dart';
import 'package:nt118/input/input_decoration.dart';
import 'package:nt118/Screens/signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  registration() async{
    if(password == confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text('Đăng kí thành công, vui lòng đăng nhập lại', style: TextStyle(fontSize: 20,),),
        ),);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
      }on FirebaseAuthException catch (error){
        if(error.code == 'weak-password'){
          print('Mật khẩu quá yếu');
          
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Mật khẩu quá yếu', style: TextStyle(fontSize: 20, color: Colors.amberAccent),),
        ),);

        }else if(error.code == 'email-already-in-use'){
          print('Mail đã được đăng kí');

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Mail đã được đăng kí', style: TextStyle(fontSize: 20, color: Colors.amberAccent),),
        ),);
        }
      }
    }else {
      print('Mật khẩu xác thực chưa đúng');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Mật khẩu xác thực chưa đúng', style: TextStyle(fontSize: 20, color: Colors.amberAccent),),
        ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
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

                    Column(
                      children: <Widget> [
                        Text(
                          'Đăng kí',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lobster',
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    
                    //Email
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autocorrect: false,
                        decoration: buildInputDecoration('Email'),
                        controller: emailController,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Vui lòng điền mail';
                          }
                          else if(!value.contains('@')){
                            return 'Vui lòng điền mail hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),

                    //Password
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: buildInputDecoration('Mật khẩu'),
                        controller: passwordController,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Vui lòng điền password';
                          }
                          return null;
                        },
                      ),
                    ),

                    //Confirm Password
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: buildInputDecoration('Mật khẩu'),
                        controller: confirmPasswordController,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Vui lòng điền lại password';
                          }
                          return null;
                        },
                      ),
                    ),

                    // Container(
                    //   height: 55,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       ElevatedButton(
                    //         onPressed: (){
                    //           if(_formKey.currentState!.validate()){
                    //             setState(() {
                    //               email = emailController.text;
                    //               password = passwordController.text;
                    //               confirmPassword = confirmPasswordController.text;
                    //             });
                    //             registration();
                    //           }
                    //         },
                    //         child: Text(
                    //           'Tiếp tục',
                    //           style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 17,
                    //           fontFamily: 'Lato',
                    //           fontWeight: FontWeight.w400,)
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 55,
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                            confirmPassword = confirmPasswordController.text;
                          });
                          registration();
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Tiếp tục',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}



