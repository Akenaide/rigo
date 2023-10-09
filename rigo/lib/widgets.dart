import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rigo/models.dart';

dummy(String value) async {}

class DeckURLTextField extends StatefulWidget {
  const DeckURLTextField({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeckURLTextFieldState();
  }
}

class _DeckURLTextFieldState extends State<DeckURLTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (url) {
        context.read<Deck>().getCards(url, "images");
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ChangeNotifierProvider(
        create: (context) => Deck(),
        child: Column(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Input your url (encoredecks, decklog): ',
                ),
                SizedBox(width: 250, child: DeckURLTextField()),
              ],
            ),
            const Divider(),
            Expanded(child: Consumer<Deck>(
              builder: (context, deck, child) {
                List<Image> images = [];
                for (var card in deck.cards) {
                  images.add(Image.network(card.imageURL, fit: BoxFit.scaleDown,));
                }
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 400,
                      maxWidth: 500,
                      minHeight: 600,
                      maxHeight: 700,
                      ),
                  child: ListView(children: images),
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Deck>().getCards("images", "yay");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
