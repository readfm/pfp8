import 'package:flutter/material.dart';

import 'models/track.dart';

class PFP8App extends StatefulWidget {
  const PFP8App({super.key});

  @override
  State<PFP8App> createState() => _PFP8AppState();
}

class _PFP8AppState extends State<PFP8App> {
  List<String> _list = [
    "https://i.imgur.com/vb5pZi2.png",
    "https://i.imgur.com/ITA44Ei.png",
    "https://i.imgur.com/MuZe4kL.png",
    "https://i.imgur.com/zejK6Qj.png",
    "https://i.imgur.com/XtGBqu3.png",
    'https://i.imgur.com/EAkXGZZ.png',
    'https://i.imgur.com/d2YAiW2.png',
    'https://i.imgur.com/omc8sa6.png',
    'https://i.imgur.com/SH43JSf.png',
    'https://i.imgur.com/N248epX.png',
    'https://i.imgur.com/9sOrmmO.jpeg',
    'https://i.imgur.com/MT7RGjC.png',
    'https://i.imgur.com/n0LJHDz.png',
    'https://i.imgur.com/93LSl6U.png',
    'https://i.imgur.com/AsGGH2t.png',
    'https://i.imgur.com/zaaU9eq.png',
    'https://i.imgur.com/PWpEq9D.gif',
    'https://i.imgur.com/Sk43jEO.png',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = 138;
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width ~/ size,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) => buildRow(index),
        itemCount: _list.length,
      ),
    );
  }

  Widget buildRow(int index) {
    final track = _list[index];
    final tile = CircleAvatar(
      radius: 64,
      backgroundImage: NetworkImage(track),
    );
    Draggable draggable = LongPressDraggable<String>(
      data: track,
      maxSimultaneousDrags: 1,
      child: tile,
      childWhenDragging: //Container() ??
          Opacity(
        opacity: 0.5,
        child: tile,
      ),
      onDragStarted: () {
        print('drag');
      },
      feedback: tile,
    );

    return DragTarget<String>(
      onWillAccept: (track) {
        if (track == null) return false;
        return _list.indexOf(track) != index;
      },
      onAccept: (track) {
        setState(() {
          int currentIndex = _list.indexOf(track);
          _list.remove(track);
          _list.insert(currentIndex > index ? index : index, track);
        });
      },
      builder: (
        BuildContext context,
        candidateData,
        List<dynamic> rejectedData,
      ) {
        return AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: candidateData.isEmpty
              ? draggable
              : Opacity(
                  opacity: 0.8,
                  child: tile,
                ),
        );
      },
    );
  }
}
