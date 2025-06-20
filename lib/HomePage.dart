import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'ProfilePage.dart';
import 'FilterPage.dart';
import 'FoodPage.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}
 
class _HomepageState extends State<Homepage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Foodpage(),
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 40.0, vertical: 0.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            SizedBox(height: 7.5),
            ListTile(
              tileColor: Colors.amber.shade800,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
              leading: Icon(Icons.search),
              title: Text(
                'Search For Food',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FoodSearchPage())
              ),
            ),
            SizedBox(height: 7.5),
            _customTileList(
                context, 125, 'Breakfast', 'lib/Images/Breakfast.jpg'),
            _customTileList(context, 75, 'Snack', "lib/Images/Snack1.jpg"),
            _customTileList(context, 125, 'Lunch', "lib/Images/Lunch.jpg"),
            _customTileList(context, 75, 'Snack', "lib/Images/Snack2.jpg"),
            _customTileList(context, 125, 'Dinner', "lib/Images/Dinner.jpg"),
            _customTileList(context, 75, 'Snack', "lib/Images/Snack3.jpg"),
            SizedBox(
              height: 7.5,
            )
          ],
        ),
      ),
      Profilepage()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade800,
        title: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900, // Make the title bold
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      backgroundColor: Color.fromRGBO(244, 244, 232, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Food'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_4), label: 'Profile', key: Key('Profile'))
        ],
        backgroundColor: Colors.amber.shade800,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _customTileList(
      BuildContext context, double height, String text, String pathToImage) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.deepOrange.shade700),
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: AssetImage(pathToImage),
                  fit: BoxFit.cover,
                  opacity: 0.7)
                ),
          height: height,
          child: ListTile(
            title: StrokeText(
              text: text,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18, 
                fontWeight: 
                FontWeight.bold),
              strokeColor: Color.fromRGBO(244, 244, 232, 1),
              strokeWidth: 4,
            ),
            onTap: () => _showDialog(context, text),
            focusColor: Colors.deepOrange.shade700,
          ),
        )
      ],
    );
  }

  _showDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(244, 244, 232, 1),
            scrollable: true,
            title: Text(text),
            content: Text('$text için açılır pencere içeriği'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Kapat'))
            ],
          );
        }
      );
  }
}
