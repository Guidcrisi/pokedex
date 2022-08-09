import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex/data/data.dart';
import 'package:pokedex/main.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/ui/pokemon_page.dart';

class PesquisaPage extends StatefulWidget {
  const PesquisaPage({Key? key}) : super(key: key);

  @override
  State<PesquisaPage> createState() => _PesquisaPageState();
}

class _PesquisaPageState extends State<PesquisaPage> {
  TextEditingController pesquisaController = TextEditingController();
  bool isLoading = false;
  int offset = 0;
  List pokemon = [];
  @override
  void initState() {
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await PokedexData.populateDexSearch(offset, pesquisaController.text)
          .then((pkmList) {
        print(pkmList);
        setState(() {
          pokemon = pkmList;
        });
        for (var i = 0; i < pokemon.length; i++) {
          print(pokemon[i]["nome"]);
          print(pokemon[i]["types"]);
        }
      });
    } catch (e) {
      print("Error home: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  createTile(nome, sprite, types) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonPage(
                    nome, "https://pokeapi.co/api/v2/pokemon/$nome")));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        width: double.maxFinite,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0, color: app.vermelho),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 7,
                offset: const Offset(0, 5),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            sprite == null
                ? Image.asset(
                    "img/no_image.png",
                    width: 100,
                  )
                : Image.network(
                    sprite,
                    width: 100,
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nome,
                  style: const TextStyle(fontSize: 22),
                ),
                const Divider(
                  height: 10,
                ),
                SizedBox(
                    height: 80,
                    width: 100,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: types.length,
                        itemBuilder: ((context, index) {
                          Color cor = Colors.grey;
                          switch (types[index]) {
                            case "grass":
                              cor = Colors.green;
                              break;
                            case "normal":
                              cor = const Color(0xFFA4ACAF);
                              break;
                            case "bug":
                              cor = const Color(0xFF729F3F);
                              break;
                            case "fairy":
                              cor = const Color(0xFFFDB9E9);
                              break;
                            case "fire":
                              cor = const Color(0xFFFD7D24);
                              break;
                            case "ghost":
                              cor = const Color(0xFF7B62A3);
                              break;
                            case "ground":
                              cor = const Color(0xFFF7DE3F);
                              break;
                            case "dragon":
                              cor = const Color(0xFFF16E57);
                              break;
                            case "psychic":
                              cor = const Color(0xFFF366B9);
                              break;
                            case "steel":
                              cor = const Color(0xFF616161);
                              break;
                            case "dark":
                              cor = const Color(0xFF707070);
                              break;
                            case "electric":
                              cor = const Color(0xFFD56723);
                              break;
                            case "fighting":
                              cor = const Color(0xFFD56723);
                              break;
                            case "flying":
                              cor = const Color(0xFF3DC7EF);
                              break;
                            case "ice":
                              cor = const Color(0xFF616161);
                              break;
                            case "poison":
                              cor = const Color(0xFFB97FC9);
                              break;
                            case "rock":
                              cor = const Color(0xFF616161);
                              break;
                            case "water":
                              cor = const Color(0xFF4592C4);
                              break;
                            default:
                              cor = Colors.grey;
                          }
                          return Container(
                            height: 20,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                                color: cor,
                                border:
                                    Border.all(width: 0, color: app.vermelho),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 5),
                                  )
                                ]),
                            child: Text(
                              types[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          );
                        })))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterDex"),
        centerTitle: true,
        backgroundColor: app.vermelho,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text("Olá mundo!"),
                        content: const Text(
                            "Este app foi desenvolvido por Guilherme Crisi usando Flutter e a PokeAPI 🥰"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Okay",
                                style: TextStyle(color: app.vermelho),
                              ))
                        ],
                      );
                    });
              },
              icon: const Icon(FontAwesomeIcons.ellipsis))
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: app.vermelho,
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Estamos procurando seu pokemon... 🤔",
                    style: TextStyle(
                        color: app.vermelho, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    width: double.maxFinite,
                    color: app.vermelho,
                    child: TextField(
                      controller: pesquisaController,
                      decoration: InputDecoration(
                          hintText: "Nome do pokemon",
                          suffixIcon: IconButton(
                            onPressed: () {
                              getData();
                            },
                            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                          ),
                          filled: true,
                          focusColor: Colors.white,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pokemon.length,
                      itemBuilder: (context, index) {
                        return createTile(pokemon[index]["nome"],
                            pokemon[index]["sprite"], pokemon[index]["types"]);
                      }),
                ],
              ),
            ),
    );
  }
}
