// ignore_for_file: prefer_const_constructors

import 'package:crypto/affiliateconfig33.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:logger/logger.dart';
import "dart:collection";

class AffiliateTree33 extends StatefulWidget {
  const AffiliateTree33({
    Key? key,
    required this.json,
    required this.storejson,
  }) : super(key: key);

  final Map<String, List<Map<String, Object>>> json;
  final Map<String, List<Map<String, Object>>> storejson;

  @override
  AffiliateTree33State createState() => AffiliateTree33State();
}

class AffiliateTree33State extends State<AffiliateTree33> {
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  final Graph graph = Graph()..isTree = true;
  var l = Logger();
  List<String> listofuserid = [];
  List<String> result = [];

  @override
  void initState() {
    var edges = widget.json['edges']!;
    for (var element in edges) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      listofuserid.add(fromNodeId.toString());
      listofuserid.add(toNodeId.toString());
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId),
          paint: Paint()..color = Colors.blue);
    }
    result = LinkedHashSet<String>.from(listofuserid).toList();

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
    super.initState();
  }

  Widget rectangleWidget(a) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(a.toString()),
                    ],
                  ),
                ));
      },
      onTap: () async {
        var response = await AffiliateConfig33.getreferraldata(a.toString());
        l.e(response);

        var edges = response['edges'];
        for (var element in edges) {
          var fromNodeId = element['from'];
          var toNodeId = element['to'];
          listofuserid.add(fromNodeId.toString());
          listofuserid.add(toNodeId.toString());
          graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId),
              paint: Paint()..color = Colors.red);
        }
        setState(() {});
        l.w(a);
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue),
          child: Text(
            a.toString().substring(36),
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: Theme.of(context).iconTheme.size,
            ),
          ),
          title: Text(
            'Affiliate Pattern',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      var a = node.key!.value;
                      return rectangleWidget(a);
                    },
                  )),
            ),
          ],
        ));
  }
}
