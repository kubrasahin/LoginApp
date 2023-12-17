import 'package:flutter/material.dart';
import 'package:loginproject/screens/auth/register.dart';
import 'package:loginproject/screens/home.dart';
import 'package:loginproject/services/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final userController = TextEditingController();
  final passwordController = TextEditingController();
  late AnimationController lottieController;
  Services _service = Services();
  @override
  void initState() {
    lottieController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    lottieController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      var result = await _service.userLogin(email, password);
      if (result == 'Success') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        showMessageInScaffold("Kullanıcı Bulunamadı");
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

  void showMessageInScaffold(messagee) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 6.0,
      backgroundColor: Color(0xffef6328),
      behavior: SnackBarBehavior.floating,
      content: Text(
        messagee,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Form(
        child: SingleChildScrollView(
            child: Container(
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 1),
              end: Alignment(-0, 0),
              colors: <Color>[Color(0xff000000), Color.fromARGB(0, 15, 12, 12)],
              stops: <double>[0.151, 0.97],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'giris.png',
              ),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildEmailTextField(),
                buildPasswordTextField(),
                buildLoginButton(),
                InkWell(
                    onTap: () {},
                    child: Text(
                      "Şifremi Unuttum",
                      style: TextStyle(color: Colors.white),
                    )),
                buildRowRegister()
              ],
            ),
          ),
        )),
      )),
    );
  }

  Widget buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        height: 70,
        child: TextFormField(
          style: TextStyle(color: Color(0xff8c8c8c)),
          controller: userController,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Mail adresinizi giriniz";
            } else {
              return emailvalid(value);
            }
          },
          decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              helperText: ' ',
              fillColor: Colors.white,
              filled: true,
              // ignore: prefer_const_constructors
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: Icon(
                  Icons.phone_android,
                  color: Color(0xff8c8c8c),
                ),
              ),
              contentPadding: EdgeInsets.all(5.0),
              hintText: "E-mail",
              hintStyle:
                  const TextStyle(color: Color(0xff8c8c8c), fontSize: 16),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 224, 224, 226))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 224, 224, 226))),
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        height: 75,
        child: TextFormField(
          style: TextStyle(color: Color(0xff8c8c8c)),
          cursorColor: const Color.fromARGB(255, 230, 36, 102),
          onSaved: (String? value) {},
          controller: passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Şifrenizi Giriniz";
            }
            return null;
          },
          obscureText: true,
          decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              helperText: ' ',
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: const Icon(
                  Icons.lock,
                  color: Color(0xff8c8c8c),
                ),
              ),
              contentPadding: EdgeInsets.all(5.0),
              hintText: "Şifre",
              hintStyle: const TextStyle(color: Color(0xff8c8c8c)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 224, 224, 226))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 224, 224, 226))),
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

  Widget buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffef6328),
        ),
        height: 50,
        width: 200,
        child: TextButton(
            onPressed: () async {
              signIn(userController.text, passwordController.text);
            },
            child: Text(
              "Giriş",
              style: TextStyle(color: Colors.white, fontSize: 22),
            )),
      ),
    );
  }

  Widget buildRowRegister() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          child: Text("Kayıt Ol",
              style: TextStyle(color: Colors.white, fontSize: 22))),
    );
  }
}
