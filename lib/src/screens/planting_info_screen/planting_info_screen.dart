import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_appbar.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_background.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_image_asset.dart';

class PlantingInfoScreen extends StatelessWidget {
  const PlantingInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomBackground.basicColor(
      context: context,
      child: Stack(
        children: [
          _buildBackgroundImage(context),
          _buildItem(context),
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

  Widget _buildItem(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            _buildText(context),
            const SizedBox(height: 10),
            _buildCard(context),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: const [
          Text(
            'Planting Tips for Beginners',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: const [
              Text(
                'A pot of green plants can not only add vitality to the '
                'home, but also purify the air and create a more comfortable '
                'living environment. However, it is also important to choose '
                'plants that are suitable for indoor planting and can match your '
                'own living environment. The following points are the selection '
                'of indoor plants. The basic concept, a novice planter can start '
                'with simple and easy-to-grow evergreen plants to build their own '
                'green home.',
              ),
              Divider(
                thickness: 3,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              Text(
                '1.Choose "Good Care" Plants',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Choose plants that are better cared for, and do not need to '
                'be watered every day. Generally, the most suitable '
                'condition for indoor plants is to water once every 10 '
                'days, so that the plants will not wither due to neglect '
                'of care because of forgetting to water.',
              ),
              Divider(
                thickness: 3,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              Text(
                '2.Do not let the plants accumulate water',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'One of the most important things about growing plants '
                'indoors is that they don\'t allow it to accumulate '
                'water, so as not to breed mosquitoes.',
              ),
              Divider(
                thickness: 3,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              Text(
                '3.Clear water spray makes plants healthier!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'In summer, the air conditioner is almost always running, '
                'which makes it easy to dry the home or office space. Thin '
                'leaves, such as broad-leaved plants, are very easy to dry '
                'and rough, so you must always pay attention to using water '
                'spray on the leaves to keep them moist. , so that the '
                'plant can live beautifully and healthy.',
              ),
              Divider(
                thickness: 3,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              Text(
                '4.Pay attention to plant size',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'When choosing a plant, you must pay attention to its '
                'proportions. Although there is no certain criterion '
                'for proportions, you can choose the size according to '
                'the main function of placing plants. For example, if you '
                'want to divide the open space, you can choose More '
                'exaggerated tree shapes or large plants are used to '
                'distinguish the indoor space; while desks or computer '
                'desks can be placed on small potted plants such as cacti, '
                'which will help us to do things emotionally or absorb '
                'electromagnetic waves.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
