import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImageOverlay extends StatelessWidget {
  final String imageAsset;
  final String tag;
  final VoidCallback onClose;

  const FullScreenImageOverlay({
    super.key,
    required this.imageAsset,
    required this.tag,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.9),
      child: Stack(
        children: [
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: imageAsset,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
