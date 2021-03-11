import 'package:dio/dio.dart';
import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:find_marvel/app/modules/shared/constants/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharacterBloc extends Disposable {
  fetch(String id) async {
    try {
      final url =
          '${Constants.MARVEL_ENDPOINT}characters/$id?ts=1&apikey=${Constants.MARVEL_PUBLIC_KEY}&hash=${Constants.MARVEL_MD5}';

      final response = await Dio().get(url);

      final array = response.data['data']['results'];

      CharactersModel retorno = CharactersModel.fromJson(array[0]);
      return (retorno != null) ? retorno : null;
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {}
}
