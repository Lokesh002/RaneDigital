import 'package:flutter/material.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';

class ReusableWhyWhy extends StatefulWidget {
  final QPCR qpcr;
  final int index;
  ReusableWhyWhy({this.index, this.qpcr});
  @override
  _ReusableWhyWhyState createState() => _ReusableWhyWhyState();
}

class _ReusableWhyWhyState extends State<ReusableWhyWhy> {
  var textController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.qpcr.validationReports[widget.index].remarks;


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
              child: TextFormField(
                  validator: (val) =>
                      val.length < 1 ? 'Enter Why' : null,
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Why')),
            ),

          ],
        ),
      ),
    );
  }
}
