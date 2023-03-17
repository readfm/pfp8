import 'package:flutter/material.dart';

class PFP8Details extends StatefulWidget {
  String src = '';
  PFP8Details(this.src, {super.key});

  @override
  State<PFP8Details> createState() => _PFP8DetailsState();
}

class _PFP8DetailsState extends State<PFP8Details> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.src),
      ),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: widget.src,
          child: Image.network(widget.src, width: width, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
