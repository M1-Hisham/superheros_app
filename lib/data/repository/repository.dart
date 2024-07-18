import 'package:movies/data/models/model.dart';
import 'package:movies/data/services/services.dart';

class SuperHeroRepository {
  SuperHeroRepository(this.superHeroServices);
  final SuperHeroServices superHeroServices;

  
  Future<List<CharactersModel>> getAllSuperHeros() async {
    
    final getAllSuperHeros = await superHeroServices.fetchAllSuperheroes();
    
    return getAllSuperHeros;
  }
  Future<List<TopSuperHero>> getTopSuperHeros() async {
    
    final getTopSuperHeros = await superHeroServices.fetchTopSuperheroes();
    
    return getTopSuperHeros;
  }
}
