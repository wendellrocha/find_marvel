import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:find_marvel/app/app_module.dart';
import 'package:find_marvel/app/modules/characters/pages/search/search_bloc.dart';
import 'package:find_marvel/app/modules/characters/characters_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(CharactersModule());
  SearchBloc bloc;

  // setUp(() {
  //     bloc = CharactersModule.to.get<SearchBloc>();
  // });

  // group('SearchBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<SearchBloc>());
  //   });
  // });
}
