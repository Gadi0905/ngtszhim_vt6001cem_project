import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_image_asset.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black38,
      child: Stack(
        children: [
          _buildBackgroundImage(context),
          child,
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return const Positioned.fill(
      child: Opacity(
        opacity: 0.3,
        child: CustomImageAsset(
          image: 'wallpaper.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
