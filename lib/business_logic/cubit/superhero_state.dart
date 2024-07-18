part of 'superhero_cubit.dart';

@immutable
sealed class SuperheroState {}

final class SuperheroInitial extends SuperheroState {}


final class HeroLoaded extends SuperheroState {
  final List<CharactersModel>? hero;

  HeroLoaded( this.hero);
}
final class TopHeroLoaded extends SuperheroState {
  final List<TopSuperHero>? topHero;

  TopHeroLoaded( this.topHero);
}
