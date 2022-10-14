import 'package:flutter/material.dart';
import 'package:noticias_provider/src/services/news_services.dart';
import 'package:noticias_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
//ListaNoticias(newsServices.headlines);
    final newsServices = Provider.of<NewsServices>(context);
    return Scaffold(
      body: (newsServices.headlines.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : ListaNoticias(newsServices.headlines)
    );
    
  }
  
  @override

  bool get wantKeepAlive => true;
}
