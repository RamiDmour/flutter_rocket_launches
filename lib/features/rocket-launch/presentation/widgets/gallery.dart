import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  const Gallery(
      {Key? key,
      required this.images,
      required this.imageWidth,
      required this.imageHeight})
      : super(key: key);
  final List<Image> images;
  final double imageWidth;
  final double imageHeight;

  Widget _buildGalleryItem(Image image) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: imageWidth,
      height: imageHeight,
      child: FittedBox(
        fit: BoxFit.fill,
        child: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images.map((image) => _buildGalleryItem(image)).toList(),
      ),
    );
  }
}
