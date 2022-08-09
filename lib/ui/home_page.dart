import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex/data/data.dart';
import 'package:pokedex/main.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/ui/pesquisa_page.dart';
import 'package:pokedex/ui/pokemon_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  int offset = 0;
  List pokemon = [];
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
      await PokedexData.populateDex(offset).then((pkmList) {
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
            Image.network(
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: app.vermelho,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PesquisaPage()));
        },
        child: const Icon(FontAwesomeIcons.magnifyingGlass),
      ),
      drawer: sideBar(context),
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
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pokemon.length,
                      itemBuilder: (context, index) {
                        return createTile(pokemon[index]["nome"],
                            pokemon[index]["sprite"], pokemon[index]["types"]);
                      }),
                  const Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: app.vermelho),
                      onPressed: () {
                        setState(() {
                          offset += 20;
                        });
                        getData();
                      },
                      child: const Text("Carregar mais! 😡")),
                  const Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
    );
  }

  Widget sideBar(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(color: app.vermelho),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Divider(
                height: 35,
                color: Colors.transparent,
              ),
              const Divider(
                height: 15,
                color: Colors.white,
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.house,
                  color: Colors.white,
                ),
                title: const Text(
                  "Início",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              const Divider(color: Colors.white, height: 10),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.github,
                  color: Colors.white,
                ),
                title: const Text(
                  "Github",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  launchUrl(Uri.parse("https://github.com/Guidcrisi"));
                },
              ),
              const Divider(
                color: Colors.white,
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.mugSaucer,
                  color: Colors.white,
                ),
                title: const Text(
                  "Buy me a coffe",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  launchUrl(
                      Uri.parse("https://www.buymeacoffee.com/guidcrisi"));
                },
              ),
              const Divider(
                color: Colors.white,
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.link,
                  color: Colors.white,
                ),
                title: const Text(
                  "PokeAPI",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  launchUrl(Uri.parse("https://pokeapi.co/"));
                },
              ),
              const Divider(color: Colors.white, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
