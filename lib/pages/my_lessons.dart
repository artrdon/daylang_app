import 'package:flutter/material.dart';
//import 'dart:io';
//import 'dart:convert';

class MyLessons extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF242424),
                child: const Row(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}