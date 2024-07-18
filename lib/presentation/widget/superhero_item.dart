import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/colors/my_colors.dart';
import 'package:movies/constants/string.dart';

class SuperHeroItem extends StatelessWidget {
  const SuperHeroItem({
    super.key,
    required this.superHero,
    // required this.topSuperHero,
  });
  final dynamic superHero;
  // final TopSuperHero topSuperHero;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue, // اللون الأول
            Colors.purple, // اللون الثاني
            Colors.red, // اللون الثالث
          ],
          begin: Alignment.topLeft, // نقطة بداية التدرج
          end: Alignment.bottomRight, // نقطة نهاية التدرج
        ),
        // color: MyColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, superHeroDetailsScreen,
            arguments: superHero),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              superHero!.name,
              style: const TextStyle(
                height: 1,
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: superHero!.id,
            child: Container(
              color: MyColors.black,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: superHero.image,
                placeholder: (context, url) => Image.asset(
                  'assets/loading/Animation - hero1.gif',
                  fit: BoxFit.cover,
                ),

                // progressIndicatorBuilder: (context, url, downloadProgress) =>
                //     Image.asset(
                //   'assets/loading/Animation - hero1.gif',
                //   fit: BoxFit.cover,
                // ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/empty-image.png',
                  fit: BoxFit.cover,
                ),
              ),
              //  superHero!.image.isNotEmpty
              //     ? FadeInImage.assetNetwork(
              //         width: double.infinity,
              //         height: double.infinity,
              //         fit: BoxFit.cover,
              //         placeholder: 'assets/loading/Animation - hero1.gif',
              //         image: superHero!.image)
              //     : Image.asset('assets/empty-image.png'),
            ),
          ),
        ),
      ),
    );
  }
}
