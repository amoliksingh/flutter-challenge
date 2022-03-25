import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Edit Profile'),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Edit Profile'),
      //   ),
      //   body: MyAlert(),
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _firstname = "";
  String _lastname = "";
  CountryCode _code = CountryCode();
  String _password = "";
  String _oldpassword = "";
  String _newpassword = "";
  String _confirmpassword = "";
  bool _saved = false;
  bool _change = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (!_saved) {
        if (_password == ""){
          showAlertDialog(context, "Password cannot be empty");
        } else {
          _saved = true;
        }
      }
      if (_change) {
        if (_password != _oldpassword){
          showAlertDialog(context, "Old password is incorrect");
        }
        if (_newpassword != _confirmpassword){
          showAlertDialog(context, "Passwords do not match");
        } else if (_newpassword != ""){
          _password = _newpassword;
          _change = false;
          _newpassword = "";
          _confirmpassword = "";
        } else {
          showAlertDialog(context, "New password cannot be empty");
        }
      }
    });
  }

  showAlertDialog(BuildContext context, String message) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Password Error"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            // https://stackoverflow.com/questions/66323415/flutter-sign-up-page-where-first-and-last-name-are-next-to-each-other
            // I Used the above link to initially create the first name and last name fields
        Container(
          margin: EdgeInsets.only(left: 20.0),
          height: 85,
          child: TextFormField(
            obscureText: false,
            cursorColor: Color(0xFF3E8094),
            decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: TextStyle(
                    color: Color(0xFF3E8094)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3E8094)))),
            onChanged: (input) => _firstname = input,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0),
          height: 85,
          child: TextFormField(
            obscureText: false,
            cursorColor: Color(0xFF3E8094),
            decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: TextStyle(
                    color: Color(0xFF3E8094)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3E8094)))),
            onChanged: (input) => _lastname = input,
          ),
        ),

            CountryListPick(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: Text('Choose a country'),
                ),

                // if you need custome picker use this
                // pickerBuilder: (context, CountryCode countryCode){
                //   return Row(
                //     children: [
                //       Image.asset(
                //         countryCode.flagUri,
                //         package: 'country_list_pick',
                //       ),
                //       Text(countryCode.code),
                //       Text(countryCode.dialCode),
                //     ],
                //   );
                // },

                // To disable option set to false
                theme: CountryTheme(
                  isShowFlag: true,
                  isShowTitle: true,
                  isShowCode: true,
                  isDownIcon: true,
                  showEnglishName: true,
                ),
                // Set default value
                initialSelection: '+62',
                // or
                // initialSelection: 'US'
                onChanged: (code) => {
                  if (code != null) {
                    print(code.name),
                    print(code.code),
                    print(code.dialCode),
                    print(code.flagUri),
                },
                },
                // Whether to allow the widget to set a custom UI overlay
                useUiOverlay: true,
                // Whether the country list should be wrapped in a SafeArea
                useSafeArea: false
            ),

            if (_saved && _change)
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 85,
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Color(0xFF3E8094),
                  decoration: InputDecoration(
                      labelText: "Old Password",
                      labelStyle: TextStyle(
                          color: Color(0xFF3E8094)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3E8094)))),

                  onChanged: (input) => _oldpassword = input,
                ),
              ),
            if (_change)
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 85,
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Color(0xFF3E8094),
                  decoration: InputDecoration(
                      labelText: "New Password",
                      labelStyle: TextStyle(
                          color: Color(0xFF3E8094)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3E8094)))),
                  onChanged: (input) => _newpassword = input,
                ),
              ),
            if (_change)
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 85,
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Color(0xFF3E8094),
                  decoration: InputDecoration(
                      labelText: "Confirm New Password",
                      labelStyle: TextStyle(
                          color: Color(0xFF3E8094)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3E8094)))),
                  onChanged: (input) => _confirmpassword = input,
                ),
              ),
              if (!_saved)
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 85,
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Color(0xFF3E8094),
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Color(0xFF3E8094)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3E8094)))),

                  onChanged: (input) => _password = input,
                ),
              ),
            if (_saved && !_change)
            Container(
              margin: EdgeInsets.all(25),
              height: 85,
              child: FlatButton(
                child: Text('Change Password', style: TextStyle(fontSize: 20.0),),
                color: Colors.orangeAccent,
                textColor: Colors.white,
                onPressed: () => {
                  setState(() {
                    _change = true;
                  })},
              ),
            ),

          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //   const Text(
          //     'You have clicked the button this many times:',
          //   ),
          //   Text(
          //     '$_counter',
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


