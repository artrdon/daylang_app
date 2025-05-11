import 'package:flutter/material.dart';
import '../pages/offer.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../const_values/http_link.dart';

class Vozmozno extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<Vozmozno> createState() => _VozmoznoState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _VozmoznoState extends State<Vozmozno> {
  List<dynamic> data = [];
  bool isLoading = true;
  String? error;

  Future<void> getVozmozno() async {
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
      final response = await dio.get('${Http().http}/creatingoffer/');
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
    getVozmozno();
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
      width: screenWidth,
      child: Wrap(
        direction: Axis.horizontal,
        children: data.map((dataItem) {
          return InkWell(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => Offer(username: dataItem['chel'], id: dataItem['id'],)
              ));
            },
            child: Container(
              width: screenWidth * 0.478,
              margin: EdgeInsets.all(screenWidth * 0.0108),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 52, 52, 52),
              ),
              child: Column(
                children: [
                  Image.network(dataItem['photo'], height: screenWidth * 0.435,),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Text(dataItem['name'], style: TextStyle(fontSize: screenWidth * 0.05, overflow: TextOverflow.ellipsis), maxLines: 1, softWrap: false,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(dataItem['price'].toString()),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset('src/static/img/11.png', width: screenWidth * 0.0571428, ),
                                Text(dataItem['review'].toString())
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ]
              ),
            ),
          );
        }).toList(),
      ),
    );    
  }
}