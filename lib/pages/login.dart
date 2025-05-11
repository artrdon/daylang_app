import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//import 'dart:io';
//import 'dart:convert';

class Login extends StatefulWidget {
    
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  int type = 0;
  String email = '';
  String password = '';
  int code = 0;
  void submit() {
    /*print(email);
    print(password);
    print(code);*/
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (widget.type == 0) {
      return Scaffold(
        backgroundColor: const Color(0xFF191919),
        body: Center(
          child: Container(
          width: screenWidth * 0.95,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 55, 55, 55),
            borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(//big login header
                width: screenWidth * 0.95,
                height: screenWidth * 0.13333333333333333,
                margin: EdgeInsets.only(bottom: screenWidth * 0.07619047619047619),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 72, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.009523809523809523),
                    topRight: Radius.circular(screenWidth * 0.009523809523809523),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
              Container(//inputs
                margin: EdgeInsets.all(screenWidth * 0.02),
                width: screenWidth * 0.75,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 55, 55),
                  borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(screenWidth * 0.02),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            widget.email = value;
                          });
                        },
                        
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(screenWidth * 0.02),
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(screenWidth * 0.02),
                      child: TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        maxLength: 150,
                        onChanged: (value) {
                          setState(() {
                            widget.password = value;
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(screenWidth * 0.02),
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,

                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenWidth * 0.07619047619047619),
                      width: screenWidth * 0.75,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.submit();
                          setState(() {
                            widget.type = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 72, 255),
                          foregroundColor: Colors.white,
                          minimumSize: Size.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.01),
                        ),
                        child: Text('Login', style: TextStyle(fontSize: screenWidth * 0.040476190),),
                      ),
                    ),
                  ],
                ),
              ),
              Container(//have an account
                margin: EdgeInsets.all(screenWidth * 0.07619047619047619),
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 55, 55),
                  borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                ),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don`t have an account?', style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.040476190),),
                          TextButton(
                          style: TextButton.styleFrom(minimumSize: Size.zero,),
                          onPressed: () {
                            Navigator.pushNamed(context, '/reg');
                          }, child: Text('Register', style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.040476190),)),
                        ],
                      ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Forgot password?', style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.040476190),),
                          TextButton(
                          style: TextButton.styleFrom(minimumSize: Size.zero),
                          onPressed: () {
                            Navigator.pushNamed(context, '/reset_password');
                          }, child: Text('Reset password', style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.040476190,), )),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );}
    else {
      return Scaffold(
        backgroundColor: const Color(0xFF191919),
        body: Center(
          child: Container(
          width: screenWidth * 0.95,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 55, 55, 55),
            borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(//big login header
                width: screenWidth * 0.95,
                height: screenWidth * 0.13333333333333333,
                margin: EdgeInsets.only(bottom: screenWidth * 0.07619047619047619),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 72, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.009523809523809523),
                    topRight: Radius.circular(screenWidth * 0.009523809523809523),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Verify code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
              Container(//inputs
                margin: EdgeInsets.all(screenWidth * 0.02),
                width: screenWidth * 0.75,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 55, 55),
                  borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(screenWidth * 0.02),
                      child: TextField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            widget.code = int.parse(value);
                          });
                        },
                        
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(screenWidth * 0.02),
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Code',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenWidth * 0.07619047619047619),
                      width: screenWidth * 0.75,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.submit();
                          setState(() {
                            if (widget.type == 1) {
                              widget.type = 0;
                            }
                            else {
                              widget.type = 1;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 72, 255),
                          foregroundColor: Colors.white,
                          minimumSize: Size.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.01),
                        ),
                        child: Text('Register', style: TextStyle(fontSize: screenWidth * 0.040476190),),
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
}