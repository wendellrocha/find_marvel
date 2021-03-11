import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:find_marvel/app/modules/characters/pages/search/search_bloc.dart';
import 'package:find_marvel/app/modules/characters/widgets/character/character_widget.dart';
import 'package:find_marvel/app/modules/shared/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key key, this.title = "Search"}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchResults;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: TextFieldWidget(
              hint: 'Search',
              label: 'Search',
              onChanged: (String value) {
                if (value.length > 3) {
                  _searchResults = Modular.get<SearchBloc>().fetch(value);
                  setState(() {
                    show = true;
                  });
                }
              },
            ),
          ),
          if (show)
            Expanded(
              child: FutureBuilder(
                future: _searchResults,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        animating: true,
                      ),
                    );
                  }

                  List<CharactersModel> results = snapshot.data;
                  return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () {
                          Modular.link.pushNamed(
                              '/character/${results[i].id}/${results[i].name}');
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: CharacterWidget(character: results[i])),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
