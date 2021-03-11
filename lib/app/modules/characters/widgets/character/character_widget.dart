import 'package:find_marvel/app/modules/characters/characters_model.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final CharactersModel character;

  const CharacterWidget({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    '${character.thumbnail.path.replaceAll('http', 'https')}/portrait_incredible.${character.thumbnail.extension}'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    character.description.isEmpty
                        ? 'Sem descrição disponível'
                        : character.description,
                    style: TextStyle(fontSize: 16),
                    softWrap: true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
