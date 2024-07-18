import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/colors/my_colors.dart';

class SuperHeroDetailsScreen extends StatelessWidget {
  const SuperHeroDetailsScreen({
    super.key,
    required this.heroModel,
  });
  final dynamic heroModel;

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Horizon',
    );
    return Scaffold(
      backgroundColor: MyColors.scaffoldcColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Power Stats',
                        style: TextStyle(
                          color: MyColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildDivider(285),
                      buildPowerStats(),
                      const SizedBox(height: 20),
                      heroModel.fullName.isEmpty
                          ? const SizedBox()
                          : heroInfo('Full Name: ', heroModel.fullName),
                      buildDivider(300),
                      const SizedBox(height: 8),
                      buildAnimatedText(
                          heroModel.aliases, colorizeTextStyle, colorizeColors),
                    ],
                  ),
                ),
                const SizedBox(height: 650),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.appBarColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: MyColors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
          '${heroModel.name}',
          style: const TextStyle(
            fontSize: 25,
            letterSpacing: 1,
            backgroundColor: MyColors.appBarColor,
            color: MyColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        background: Hero(
          tag: heroModel.id,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: heroModel.image,
            placeholder: (context, url) => Image.asset(
              'assets/loading/Animation - hero1.gif',
              fit: BoxFit.cover,
            ),

        
            errorWidget: (context, url, error) => Image.asset(
              'assets/empty-image.png',
              fit: BoxFit.cover,
            ),
          ),
        
        ),
      ),
    );
  }

  Widget buildPowerStats() {
    final double? speed = heroModel.powerstats['speed'] == null
        ? 0.0
        : double.tryParse('${heroModel.powerstats['speed']}');
    final double? power = heroModel.powerstats['power'] == null
        ? 0.0
        : double.tryParse('${heroModel.powerstats['power']}');
    final double? intelligence = heroModel.powerstats['intelligence'] == null
        ? 0.0
        : double.tryParse('${heroModel.powerstats['intelligence']}');
    final double? strength = heroModel.powerstats['strength'] == null
        ? 0.0
        : double.tryParse('${heroModel.powerstats['strength']}');
    final double? durability = heroModel.powerstats['durability'] == null
        ? 0.0
        : double.tryParse('${heroModel.powerstats['durability']}');
    final double? combat = heroModel.powerstats['combat'] == null
        ? 0.0
        : double.tryParse('${heroModel.powerstats['combat']}');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildPieChary('speed', speed, MyColors.blue),
          buildPieChary('power', power, MyColors.red),
          buildPieChary('intelligence', intelligence, MyColors.green),
          buildPieChary('strength', strength, MyColors.amber),
          buildPieChary('durability', durability, MyColors.brown),
          buildPieChary('combat', combat, MyColors.black),
        ],
      ),
    );
  }

  Widget buildPieChary(name, stats, color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: stats ?? 0.0,
                        color: color,
                        title: '',
                        radius: 14,
                      ),
                      PieChartSectionData(
                        value: stats == null ? 100 : 100.0 - stats,
                        color: Colors.grey[200],
                        title: '',
                        radius: 14,
                      ),
                    ],
                    startDegreeOffset: -90,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        heroModel.powerstats[name] == 'null'
                            ? '0'
                            : "${int.tryParse('${heroModel.powerstats[name]}')}",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            name.toString(),
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget heroInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title $value',
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.amber,
      thickness: 2,
    );
  }

  Widget buildAnimatedText(aliases, colorizeTextStyle, colorizeColors) {
    if (aliases.isNotEmpty) {
      int random = Random().nextInt(aliases.length);
      return Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              aliases[random],
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
      );
    }
    return const SizedBox();
  }
}
