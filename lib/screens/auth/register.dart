import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginproject/view/id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? email, password;

  void singnin() async {
    final form = _formKey.currentState!;
    if (_formKey.currentState!.validate()) {
      form.save();
      Map<String, dynamic> body = {"email": email, "password": password};
      var res = await http.post(Uri.parse(Id + "api/register"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Access-Control-Allow-Headers":
                "Access-Control-Allow-Origin, Accept",
          },
          body: jsonEncode(body));
      var response = json.encode(res.body);
      if (res.statusCode == 200) {
        SharedPreferences token = await SharedPreferences.getInstance();
        token.setString('token', response);
        showMessageInScaffold("Kullanıcı Kayıtı Başarılı");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        showMessageInScaffold("Kullanıcı Kayıtı Sırasında Hata Oluştu");
      }
    }
  }

  emailvalid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(email)) {
      //regex içinde olan değerler olmadığında içeri girip ifadeyi return olarak döndürür.
      return "Geçersiz e-mail adresi";
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0xff030116)),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildEmailTextField(),
                      buildPasswordTextField(),
                      buildRegisterButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Container(
        height: 70,
        child: TextFormField(
          style: TextStyle(color: Color(0xff2b2e83)),
          onSaved: (String? value) {
            email = value;
          },
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "E-mail Adresinizi Giriniz";
            } else {
              return emailvalid(value);
            }
          },
          decoration: InputDecoration(
              helperText: ' ',
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: const Icon(
                  Icons.email,
                  color: Color(0xff2b2e83),
                ),
              ),
              contentPadding: EdgeInsets.all(5.0),
              hintText: "E-mail",
              hintStyle:
                  const TextStyle(color: Color(0xff2b2e83), fontSize: 16),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff2b2e83),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff2b2e83),
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red))),
        ),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: Container(
        height: 70,
        child: TextFormField(
          style: TextStyle(color: Color(0xff2b2e83)),
          onSaved: (String? value) {
            password = value;
          },
          keyboardType: TextInputType.text,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Şifre Giriniz";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              helperText: ' ',
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: const Icon(
                  Icons.lock,
                  color: Color(0xff2b2e83),
                ),
              ),
              contentPadding: EdgeInsets.all(5.0),
              hintText: "Şifre",
              hintStyle:
                  const TextStyle(color: Color(0xff2b2e83), fontSize: 16),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff2b2e83),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff2b2e83),
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red))),
        ),
      ),
    );
  }

  Widget buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: Color(0xff2b2e83),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextButton(
            style: const ButtonStyle(),
            onPressed: () async {
              singnin();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Kayıt Ol",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMessageInScaffold(messagee) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 6.0,
      backgroundColor: Color(0xffef6328),
      behavior: SnackBarBehavior.floating,
      content: Text(
        messagee,
        style: TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
          label: "Kapat",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }),
    ));
  }
}
