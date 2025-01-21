import 'dart:io';
import 'package:flutter/material.dart';

class ProfilePhotoSectionWidget extends StatelessWidget {
  final File? image;
  final VoidCallback onTakePicture;
  final VoidCallback onViewPhotos;

  const ProfilePhotoSectionWidget({
    Key? key,
    required this.image,
    required this.onTakePicture,
    required this.onViewPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Zdjęcie sylwetki',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (image != null)
          Image.file(
            image!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.camera_alt,
            color: Colors.green,
          ),
          label: const Text(
            'Zrób zdjęcie',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: onTakePicture,
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.photo_album,
            color: Colors.green,
          ),
          label: const Text(
            'Zobacz zdjęcia użytkownika',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: onViewPhotos,
        ),
      ],
    );
  }
}
