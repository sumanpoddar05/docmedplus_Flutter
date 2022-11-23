import 'dart:convert';

import 'package:docmedplus/ModelClass/UserData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}




class _LoginState extends State<Login> {
  UserData? userData;
  TextEditingController email =  TextEditingController();
  TextEditingController password =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
//copy.....................................................
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: 150,
                //     height: 150,
                //     decoration: const BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.transparent,
                //           spreadRadius: 2,
                //           blurRadius: 5,
                //           offset: Offset(0, 3),
                //         ),
                //       ],
                //       color: Colors.transparent,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Image.asset(
                //         'images/doctor.png',
                //       ),
                //     ),
                //   ),
                // ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.cyan.shade700,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        const TextSpan(text: "DOC MED"),
                        WidgetSpan(child: Icon(Icons.add,
                          color: Colors.cyan.shade700,
                          size: 30,
                        ),
                        ),
                      ]
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter valid user id and password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.text,
                        onChanged: (String text) {
                          if (text.length == 10) {
                            FocusScope.of(context).nextFocus();
                          }
                          print('text $text');
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'User Id',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey.shade700,
                                fontSize: 16)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: password,
                        // maxLength: 7,
                        // onChanged: (String text) {
                        //   if (text.length == 7) {
                        //     FocusScope.of(context).unfocus();
                        //   }
                        //   print('text $text');
                        // },
                        style: const TextStyle(l
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.cyan),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.blueGrey.shade700,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                            await login();
                            
                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.cyan.shade700),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



    );

  }






  Future<void>login() async  {
    var loginController= jsonEncode({
      "email": "cbishal6@gmail.com",
      "password": "Bishal@1997",

    });

    print(loginController);
    try{
      var response =  await http.post(Uri.parse("https://docmedplus.in/api/login"),
      body: loginController,
          headers: {"content-type": "application/json"}
      );

      if(response.statusCode==200){
        final body = json.decode(response.body);
        print('-----------------prn-------------------------');
        print(body);
        setState(() {
          userData = UserData.fromJson(body);
        });
        if(userData!.status==1){
        // final SharedPreferences preferences = await SharedPreferences
        //     .getInstance();

        final SharedPreferences pref = await SharedPreferences.getInstance();
        String user = jsonEncode(UserData.fromJson(body));
        pref.setString('UserData', user);
        // await preferences.setString("EMAIL", userData!.user.email );
        // await preferences.setString("user", userData!.user.toString());
        // await preferences.setString("NAME", userData!.user.email );
        // await preferences.setString("USER", userData!.user.email );
        // await preferences.setString("USER", userData!.user.email );
      }
      }
    }catch(e){
      print('faield');
    }
  }
}
