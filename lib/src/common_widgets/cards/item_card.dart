import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.image, required this.onPress})
      : super(key: key);
  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Card(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const Text('Iphone 12'),
            const Text('Price: 1000\$'),
          ],
        ),
      ),
    );
  }
}
