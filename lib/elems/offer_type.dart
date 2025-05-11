import 'package:flutter/material.dart';
import '../pages/finded.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../const_values/http_link.dart';

class OfferType extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<OfferType> createState() => _OfferTypeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OfferTypeState extends State<OfferType> {
  List<dynamic> data = [];
  bool isLoading = true;
  String? error;

  Future<void> getUserData() async {
    final dio = Dio()
    ..interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(), // Кэш в памяти
          policy: CachePolicy.forceCache, // Стратегия кэширования
          maxStale: const Duration(days: 7), // Срок хранения
        ),
      ),
    );
    try {
      final response = await dio.get('${Http().http}/lol');
      //print(response.data[0]);

      if (response.statusCode != 200) {
        setState(() {
          error = 'Failed to retrieve user data!';
          isLoading = false;
        });
        return;
      }

      setState(() {
        data = response.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    return Scaffold(
        backgroundColor: Color(0xFF191919),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(screenWidth * 0.01904761),
            width: screenWidth,
            child: Wrap(
              direction: Axis.horizontal,
              children: data.map((dataItem) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => Finded(language: dataItem['name_of_lang'])
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(screenWidth * 0.009523809523809523),
                    child: Stack(
                    children: [

                      Container(
                        width: screenWidth * 0.461904,
                        height: (screenWidth * 0.461904) / 2 * 3,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 149, 255),
                          borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                        ),
                      ),

                      Positioned(
                        top: screenWidth * 0.04,
                        left: screenWidth * 0.02,
                        child: Image.asset(
                          dataItem['lang_flag'].substring(1),
                          width: screenWidth * 0.461904 - screenWidth * 0.04,
                          height: (screenWidth * 0.461904 - screenWidth * 0.04) / 16 * 9,
                        ),
                      ),

                      Positioned(
                        top: screenWidth * 0.34,
                        width: screenWidth * 0.461904,
                        child: Text(
                          dataItem['name_of_lang'],
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Число "100"
                      Positioned(
                        bottom: screenWidth * 0.05,
                        left: screenWidth * 0.06,
                        width: screenWidth * 0.461904 - screenWidth * 0.12,
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.01904761),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 235, 235),
                            borderRadius: BorderRadius.circular(screenWidth * 0.009523809523809523),
                          ),
                          child: Text(
                            dataItem['number_of_offers'].toString(),
                            style: TextStyle(
                              color: Colors.black, // Изменил на черный для контраста
                              fontSize: screenWidth * 0.06,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    
  }
}