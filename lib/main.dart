import 'package:flutter/material.dart';
import 'package:DayLang/nav.dart';
import 'package:DayLang/pages/find.dart';
import 'package:DayLang/pages/saved.dart';
import 'package:DayLang/pages/finded.dart';
import 'package:DayLang/pages/message_list.dart';
import 'package:DayLang/pages/my_lessons.dart';
import 'package:DayLang/pages/login.dart';
import 'package:DayLang/pages/register.dart';
import 'package:DayLang/theme.dart';
import 'package:provider/provider.dart';
//import 'dart:convert';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MaterialApp(
      
      initialRoute: '/',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeProvider().themeMode,
      routes: {
        '/': (context) => CustomAppBar(title: 'DayLang', body: Find()),
        '/saved': (context) => CustomAppBar(title: 'DayLang', body: Saved()),
        //'/finded/other': (context) => CustomAppBar(title: 'DayLang', body: Finded()),
        '/message_list': (context) => CustomAppBar(title: 'DayLang', body: MessageList()),
        '/my_lessons': (context) => CustomAppBar(title: 'DayLang', body: MyLessons()),
        '/log': (context) => Login(),
        '/reg': (context) => Register(),
      },
      onGenerateRoute: (RouteSettings settings) {
        // Обработка динамических маршрутов
        if (settings.name!.startsWith('/finded/')) {
          final language = settings.name!.split('/')[2]; // Извлекаем 'other'
          return MaterialPageRoute(
            builder: (context) => CustomAppBar(
              title: 'DayLang',
              body: Finded(language: language),
            ),
          );
        }
        return null; // Позволит использовать routes ниже
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(body: Center(child: Column(
          children: [
            const Text('404 Not Found'),
            TextButton(onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }, child: Text('Go to home page')),
          ],))),
      ),
    ),
  ),
);




