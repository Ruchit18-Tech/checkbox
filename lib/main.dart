import 'package:checkbox/modal/colordata.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'CheckBoxListTile';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Colordata allcolor = Colordata(title: "All Colors");

  List<Colordata> colorsdata = [
    Colordata(title: "Red"),
    Colordata(title: "Blue"),
    Colordata(title: "Green")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildMainCheckBox(allcolor),
        Divider(),
        ...colorsdata.map(buildCheckBox).toList(),
      ],
    );
  }

  Widget buildCheckBox(Colordata colorsData) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(colorsData.title),
        value: colorsData.value,
        onChanged: (bool? value) {
          setState(() {
            var newValue = value;

            colorsData.value = newValue!;

            if (!newValue) {
              allcolor.value = false;
            } else {
              final allow = colorsdata.every((color) => color.value);
              allcolor.value = allow;
            }
          });
        },
      );

  Widget buildMainCheckBox(Colordata colorsData) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(colorsData.title),
        value: colorsData.value,
        onChanged: (bool? value) {
          var newValue = value;

          setState(() {
            colorsData.value = newValue!;
            colorsdata.forEach((element) {
              element.value = newValue;
            });
          });
        },
      );
}

// ListView{List<Widget> children}.builder(
//       itemCount: colorsdata.length,
//       itemBuilder: (BuildContext context, int index) {
//         return buildCheckBox(colorsdata, index);
//       },
//     );