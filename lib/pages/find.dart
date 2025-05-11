import 'package:flutter/material.dart';
import 'package:DayLang/elems/offer_type.dart';
//import 'dart:io';
//import 'dart:convert';

class Find extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF242424),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.04504761),
                        minimumSize: Size.zero,
                        backgroundColor: const Color.fromARGB(25, 255, 255, 255),
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03809523809523809),
                        ),
                      ),
                      child: Text("Teacher's offers", style: TextStyle(fontSize: screenWidth * 0.03809523809523),),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.04504761),
                        minimumSize: Size.zero,
                        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03809523809523809),
                        ),
                      ),
                      child: Text("Pupil's offers", style: TextStyle(fontSize: screenWidth * 0.03809523809523)),                    
                    ),
                  ],
                ),
              ),
              Expanded(
                child: OfferType(),
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