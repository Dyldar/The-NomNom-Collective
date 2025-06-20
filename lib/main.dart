import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_nomnom_collective/utilities/firebase_options.dart';
import 'LoginPage.dart';
import 'HomePage.dart';

Future<void> main() async {
  //bütün widgetların doğru çalışıp çalışmadığını kontrol ediyor
  WidgetsFlutterBinding.ensureInitialized();
  //kullandığımız platforma göre firebase kuruyor(ios/android)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//burada logo için fonksiyonu çağırıyoruz
  await initialization(null);
  runApp(MyApp());
}
//uygulama başlarkenki logo
Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 1));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      //uygulmayı kaydırınca çıkan yazı
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //kullanıcı önceden giriş yaptıysa homepage'e değilse loginpage'e atıyor.
      home: FirebaseAuth.instance.currentUser != null ? Homepage() : LoginPage(),
    );
  
  }
}