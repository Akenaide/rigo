import 'package:flutter/foundation.dart';
import 'package:rigo/services.dart';

@immutable
class MyCard {
  final String imageURL;

  const MyCard(this.imageURL);
}

class Deck extends ChangeNotifier {
  final List<MyCard> _cards = [];
  final ProxyMaker pm = ProxyMaker();

  List<MyCard> get cards => _cards;

  getCards(String url, String action) {
    pm.getImages(url).then((cards) {
      for (var cardURL in cards) {
        _cards.add(MyCard(cardURL));
      }
      notifyListeners();
    });
  }
}
