import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/image_path_helper/image_path_helper.dart';

class CustomImageAsset extends StatelessWidget {
  const CustomImageAsset({
    Key? key,
    this.image,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);
  final String? image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagesPathHelper.imagePath(image ?? 'app_logo.png'),
      width: width ?? 200,
      height: height ?? 200,
      fit: fit,
    );
  }
}
