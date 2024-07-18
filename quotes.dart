class quotes{
  String? quote;
  String? author;
  String? category;

  quotes({this.quote, this.author, this.category});

  quotes.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dailyquote = new Map<String, dynamic>();
    dailyquote['quote'] = this.quote;
    dailyquote['author'] = this.author;
    dailyquote['category'] = this.category;
    return dailyquote;
  }
}