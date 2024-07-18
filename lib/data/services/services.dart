// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:movies/data/models/model.dart';

class SuperHeroServices {
  

  Future<List<CharactersModel>> fetchAllSuperheroes() async {
    final List<String> urls = [];
    for (int i = 1; i <= 730; i++) {
      dynamic url =
          'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/$i';
      urls.add(url);
    }
    List<CharactersModel> superheroes = [];
    Dio dio = Dio();

    for (String url in urls) {
      try {
        final response = await dio.get(url);
        if (response.statusCode == 200) {
          superheroes.add(CharactersModel.fromJson(response.data));
        } else {
          throw Exception('Failed to load superhero');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return superheroes;
  }

  Future<List<TopSuperHero>> fetchTopSuperheroes() async {
    final List<String> urls = [
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/149',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/620',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/346',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/69',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/195',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/405',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/720',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/717',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/226',
      'https://superheroapi.com/api.php/4b4c3d3861f6741758a2078c3de1f746/38',
    ];

    List<TopSuperHero> superheroes = [];
    Dio dio = Dio();

    for (String url in urls) {
      try {
        final response = await dio.get(url);
        if (response.statusCode == 200) {
          superheroes.add(TopSuperHero.fromJson(response.data));
        } else {
          throw Exception('Failed to load superhero');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return superheroes;
  }
}
