import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.blue,
            titleTextStyle: TextStyle(fontSize: 24, color: Colors.white))),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  IconData lastIconPressed = Icons.circle_outlined;
  IconButton createIconButton(IconData iconName, Color colorData) {
    return IconButton(
      onPressed: () {
        addShapeToBoard(iconName);
      },
      icon: Icon(
        iconName,
        color: colorData,
        size: 50,
      ),
    );
  }

  Icon createIcon(IconData shapeName, Color colorName) {
    return Icon(
      shapeName,
      size: 50,
      color: Colors.black,
    );
  }

  List<Icon> shapeList = [
    //createIconButton(Icons.circle_outlined),
  ];
  void addShapeToBoard(IconData shapeName) {
    lastIconPressed = shapeName;
    setState(() {
      if (shapeName == Icons.circle_outlined) {
        shapeList.add(createIcon(Icons.circle_outlined, Colors.black));
      } else if (shapeName == Icons.crop_square_outlined) {
        shapeList.add(createIcon(Icons.crop_square_outlined, Colors.black));
      } else {
        shapeList
            .add(createIcon(CupertinoIcons.arrowtriangle_up, Colors.black));
      }
    });
  }

  void changeShapeInBoard(int indexToChange) {
    setState(() {
      shapeList[indexToChange] = createIcon(lastIconPressed, Colors.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shape Task"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.8
                        : MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: shapeList[index],
                      onTap: () {
                        changeShapeInBoard(index);
                      },
                    );
                  },
                  itemCount: shapeList.length,
                )),
            const Spacer(),
            Container(
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.black,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  createIconButton(Icons.crop_square_outlined, Colors.white),
                  createIconButton(Icons.circle_outlined, Colors.white),
                  createIconButton(
                      CupertinoIcons.arrowtriangle_up, Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
