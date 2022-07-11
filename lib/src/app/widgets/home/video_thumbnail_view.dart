import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoThumbnailView extends StatelessWidget {
  const VideoThumbnailView({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: CachedNetworkImageProvider(url),
        ),
        SizedBox(
          child: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white)),
        )
      ],
    );
  }
}
