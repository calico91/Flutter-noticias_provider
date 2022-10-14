import 'package:flutter/material.dart';
import 'package:noticias_provider/src/models/news_model.dart';
import 'package:noticias_provider/src/themes/theme_dartk.dart';
import 'package:noticias_provider/src/util/util.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: this.noticias.length,
        itemBuilder: (context, i) {
          return _Noticia(noticia: this.noticias[i], i: i);
        });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int i;

  const _Noticia({required this.noticia, required this.i});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia, i),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        __TarjetaBotones(noticia),
        SizedBox(height: 10),
        Divider()
      ],
    );
  }
}

class __TarjetaBotones extends StatelessWidget {
  final Article noticia;

  const __TarjetaBotones(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      RawMaterialButton(
        child: Text(
          'ver noticia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          if (!await launchUrl(Uri.parse(noticia.url))) {
            throw 'Could not launch $noticia.url';
          }
          ;
        },
        fillColor: miTema.colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      )
    ]));
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text((noticia.description != null) ? noticia.description! : '',
          textAlign: TextAlign.justify),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (noticia.urlToImage != null)
                ? Image(
                    image: NetworkImage(Util().urlValida(noticia.urlToImage!)),
                    fit: BoxFit.cover,
                  )
                //FadeInImage(
                //     placeholder: const AssetImage('assets/img/giphy.gif' ),
                //     image: NetworkImage(
                //         Util().urlValida(noticia.urlToImage!)),
                //     fit: BoxFit.cover,
                //   )
                : const Image(image: AssetImage('assets/img/no-image.png'))),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        textAlign: TextAlign.justify,
        noticia.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final i;

  const _TarjetaTopBar(this.noticia, this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${i + 1}.',
            style: TextStyle(color: miTema.colorScheme.secondary),
          ),
          Text('${noticia.source.name}.'),
        ],
      ),
    );
  }
}
