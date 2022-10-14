import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:noticias_provider/src/models/category_model.dart';
import 'package:noticias_provider/src/models/news_model.dart';

final _urlNews = 'https://newsapi.org/v2';
final _apiKey = '91fa56526d314d5eafcc1857d1e94d2a';

class NewsServices with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'Business'.toLowerCase();
  List<CategoryNews> category = [
    CategoryNews(FontAwesomeIcons.businessTime, 'Business'),
    CategoryNews(FontAwesomeIcons.poo, 'Entertainment'),
    CategoryNews(FontAwesomeIcons.genderless, 'General'),
    CategoryNews(FontAwesomeIcons.staffSnake, 'Health'),
    CategoryNews(FontAwesomeIcons.atom, 'Science'),
    CategoryNews(FontAwesomeIcons.futbol, 'Sports'),
    CategoryNews(FontAwesomeIcons.microchip, 'Technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsServices() {
    this.getTopHeadlines();

    category.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];
  

  getTopHeadlines() async {
    Uri url = Uri.parse('$_urlNews/top-headlines?apiKey=$_apiKey&country=co');
    final resp = await http.get(url);

    //recibe un string y devuelve una instancia
    final newsResponse = newResponseFromJson(resp.body);
    // agrega a la lista los ariculos
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    Uri url = Uri.parse(
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=co&category=$category');
    final resp = await http.get(url);

    //recibe un string y devuelve una instancia
    final newsResponse = newResponseFromJson(resp.body);
    this.categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}
