// Author: Steffen

import '../../widgets/shared/app_bar.dart';
import '../../data/classes/article.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:drop_cap_text/drop_cap_text.dart';

class ArticleView extends StatelessWidget {
  final Article article;
  const ArticleView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      article.picture,
    );
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
      completer.complete(info.image);
    }));
    return Scaffold(
      appBar: AppBarIcon(actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Text(article.title, style: Theme.of(context).textTheme.titleLarge),
          Divider(color: Theme.of(context).primaryColor),
          FutureBuilder<ui.Image>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              if (snapshot.hasData) {
                return DropCapText(article.text,
                    dropCapPosition: DropCapPosition.end,
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                        width: snapshot.data!.width.toDouble() / 4,
                        height: snapshot.data!.height.toDouble() / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(article.picture),
                        )));
              } else {
                return const Text("");
              }
            },
          )
        ]),
      ),
    );
  }
}
