import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class MethodFishBoneScreen extends StatefulWidget {
  QPCR qpcr;
  MethodFishBoneScreen(this.qpcr);
  @override
  _MethodFishBoneScreenState createState() => _MethodFishBoneScreenState();
}

class _MethodFishBoneScreenState extends State<MethodFishBoneScreen> {
  QPCR qpcr2 = null;
  var nameTECs = <TextEditingController>[];
  var cards = <Card>[];
  void createCard() {
    var nameController = TextEditingController();

    nameTECs.add(nameController);
    cards.add(Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Cause ${cards.length + 1}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Caused by method')),
          ),
        ],
      ),
    ));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //cards.add(createCard());
    getCards();
  }

  void getCards() {
    qpcr2 = globalQpcr;
    log(qpcr2.fishBoneAnalysis.method.length.toString());
    if (qpcr2.fishBoneAnalysis.method.length > 0) {
      for (int i = 0; i < qpcr2.fishBoneAnalysis.method.length; i++) {
        var nameController = TextEditingController();
        nameController.text = qpcr2.fishBoneAnalysis.method[i];
        Card card = Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Cause ${cards.length + 1}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Cause by method')),
              ),
            ],
          ),
        );

        nameTECs.add(nameController);
        cards.add(card);
      }
    } else {
      var nameController = TextEditingController();
      nameTECs.add(nameController);
      cards = [
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Cause ${cards.length + 1}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Cause by method')),
              ),
            ],
          ),
        )
      ];
    }
    //setState(() {});
  }

  Future _onDone() async {
    List<String> entries = [];
    for (int i = 0; i < cards.length; i++) {
      if (nameTECs[i].text != "" && nameTECs[i].text != null) {
        var name = nameTECs[i].text;
        entries.add(name);
      }
    }
    qpcr2.fishBoneAnalysis.method = entries;

    Networking networking = Networking();
    QPCRList qpcrList = QPCRList();
    var data = qpcrList.QpcrToMap(qpcr2);
    //print(data);
    var d = await networking.postData('QPCR/QPCRSave', {"newQPCR": data});

    qpcr2 = qpcrList.getQPCR(d);
    globalQpcr = qpcr2;
  }

  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.screenHeight * 1,
                      horizontal: screenSize.screenWidth * 2),
                  child: cards[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
                child: Text('add new'), onPressed: () => createCard()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Text('Save'),
          onPressed: () async {
            await _onDone();
          }),
    );
  }
}
