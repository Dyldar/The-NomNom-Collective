import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'utilities/googleSignIn.dart';
import 'utilities/auth_login.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void goToHomePage() {
      //if succesful it will navigate to the homepage
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //uzun kenarı düzenler
          mainAxisAlignment: MainAxisAlignment.center,
          //kısa kenarı düzenler
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              //text direction left to right
              //because we are writing
              textDirection: TextDirection.ltr,
              key: Key('Email'),
              //we didn't create a controller for this reason
              //email yazısı biz emailimizi yazdığımızda silinecek,sadece gösterge için
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              textDirection: TextDirection.ltr,
              key: Key('Password'),
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              //masks the text for password security
              //şifrenin nokta nokta görünmesi için
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              key: Key('LoginButton'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber.shade800)
              ),
              onPressed: () async {
                final message = await AuthLogin().login(
                  email: emailController.text, 
                  password: passwordController.text);
                //bu fonksiyon bana null da döndürebilir o yüzden ünlem var.
                //ünlem sonundaysa null gelme ihtimaline karşı önlem alıyor
                //utilities den bakabilirsin
                if (message!.contains('Success')) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Homepage())
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message))
                  );
                }
              },
              child: Text('Login',
                style: TextStyle(
                  color: Colors.white
                ),),
            ),
            SizedBox(height: 16, 
              child: Text("or",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13))),
            ElevatedButton(
              key: Key('GoogleLoginButton'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(244, 244, 232, 1))
              ),
                onPressed: () async {
                  await signInWithGoogle();
                  goToHomePage();
                },
                child: const Text('Sign in with Google'))
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(244, 244, 232, 1),
    );
  }
}
