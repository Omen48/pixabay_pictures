import 'package:flutter/material.dart';
import 'package:pixabay_pictures/UI/screens/full_screen_image.dart';

class PictureWidget extends StatelessWidget {
  final String imageAsset;
  final int likes;
  final int views;
  final String largeImageAsset;

  const PictureWidget({
    required this.imageAsset,
    required this.likes,
    required this.views,
    required this.largeImageAsset,
    super.key,
  });

  void _showFullScreenImage(BuildContext context) {
    final overlay = Overlay.of(context);
    late final OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => FullScreenImageOverlay(
        imageAsset: largeImageAsset,
        tag: imageAsset,
        onClose: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _showFullScreenImage(context),
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                borderOnForeground: true,
                child: ClipRect(
                  child: Hero(
                    tag: imageAsset,
                    child: Image.network(
                      imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(Icons.favorite, size: 16),
              Flexible(
                child: Text(
                  '$likes',
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis, // Это обеспечит сокращение текста, если он не вмещается
                ),
              ),
              const Icon(Icons.remove_red_eye, size: 16),
              Spacer(),
              Flexible(
                child: Text(
                  '$views',
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis, // Это обеспечит сокращение текста, если он не вмещается
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
