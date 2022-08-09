import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex/data/data.dart';
import 'package:pokedex/main.dart';
import 'package:flutter/material.dart';

class PokemonPage extends StatefulWidget {
  String nome;
  String url;
  PokemonPage(this.nome, this.url);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  bool isLoading = false;
  Map pokemon = Map();
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await PokedexData.getPokeDetails(widget.url).then((details) {
        setState(() {
          pokemon = details;
        });
        print(pokemon);
      });
    } catch (e) {
      print("Error: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
        centerTitle: true,
        backgroundColor: app.vermelho,
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
      backgroundColor: Colors.white,
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
                    "Isso pode demorar um pouco😅",
                    style: TextStyle(
                        color: app.vermelho, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: pokemon["sprites"]["other"]["official-artwork"]
                                ["front_default"] ==
                            null
                        ? Image.asset(
                            "img/no_image.png",
                            width: 300,
                          )
                        : Image.network(
                            pokemon["sprites"]["other"]["official-artwork"]
                                ["front_default"],
                            width: 300,
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 35, 15, 15),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(100.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 7,
                            offset: Offset(0, 5),
                          )
                        ],
                        color: app.vermelho),
                    width: double.maxFinite,
                    height: 550,
                    child: Column(
                      children: [
                        Text(
                          "Nº${pokemon["order"].toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.rulerVertical,
                                  color: Colors.white,
                                ),
                                Text("Altura: ${pokemon["height"].toString()}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.weightScale,
                                  color: Colors.white,
                                ),
                                Text("Peso: ${pokemon["weight"].toString()}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24))
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        const Text("Tipos",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                            height: 80,
                            width: 150,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: pokemon["types"].length,
                                itemBuilder: ((context, index) {
                                  Color cor = Colors.grey;
                                  switch (pokemon["types"][index]["type"]
                                      ["name"]) {
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
                                    height: 30,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: cor,
                                        border: Border.all(
                                            width: 0, color: app.vermelho),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 0.5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 5),
                                          )
                                        ]),
                                    child: Text(
                                      pokemon["types"][index]["type"]["name"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }))),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        const Text("Status",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.heartPulse,
                                  color: Colors.white,
                                ),
                                Text("HP: ${pokemon["stats"][0]["base_stat"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.gaugeHigh,
                                  color: Colors.white,
                                ),
                                Text(
                                    "Speed: ${pokemon["stats"][5]["base_stat"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.hammer,
                                  color: Colors.white,
                                ),
                                Text(
                                    "Attack: ${pokemon["stats"][1]["base_stat"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.shield,
                                  color: Colors.white,
                                ),
                                Text(
                                    "Defense: ${pokemon["stats"][2]["base_stat"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.hammer,
                                  color: Colors.white,
                                ),
                                Text(
                                    "Sp. Attack: ${pokemon["stats"][3]["base_stat"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.shield,
                                  color: Colors.white,
                                ),
                                Text(
                                    "Sp. Defense: ${pokemon["stats"][4]["base_stat"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
