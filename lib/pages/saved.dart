import 'package:flutter/material.dart';
import 'package:DayLang/elems/offer_type.dart';
//import 'dart:io';
//import 'dart:convert';

class Saved extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                color: Color(0xFF242424),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("saved"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.01904761),
                        
                        backgroundColor: Color.fromARGB(25, 255, 255, 255),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03809523809523809),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Pupil's offers"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.01904761),
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03809523809523809),
                        ),
                      ),

                    
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