import 'dart:io';

import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'character_bloc.dart';

class CharacterPage extends StatefulWidget {
  final String title;
  final String id;
  const CharacterPage({Key key, this.title = "Character", this.id})
      : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final _characterBloc = Modular.get<CharacterBloc>();
  var _character;

  @override
  void initState() {
    _character = _characterBloc.fetch(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _character,
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                    ),
                  );
                }

                CharactersModel character = snapshot.data;

                return character != null
                    ? NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverAppBar(
                              title: Text(
                                widget.title,
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0.5, 0.5),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              expandedHeight: 500.0,
                              floating: false,
                              pinned: true,
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 0.0,
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.5,
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              iconTheme: IconThemeData(
                                color: Colors.white,
                              ),
                              leading: Container(
                                color: Colors.black12,
                                child: IconButton(
                                  onPressed: () {
                                    Modular.to.pop();
                                  },
                                  icon: Icon(
                                    kIsWeb
                                        ? Icons.arrow_back
                                        : Platform.isAndroid
                                            ? Icons.arrow_back
                                            : Icons.arrow_back_ios,
                                  ),
                                ),
                              ),
                              brightness:
                                  MediaQuery.of(context).platformBrightness,
                              flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: true,
                                  collapseMode: CollapseMode.parallax,
                                  background: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${character.thumbnail.path}/detail.${character.thumbnail.extension}'),
                                      ),
                                    ),
                                  )),
                            ),
                          ];
                        },
                        body: _body(context, character),
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, CharactersModel character) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            character.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            character.description.isEmpty
                ? 'Sem descrição disponível'
                : character.description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            'Comics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (character.comics.items.length > 0)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5),
                itemCount: character.comics.items.length,
                itemBuilder: (_, i) {
                  return Container(
                    child: Text(
                      character.comics.items[i].name.isEmpty
                          ? 'Sem comics disponíveis'
                          : character.comics.items[i].name,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            )
          else
            Text(
              'Sem comics disponíveis',
              style: TextStyle(fontSize: 16),
            )
        ],
      ),
    );
  }
}
