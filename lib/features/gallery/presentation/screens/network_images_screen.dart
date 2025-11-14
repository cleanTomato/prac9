import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImagesScreen extends StatelessWidget {
  const NetworkImagesScreen({super.key});

  final List<Map<String, String>> images = const [
    {
      'url': 'https://avatars.mds.yandex.net/i?id=19844ecf17e05468a76692d9c1188fd4_l-5879086-images-thumbs&n=13',
      'title': 'Чистая вода',
    },
    {
      'url': 'https://img.freepik.com/premium-photo/natural-aromatic-fruit-tea-transparent-teapot-cup-among-berries-flowers-warming-aromatic-tea-with-deep-aroma-berries-wildflowers_152625-8752.jpg?size=626&ext=jpg',
      'title': 'Ароматный чай',
    },
    {
      'url': 'https://i.pinimg.com/736x/c5/b5/95/c5b595cb17b7f3e475f8914c652f9741.jpg',
      'title': 'Свежий кофе',
    },
    {
      'url': 'https://www.shutterstock.com/image-photo/various-freshly-squeezed-fruits-vegetables-260nw-679477138.jpg',
      'title': 'Фруктовый сок',
    },
    {
      'url': 'https://avatars.mds.yandex.net/i?id=09f9a5d9f45cc014c66c320f68433ea1_sr-4261589-images-thumbs&n=13',
      'title': 'Минеральная вода',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Галерея напитков'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: image['url']!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    image['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}