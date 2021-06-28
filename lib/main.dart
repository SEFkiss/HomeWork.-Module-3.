// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Модуль 3. Домашка. Задание №1,2,3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Метод для отображения лоадера загрузки (чтобы не было копипасты) для обычных Image
  Widget loadingImage(
      BuildContext context, Widget child, ImageChunkEvent? loadingStatus) {
    if (loadingStatus == null) return child;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            child: const CircularProgressIndicator())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Задание 2
            CarouselSlider(
              items: <Widget>[
                // Задание 1
                // SVG из ассетов
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('SVG из ассетов'),
                    SvgPicture.asset(
                      'assets/images/13.svg',
                      height: 150,
                      color: Colors.red[700],
                      semanticsLabel: 'This is SVG image',
                      placeholderBuilder: (context) =>
                          const CircularProgressIndicator(),
                    ),
                  ],
                ),

                // SVG из сети, кстати на эмуляторе Chrome в VS code вылетал эксепшен,
                // на гитхабе пишут что только при web эмуляции есть такая ошибка.
                // На эмуляторе он Android Studio все окей.
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('SVG из сети'),
                    SvgPicture.network(
                      'https://www.svgrepo.com/show/2046/dog.svg',
                      height: 150,
                      semanticsLabel: 'Good boy',
                      placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: const CircularProgressIndicator()),
                    ),
                  ],
                ),

                // Изображение из сети
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Изображение из сети'),
                    Image.network(
                      'https://privately.ru/cook/uploads/posts/2020-05/privately.ru_kakoe-velikolepnoe-oformlenie-tortikov-6.jpg',
                      height: 150,
                      semanticLabel: 'Easy network image',
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
                Image.network(
                    'https://avatars.mds.yandex.net/get-zen_doc/29485/pub_5bfe5f7c042fd800aa66ff3f_5bfe9763a9f85900a9f1dc9a/scale_1200',
                    loadingBuilder: (context, child, loadingStatus) =>
                        loadingImage(context, child, loadingStatus)),
                Image.network(
                    'https://idoit.ru/wp-content/uploads/2019/10/zzp4.jpg',
                    loadingBuilder: (context, child, loadingStatus) =>
                        loadingImage(context, child, loadingStatus)),
              ],
              options: CarouselOptions(height: 400),
            ),
          ],
        ),
      ),
    );
  }
}
