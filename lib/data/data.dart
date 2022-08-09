import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokedexData {
  static populateDex(offset) async {
    List pokemon = [];
    try {
      await getPokeData(20, offset).then((dataApi) async {
        print(dataApi["results"].length);
        for (var i = 0; i < dataApi["results"].length; i++) {
          await getPokeDetails(dataApi["results"][i]["url"]).then((details) {
            Map<String, dynamic> newpkm = Map();
            List types = [];
            newpkm["nome"] = details["name"];
            newpkm["sprite"] = details["sprites"]["other"]["official-artwork"]
                ["front_default"];
            for (var i = 0; i < details["types"].length; i++) {
              types.add(details["types"][i]["type"]["name"]);
            }
            newpkm["types"] = types;
            pokemon.add(newpkm);
          });
        }
        return pokemon;
      });
      return pokemon;
    } catch (e) {
      print("Error: $e");
    }
  }

  static populateDexSearch(offset, nome) async {
    List pokemon = [];
    RegExp reg = RegExp('D[a-zA-Z0-9]');
    try {
      await getPokeData(10000, 0).then((dataApi) async {
        print(dataApi["results"].length);
        for (var i = 0; i < dataApi["results"].length; i++) {
          if (dataApi["results"][i]["name"].startsWith(nome)) {
            await getPokeDetails(dataApi["results"][i]["url"]).then((details) {
              Map<String, dynamic> newpkm = Map();
              List types = [];
              newpkm["nome"] = details["name"];
              newpkm["sprite"] = details["sprites"]["other"]["official-artwork"]
                  ["front_default"];
              for (var i = 0; i < details["types"].length; i++) {
                types.add(details["types"][i]["type"]["name"]);
              }
              newpkm["types"] = types;
              pokemon.add(newpkm);
            });
          }
        }
        return pokemon;
      });
      return pokemon;
    } catch (e) {
      print("Error: $e");
    }
  }

  static getPokeData(limit, offset) async {
    var _url = "https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset";
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(_url),
      );
      return jsonDecode(response.body);
    } catch (e) {
      print("Erro: " + e.toString());
      return null;
    }
  }

  static getPokeDetails(url) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
      //print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print("Erro: " + e.toString());
      return null;
    }
  }
}
