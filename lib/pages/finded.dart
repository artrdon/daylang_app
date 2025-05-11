import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../const_values/http_link.dart';
import 'package:DayLang/pages/offer.dart';


class Finded extends StatefulWidget implements PreferredSizeWidget {
  final String? language;
  
  const Finded({Key? key, required this.language}) : super(key: key);
  @override
  State<Finded> createState() => _FindedState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FindedState extends State<Finded> {
  List<dynamic> data = [];
  bool isLoading = true;
  String? error;

  Future<void> getOffersByLang() async {
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
      final response = await dio.get('${Http().http}/creatingoffer/${widget.language}/');
      print(response.data[0]);

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
    getOffersByLang();
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
      body: SafeArea( // Добавляем SafeArea для защиты от системных областей
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ключевой параметр!
            children: data.map((dataItem) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => Offer(username: dataItem['chel'], id: dataItem['id'],)
                  ));
                },
                child: Container(
                height: screenWidth * 0.2363636363,
                width: screenWidth - screenWidth * 0.0363636363, // Фиксированная высота или MediaQuery.of(context).size.height * 0.15
                margin: EdgeInsets.all(screenWidth * 0.01818181818), // Отступы между элементами
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.022222),
                  color: const Color.fromARGB(255, 58, 58, 58),
                ),
                child: Row(
                  children: [
                    Image(image: NetworkImage(dataItem['photo']), width: screenWidth * 0.25,),
                    Container(
                      width: screenWidth * 0.6,
                      padding: EdgeInsets.only(left: screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 196, 196, 196)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dataItem['name'], style: TextStyle(fontSize: screenWidth * 0.04, overflow: TextOverflow.ellipsis), maxLines: 1, softWrap: false,),
                          Text('${dataItem['price'].toString()} ₽', style: TextStyle(fontSize: screenWidth * 0.04, ),),
                          Text(dataItem['description'], style: TextStyle(fontSize: screenWidth * 0.03, overflow: TextOverflow.ellipsis), maxLines: 2, softWrap: false,),
                        ],
                      ),
                    )
                  ],
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