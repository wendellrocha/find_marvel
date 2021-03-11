import 'package:dio/dio.dart';
import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:find_marvel/app/modules/shared/constants/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchBloc extends Disposable {
  fetch(String name) async {
    try {
      final url =
          '${Constants.MARVEL_ENDPOINT}characters?ts=1&apikey=${Constants.MARVEL_PUBLIC_KEY}&hash=${Constants.MARVEL_MD5}&nameStartsWith=$name';

      final response = await Dio().get(url);

      final array = response.data['data']['results'];

      List<CharactersModel> retorno = array
          .map<CharactersModel>((json) => CharactersModel.fromJson(json))
          .toList();
      return (retorno.length > 0) ? retorno : null;
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {}
}
