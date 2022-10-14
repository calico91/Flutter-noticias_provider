import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:noticias_provider/src/pages/tab1_page.dart';
import 'package:noticias_provider/src/pages/tab2_page.dart';
import 'package:noticias_provider/src/services/news_services.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(body: _paginas(), bottomNavigationBar: _NavegacionCurved()),
    );
  }
}

class _NavegacionCurved extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return CurvedNavigationBar(
      animationDuration:Duration(milliseconds: 800) ,
      animationCurve: Curves.ease,
      height: 45,
      color: Color.fromRGBO(0, 0, 0, 1),
    backgroundColor: Color.fromARGB(0, 0, 0, 0),
    items: const <Widget>[
      Icon(Icons.newspaper_rounded, size: 30),
      Icon(Icons.list, size: 30),
    ],
    onTap: (index) => navegacionModel.paginaActual = index
  );
  }
}

class _navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    final newsServices = Provider.of<NewsServices>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_off_outlined), label: ('pa ti')),
        BottomNavigationBarItem(
            icon: Icon(Icons.public), label: ('Encabezados'))
      ],
    );
  }
}

class _paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [Tab1Page(), Tab2Page(), ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
//clase donde se controla los estados del buttonnavegationbar
  int _paginaActual = 0;

  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
