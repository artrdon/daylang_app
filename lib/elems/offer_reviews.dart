import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../const_values/http_link.dart';

class OfferReviews extends StatefulWidget implements PreferredSizeWidget {
  final int? id;
  
  const OfferReviews({Key? key, required this.id}) : super(key: key);
  @override
  State<OfferReviews> createState() => _OfferReviewsState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OfferReviewsState extends State<OfferReviews> {
  List<dynamic> data = [];
  bool isLoading = true;
  String? error;

  Future<void> getOfferReviews() async {
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
      final response = await dio.get('${Http().http}/reviews_two/${widget.id}/');
      
      if (response.statusCode != 200) {
        setState(() {
          error = 'Failed to retrieve user data!';
          isLoading = false;
        });
        return;
      }

      setState(() {
        data = response.data[0];
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
    getOfferReviews();
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

    return Container(
      width: screenWidth - screenWidth * 0.03809523809523,
      child: Column(
        children: [
          Container(
            height: screenWidth * 0.2,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(screenWidth * 0.0952380), topRight: Radius.circular(screenWidth * 0.0952380))
            ),
          ),
          Container(
            width: screenWidth - screenWidth * 0.03809523809523,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0, style: BorderStyle.solid),
            ),
            child: Column(
              children: data.map((dataItem) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.5, style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.0380),
                            child: ClipOval(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: Image.network(dataItem['photo'], width: screenWidth * 0.1333333333, height: screenWidth * 0.1333333333,),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${dataItem['name']} ${dataItem['last_name']}', 
                              style: TextStyle(
                                fontSize: screenWidth * 0.0380952, 
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.0380),
                            child: Transform.scale(
                              scaleX: -1,
                              child: Image.asset(
                                'src/static/img/${dataItem['score']}.png', 
                                width: screenWidth * 0.190476, 
                                height: screenWidth * 0.0380952,
                              ),
                            ),
                          )
                          
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.0380),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(dataItem['text'].toString(), style: TextStyle(fontSize: screenWidth * 0.03047619, color: Colors.white),),
                        ),
                        
                      ),
                    ],
                  ),
                );
              }).toList()
            ),
          ),
          InkWell(
            onTap: () {},
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(screenWidth * 0.0952380), bottomRight: Radius.circular(screenWidth * 0.0952380))
            ),
            child: Container(
              width: screenWidth - screenWidth * 0.03809523809523,
              height: screenWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(screenWidth * 0.0952380), bottomRight: Radius.circular(screenWidth * 0.0952380))
              ),
              child: Center(
                child: Text("Show more", style: TextStyle(fontSize: screenWidth * 0.0571428, color: Colors.white),),
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}