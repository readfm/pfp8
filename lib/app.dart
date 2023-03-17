import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pfp8/view.dart';

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

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  double size = 64;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          thumbColor: Colors.white,
          min: 32,
          max: 480,
          value: size,
          onChanged: (value) {
            setState(() {
              size = value;
            });
          },
        ),
      ),
      body: GestureDetector(
        onScaleStart: (details) {
          _baseScaleFactor = _scaleFactor;
        },
        onScaleUpdate: (details) {
          setState(() {
            final scale =
                details.scale > 1 ? details.scale : (details.scale * -2);
            //size = max(min(size + scale, 320), 32);
            print('${details.scale}  $scale');
          });
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width ~/ size,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => buildRow(index),
          itemCount: _list.length,
        ),
      ),
    );
  }

  Widget buildRow(int index) {
    final img = _list[index];
    final tile = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PFP8Details(
              img,
              key: ValueKey(img),
            ),
          ),
        );
      },
      child: Hero(
        tag: img,
        child: CircleAvatar(
          radius: size / 2,
          backgroundImage: NetworkImage(img),
        ),
      ),
    );
    Draggable draggable = LongPressDraggable<String>(
      data: img,
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
      feedback: Opacity(
        opacity: 0.8,
        child: tile,
      ),
    );

    return DragTarget<String>(
      onWillAccept: (track) {
        if (track == null && _list.indexOf(track!) == index) return false;

        setState(() {
          int currentIndex = _list.indexOf(track);
          _list.remove(track);
          _list.insert(index, track);
        });
        return true;
      },
      onAccept: (track) {},
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
