import 'package:find_marvel/app/modules/characters/characters_bloc.dart';
import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:find_marvel/app/modules/characters/widgets/character/character_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersPage extends StatefulWidget {
  final String title;
  const CharactersPage({Key key, this.title = "Characters"}) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final _charactersBloc = Modular.get<CharactersBloc>();
  ScrollController _scrollController = new ScrollController();
  int offset = 0;
  bool isLoading = false;

  @override
  void initState() {
    _loadBloc();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
          offset += 20;
          _loadBloc();
        });
      }
    });
    super.initState();
  }

  _loadBloc() {
    _charactersBloc.fetch(offset: offset);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Modular.link.pushNamed('/search');
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _charactersBloc.stream,
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                    ),
                  );
                }

                List<CharactersModel> characters = snapshot.data;
                return characters.isNotEmpty
                    ? ListView.builder(
                        controller: _scrollController,
                        itemCount: characters.length + 1,
                        itemBuilder: (_, i) {
                          if (i == characters.length) {
                            isLoading = true;
                            return Center(
                              child: Container(
                                child: CupertinoActivityIndicator(
                                  animating: true,
                                ),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              Modular.link.pushNamed(
                                  '/character/${characters[i].id}/${characters[i].name}');
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: CharacterWidget(character: characters[i]),
                            ),
                          );
                        },
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
