import 'package:daily_quote_app/favoritequotes.dart';
import 'package:flutter/material.dart';

class quoteDisplay extends StatelessWidget {
  final String quote;
  final String author;
  final VoidCallback refresh;
  final VoidCallback addtofvrt;
  final VoidCallback sharequote;
  bool fvrt;

  quoteDisplay({
    required this.quote,
    required this.author,
    required this.refresh,
    required this.addtofvrt,
    required this.sharequote,
    required this.fvrt,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
        child: Container(
        decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
    borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote,
                style: TextStyle(
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                '- $author',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.refresh, size: 30, color: Colors.white),
                    onPressed: refresh,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.favorite, size: 30, color: fvrt ? Colors.red : Colors.white),
                    onPressed: addtofvrt,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.share, size: 30, color: Colors.white),
                    onPressed: sharequote,
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => favoritequotes()));
                  },
                  child: Text(
                    "Favorite Quotes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
