import 'package:dio/dio.dart';
import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:find_marvel/app/modules/shared/constants/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

class CharactersBloc extends Disposable {
  BehaviorSubject _controller = BehaviorSubject();

  get stream => _controller.stream;
  get add => _controller.add;

  List<CharactersModel> array = [];

  fetch({int offset = 0}) async {
    try {
      final url =
          '${Constants.MARVEL_ENDPOINT}characters?ts=1&apikey=${Constants.MARVEL_PUBLIC_KEY}&hash=${Constants.MARVEL_MD5}&offset=$offset';

      final response = await Dio().get(url);

      response.data['data']['results'].forEach((item) {
        array.add(CharactersModel.fromJson(item));
      });

      _controller.add(array);
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {}
}
