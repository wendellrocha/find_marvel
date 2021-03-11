import 'package:find_marvel/app/modules/characters/pages/search/search_page.dart';

import 'pages/search/search_bloc.dart';
import 'package:find_marvel/app/modules/characters/pages/character/character_page.dart';

import 'pages/character/character_bloc.dart';
import 'characters_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'characters_page.dart';

class CharactersModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchBloc()),
        Bind((i) => CharacterBloc()),
        Bind((i) => CharactersBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => CharactersPage()),
        ModularRouter(
          '/character/:id/:name',
          child: (_, args) => CharacterPage(
            id: args.params['id'],
            title: args.params['name'],
          ),
        ),
        ModularRouter('/search', child: (_, args) => SearchPage())
      ];

  static Inject get to => Inject<CharactersModule>.of();
}
