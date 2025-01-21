import 'package:flutter/material.dart';

class PhotoNavigationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPhotos;

  const PhotoNavigationWidget({
    Key? key,
    required this.currentPage,
    required this.totalPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Zdjęcie ${currentPage + 1} z $totalPhotos',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
