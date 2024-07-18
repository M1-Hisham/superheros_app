import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/models/model.dart';
import 'package:movies/data/repository/repository.dart';
part 'superhero_state.dart';

class SuperheroCubit extends Cubit<SuperheroState> {
  SuperheroCubit(this.superHeroRepository) : super(SuperheroInitial());

  final SuperHeroRepository superHeroRepository;

  List<CharactersModel>? allSuperHeroList;

  List<CharactersModel>? allgetSuperHero() {
    superHeroRepository.getAllSuperHeros().then((value) {
      allSuperHeroList = value;
      emit(HeroLoaded(value));
    });
    return allSuperHeroList;
  }
  
}
class TopSuperheroCubit extends Cubit<SuperheroState> {
  TopSuperheroCubit(this.superHeroRepository) : super(SuperheroInitial());

  final SuperHeroRepository superHeroRepository;

  List<TopSuperHero>? topSuperHeroList;
  
  List<TopSuperHero>? getTopSuperHero() {
    superHeroRepository.getTopSuperHeros().then((value) {
      topSuperHeroList = value;
      emit(TopHeroLoaded(value));
    });
    return topSuperHeroList;
  }
}
