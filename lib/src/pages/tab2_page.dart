import 'package:flutter/material.dart';
import 'package:noticias_provider/src/models/category_model.dart';
import 'package:noticias_provider/src/services/news_services.dart';
import 'package:noticias_provider/src/themes/theme_dartk.dart';
import 'package:noticias_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsServices>(context);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _ListaCategorias(),
          Expanded(
              child: ListaNoticias(
                  newsServices.getArticulosCategoriaSeleccionada ?? []))
        ],
      ),
    ));
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<NewsServices>(context).category;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryIcon(category[index]),
                SizedBox(
                  height: 5,
                ),
                Text(category[index].name)
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final CategoryNews category;

  const _CategoryIcon(this.category);

  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsServices>(context, listen: false);

    return GestureDetector(
      onTap: () {
        // print('${category.name}');
        newsServices.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: (newsServices.selectedCategory == this.category.name)
              ? miTema.colorScheme.secondary
              : Colors.black54,
        ),
      ),
    );
  }
}
