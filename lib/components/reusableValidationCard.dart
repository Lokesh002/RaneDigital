import 'package:flutter/material.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';

import 'QPCRDataStructure.dart';

class ValidationCard extends StatefulWidget {
  final QPCR qpcr2;
  final int index;
  ValidationCard({this.qpcr2, this.index});
  @override
  _ValidationCardState createState() => _ValidationCardState();
}

class _ValidationCardState extends State<ValidationCard> {
  var specController = TextEditingController();
  var remarksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isValid;
  void _handleRadioValueChange(bool value) {
    setState(() {
      isValid = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remarksController.text = globalQpcr.validationReports[widget.index].remarks;

    specController.text =
        globalQpcr.validationReports[widget.index].specification;

    isValid = globalQpcr.validationReports[widget.index].isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cause ${widget.index + 1}'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.qpcr2.validationReports[widget.index].cause),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (val) =>
                      val.length < 1 ? 'Enter Specification' : null,
                  controller: specController,
                  decoration: InputDecoration(labelText: 'Specification')),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              new Radio(
                value: true,
                groupValue: isValid,
                activeColor: Colors.blue,
                onChanged: (v) {
                  _handleRadioValueChange(v);
                },
              ),
              Text('Valid'),
              SizedBox(
                width: 15,
              ),
              new Radio(
                value: false,
                activeColor: Colors.blue,
                groupValue: isValid,
                onChanged: (v) {
                  _handleRadioValueChange(v);
                },
              ),
              Text('Not Valid')
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (val) => val.length < 1 ? 'Enter Remarks' : null,
                  controller: remarksController,
                  decoration: InputDecoration(labelText: 'Remarks')),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      globalQpcr.validationReports[widget.index].specification =
                          specController.text;
                      globalQpcr.validationReports[widget.index].isValid =
                          isValid;
                      globalQpcr.validationReports[widget.index].remarks =
                          remarksController.text;
                      Networking networking = Networking();
                      QPCRList qpcrList = QPCRList();
                      var data = qpcrList.QpcrToMap(globalQpcr);

                      var d = await networking
                          .postData('QPCR/QPCRSave', {"newQPCR": data});
                      globalQpcr = qpcrList.getQPCR(d);
                    }
                  },
                  child: Text('Save'),
                )),
          ],
        ),
      ),
    );
  }
}
