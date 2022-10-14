import 'package:flutter/material.dart';
import 'package:noticias_provider/src/pages/tabs_page.dart';
import 'package:noticias_provider/src/services/news_services.dart';
import 'package:noticias_provider/src/themes/theme_dartk.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>NewsServices())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'material app',
        theme: miTema,
        home: const TabsPage()
      ),
    );
  }
}
