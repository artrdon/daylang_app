import 'package:DayLang/elems/offer_reviews.dart';
import 'package:DayLang/elems/vozmozno.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../const_values/http_link.dart';


class Offer extends StatefulWidget implements PreferredSizeWidget {
  final String? username;
  final int id;

  
  const Offer({Key? key, required this.username, required this.id}) : super(key: key);
  @override
  State<Offer> createState() => _OfferState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OfferState extends State<Offer> {
  List<dynamic> data = [];
  bool isLoading = true;
  String? error;

  Future<void> getOfferinfo() async {
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
      final response = await dio.get('${Http().http}/gettingoffer/${widget.username}/${widget.id}/');
      

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
    getOfferinfo();
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
      backgroundColor: const Color(0xFF191919),
      body: SingleChildScrollView(
        child: SafeArea( // Добавляем SafeArea для защиты от системных областей
          child: Column(

            children: [
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image(image: NetworkImage(data[0]['photo']), width: screenWidth - screenWidth * 0.03809523809523, height: screenWidth - screenWidth * 0.03809523809523, fit: BoxFit.contain,),
                )
              ),
              TextButton(
                onPressed: () => {}, 
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Color.fromARGB(255, 0, 78, 213),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  minimumSize: Size(screenWidth - screenWidth * 0.03809523809523, screenWidth * 0.095238095238),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Убираем скругление
                  ),
                ),
                child: Text('chat', style: TextStyle(fontSize: screenWidth * 0.05714285714285),),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.01904761, top: screenWidth * 0.03),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth - screenWidth * 0.03809523809523 - screenWidth * 0.14,
                      child: Text(data[0]['name'], style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06095238), softWrap: true),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero, // Убирает внутренние отступы
                      constraints: BoxConstraints(),
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () => {}, 
                      icon: Image.asset('src/static/img/srce.png', width: screenWidth * 0.09, height: screenWidth * 0.09, color: Colors.white),
                    )
                    
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01904761),
                  child: Text('${data[0]['price'].toString()} ₽', style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.07619047), textAlign: TextAlign.left,),
                )                
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.circle, size: screenWidth * 0.03), // bullet point
                      title: Text('Есть микрофон? ${data[0]['microphone'].toString()}', style: TextStyle(fontSize: screenWidth * 0.0380952, color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle, size: screenWidth * 0.03), // bullet point
                      title: Text('Цели: ${data[0]['target'].toString()}', style: TextStyle(fontSize: screenWidth * 0.0380952, color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle, size: screenWidth * 0.03), // bullet point
                      title: Text('Возраст: ${data[0]['age'].toString()}', style: TextStyle(fontSize: screenWidth * 0.0380952, color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle, size: screenWidth * 0.03), // bullet point
                      title: Text('Формат: ${data[0]['format'].toString()}', style: TextStyle(fontSize: screenWidth * 0.0380952, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01904761),
                  child: Text(data[0]['description'], style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04761904),)
                )             
              ),
              Container(
                width: screenWidth - screenWidth * 0.03809523809523,
                height: screenWidth * 0.171428,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(screenWidth * 0.00952380)
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.0380),
                      child: ClipOval(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Image.network(data[0]['chel_photo'], width: screenWidth * 0.1333333333, height: screenWidth * 0.1333333333,),
                        ),
                      ),
                    ),
                    
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${data[0]['first_name']} ${data[0]['last_name']}', style: TextStyle(fontSize: screenWidth * 0.0380952, color: Colors.white),),
                              Image.asset('src/static/img/confirmed.png', width: screenWidth * 0.0476190476,)
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(data[0]['about_myself'], style: TextStyle(fontSize: screenWidth * 0.0380952, color: Colors.white), ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth - screenWidth * 0.03809523809523,
                margin: EdgeInsets.only(top: screenWidth * 0.0761904),
                child: Row(
                  children: [
                    Text('Reviews', style: TextStyle(fontSize: screenWidth * 0.057142857, color: Colors.white),),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.01),
                      child: Image.asset('src/static/img/11.png', width: screenWidth * 0.0571428, ),
                    ),
                    Text(data[0]['review'], style: TextStyle(fontSize: screenWidth * 0.057142857, color: Colors.white),),
                  ],
                ),
              ),
              OfferReviews(id: widget.id),
              Container(
                margin: EdgeInsets.only(top: screenWidth * 0.3809),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.0108),
                        child: Text('Возможно вам подойдут', style: TextStyle(fontSize: screenWidth * 0.0571428, color: Colors.white),),
                      ),
                       
                    ),
                    Vozmozno(),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}