import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nt118/Screens/forgot_pass.dart';
import 'package:nt118/constants.dart';
import 'package:nt118/input/input_decoration.dart';
import 'package:nt118/Screens/user_main.dart';
import 'package:nt118/Screens/forgot_pass.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({ Key? key }) : super(key: key);

  @override 
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userSignIn() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain()));

      }on FirebaseAuthException catch(error){
        if(error.code == 'user-not-found'){
          print('No user found for that email');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text('No user found for that email', style: TextStyle(fontSize: 18, color: Colors.amber),),
          ),);
        }
        else if(error.code == 'wrong-password'){
          print('wrong password provided by the user');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text('wrong password provided by the user', style: TextStyle(fontSize: 18, color: Colors.amber),),
          ),);
        }
      }
    }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
  // }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          'Đăng nhập',
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

                    //Forget password
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget> [
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPass()));
                            },
                            child: Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: kPrimaryColor,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),

                    MaterialButton(
                      minWidth: double.infinity,
                      height: 55,
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          userSignIn();
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
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

// Widget inputFile({label, obscureText = false})
// {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget> [
//       Text(
//         label,
//         style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//           fontFamily: 'Lato',
//           color: kLightTextColor,
//         ),
//       ),

//       SizedBox(height: 5),

//       TextField(
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(
//             vertical: 0,
//             horizontal: 10,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey.shade400,
//             )
//           ),
//           border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400))
//         ),
//       ),
//       SizedBox(height: 10,)
//     ],
//   );
// }