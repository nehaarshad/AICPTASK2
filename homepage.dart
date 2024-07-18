import 'dart:async';
import 'dart:convert';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:daily_quote_app/quoteDisplay.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late Future<Box> favorite;
  var fvrt = false;
  late Future<List<dynamic>> quoteFuture;

  @override
  void initState() {
    super.initState();
    quoteFuture = getQuotes();
    favorite = hive();
    ToastContext().init(context);
  }

  Future<Box> hive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return await Hive.openBox("favorite quotes");
  }

  Future<List<dynamic>> getQuotes() async {
    try {
      var response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/quotes?category=inspirational'),
        headers: {
          'X-Api-Key': 'WKXYpsii3oeaV0YOV7sgPg==z7hQjbeQUfkjvrAy',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  void refreshQuote() {
    setState(() {
      quoteFuture = getQuotes();
    });
  }

  void markfvrt(String quote, Box favorite) {
    setState(() {
      favorite.add(quote);
      fvrt = !fvrt;
      Toast.show("Quote added to favorites", duration: 2, gravity: Toast.top);
    });
  }

  void shareQuote(String quote) async {
    try {
      await FlutterShare.share(
        title: "Share Quote",
        text: quote,
        chooserTitle: 'Share Via',
      );

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: quoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return PageView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var quote = snapshot.data![index];
                    return FutureBuilder<Box>(
                      future: favorite,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          var favBox = snapshot.data!;
                          bool isFavorite = favBox.values.contains(quote["quote"]);
                          return quoteDisplay(
                            quote: quote["quote"],
                            author: quote["author"],
                            refresh: refreshQuote,
                            addtofvrt: () => markfvrt(quote["quote"], favBox),
                            sharequote: () => shareQuote(quote["quote"]),
                            fvrt: isFavorite,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}


