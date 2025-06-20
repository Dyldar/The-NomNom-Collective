import 'package:flutter/material.dart';
// to sign out from the account
import 'package:the_nomnom_collective/utilities/googleSignIn.dart';
//after logging out, switch to login page
import 'LoginPage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  Widget _customContainer(
      //we will display a row with an icon and a text label
      BuildContext context, String textForYes, IconData? leadingIcon) {
    return Padding(
      //adds padding from the all sides
      padding: EdgeInsets.all(2.0),
      child: SizedBox(
        width: 360,
        height: 50,
        child: ListTile(
          // icon on the left
        titleAlignment: ListTileTitleAlignment.center,
        leading: Icon(leadingIcon, size: 40),
        //text on te right
        title: Text(textForYes,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 232, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 70,
                  //profile photo
                  backgroundImage: AssetImage('lib/Images/Snack1.jpg'),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Mahmut Enişte',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    Text('Patient')
                  ],
                )),
              ],
            ),
          ),
          //Expanded uses the available space
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _customContainer(context, "My Dietitian: Dr. Elif Abasıyanık",
                  Icons.psychology_alt),
              _customContainer(
                  context, "My Conditions: Type 2 Diabetes", Icons.no_meals),
              //add the line in between
              Divider(
                  height: 13,
                  thickness: 2,
                  indent: 35,
                  endIndent: 35,
                  color: Colors.amber.shade600),
              _customContainer(context, "Account Settings", Icons.settings)
            ],
          )),
          Expanded(
              child: Column(
                //it doesn't show at the right side because of the padding
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 50.0,
                width: 360.0,
                child: ListTile(
                  key: Key('LogOut'),
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Icon(Icons.logout, size: 40),
                  title: Text("Log out",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onTap: () async {
                    //when the tile is tapped, both main and sign out with google will work
                    await signOutWithGoogle();
                    //sends us to the login page
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
              SizedBox(height: 10),
              _customContainer(
                  context, "Notification Settings", Icons.notifications),
              SizedBox(height: 10),
              _customContainer(context, "About", Icons.info)
            ],
          ))
        ],
      ),
    );
  }
}
