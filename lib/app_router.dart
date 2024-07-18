import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/superhero_cubit.dart';
import 'package:movies/data/repository/repository.dart';
import 'package:movies/data/services/services.dart';
import 'package:movies/presentation/screens/superhero_screen.dart';
import 'constants/string.dart';
import 'presentation/screens/superhero_details_screen.dart';

class AppRouter {
  late SuperHeroRepository superHeroRepository;
  late SuperheroCubit superheroCubit;
  AppRouter() {
    superHeroRepository = SuperHeroRepository(SuperHeroServices());
    superheroCubit = SuperheroCubit(superHeroRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case superHeroScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: superheroCubit,
              ),
              BlocProvider.value(
                value: TopSuperheroCubit(superHeroRepository),
              ),
            ],
            child: const SuperHeroScreen(),
          ),
        );

      case superHeroDetailsScreen:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => SuperHeroDetailsScreen(
            heroModel: args as dynamic,
          
          ),
        );
    }
    return null;
  }
}
