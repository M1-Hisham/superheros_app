import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/superhero_cubit.dart';
import 'package:movies/constants/colors/my_colors.dart';
import 'package:movies/data/models/model.dart';
import 'package:movies/presentation/widget/superhero_item.dart';

class SuperHeroScreen extends StatefulWidget {
  const SuperHeroScreen({super.key});

  @override
  State<SuperHeroScreen> createState() => _SuperHeroScreenState();
}

class _SuperHeroScreenState extends State<SuperHeroScreen> {
  List<CharactersModel>? allSuperHero;
  List<TopSuperHero>? topSuperHero;
  List<CharactersModel>? seachedForSuperHero;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      focusNode: _focusNode,
      cursorColor: MyColors.white,
      decoration: const InputDecoration(
        hintText: 'Find a Super Hero....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.white, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.white, fontSize: 18),
      onChanged: (value) {
        addSearchedForItemsToSearchedList(value);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String value) {
    seachedForSuperHero = allSuperHero!
        .where(
          (element) => element.name.toLowerCase().startsWith(value),
        )
        .toList();
    setState(() {});
  }

  Widget _buildAppBarTitle() {
    return const Center(
      child: Text(
        'SUPERHEROS',
        style: TextStyle(
          color: MyColors.white,
          // height: 3,
          fontSize: 24,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.white,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search_rounded,
            color: MyColors.white,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(
        onRemove: _stopSeaching,
      ),
    );
    setState(() {
      _isSearching = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void _stopSeaching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SuperheroCubit>(context).allgetSuperHero();
    BlocProvider.of<TopSuperheroCubit>(context).getTopSuperHero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldcColor,
      appBar: AppBar(
        backgroundColor: MyColors.appBarColor,
        leading: _isSearching
            ? const BackButton(color: MyColors.white)
            : const SizedBox(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Top Super Hero',
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<TopSuperheroCubit, SuperheroState>(
                builder: (context, state) {
                  // if (state is TopHeroLoaded) {
                  //   topSuperHero = state.topHero;
                  // }
                  if (state is TopHeroLoaded) {
                    topSuperHero = state.topHero;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.295,
                      child: buildSuperHeroRowList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 3, 79, 120),
                      ),
                    );
                  }
                },
              ),

              const Text(
                'All Super Hero',
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<SuperheroCubit, SuperheroState>(
                builder: (context, state) {
                  // if (state is TopHeroLoaded) {
                  //   topSuperHero = state.topHero;
                  // }
                  if (state is HeroLoaded) {
                    allSuperHero = state.hero;
                    return buildSuperHeroList();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 3, 79, 120),
                      ),
                    );
                  }
                },
              ),

              
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuperHeroRowList() {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2 / 2.1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: topSuperHero!.length,
      itemBuilder: (context, index) {
        return SuperHeroItem(
          superHero: topSuperHero![index],
          // topSuperHero: topSuperHero![index],
        );
      },
      padding: const EdgeInsets.all(8),
      
    );
  }

  Widget buildSuperHeroList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: _searchTextController.text.isEmpty
          ? allSuperHero!.length
          : seachedForSuperHero!.length,
      itemBuilder: (context, index) {
        return SuperHeroItem(
          superHero: _searchTextController.text.isEmpty
              ? allSuperHero![index]
              : seachedForSuperHero![index],
        );
      },
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }
}
