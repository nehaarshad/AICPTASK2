import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Boxes.dart';

class favoritequotes extends StatelessWidget {
  final Box favorite = Hive.box('favorite quotes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Favorite Quotes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              wordSpacing: 3.0,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: ValueListenableBuilder<Box>(
          valueListenable: favorite.listenable(),
            builder: (context, box, _) {
            if (box.isEmpty) {
            return Center(
            child: Text(
            "FAVOURITE QUOTES NOT FOUND",
            style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            ),
            ),
            );
            }
            var data = box.values.toList();
            return ListView.separated(
            itemCount: favorite.length,
            reverse: true,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
            final quote = favorite.getAt(index) as String;

                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.deepPurple,
                      child: ListTile(
                        title: Text(quote,style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                    
                        ),),
                      ),
                    ),
                  );
                },
              );
            },
          ),
      ),
      );
  }
}
