import 'package:flutter/material.dart';
import 'package:DayLang/pages/find.dart';
import 'package:DayLang/theme.dart';
import 'package:provider/provider.dart';
//import 'dart:io';
//import 'dart:convert';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget body;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF191919),
          title: Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: screenWidth * 0.0571428, height: 1.0),),
          automaticallyImplyLeading: automaticallyImplyLeading,
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(context);
              },
            ),
          ],
          toolbarHeight: screenWidth * 0.13333,
        ),
        body: body,
        bottomNavigationBar: Container(
          color: const Color(0xFF191919),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: const Color(0xFF191919),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => CustomAppBar(title: 'DayLang', body: Find())),
                  );
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/saved');
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, '/message_list');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/my_lessons');
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, '/log');
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(icon: Image.asset('src/static/img/search.png', width: screenWidth * 0.09, height: screenWidth * 0.09, color: Colors.white), label: 'Find'),
              BottomNavigationBarItem(icon: Image.asset('src/static/img/srce.png', width: screenWidth * 0.09, height: screenWidth * 0.09, color: Colors.white), label: 'Saved'),
              BottomNavigationBarItem(icon: Image.asset('src/static/img/messagebutwhite.png', width: screenWidth * 0.09, height: screenWidth * 0.09, color: Colors.white, fit: BoxFit.fill), label: 'Messages'),
              BottomNavigationBarItem(icon: Image.asset('src/static/img/my_lessons.png', width: screenWidth * 0.09, height: screenWidth * 0.09, color: Colors.white), label: 'My Lessons'),
              BottomNavigationBarItem(icon: Image.asset('src/static/img/setting.png', width: screenWidth * 0.09, height: screenWidth * 0.09, color: Colors.white), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}