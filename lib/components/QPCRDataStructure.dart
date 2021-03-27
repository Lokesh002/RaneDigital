import 'dart:developer';

import 'package:rane_dms/components/lineDataStructure.dart';

class QPCRList {
  String getEffectingAreas(
      {bool P, bool Q, bool C, bool D, bool S, bool M, bool E}) {
    String query = '';
    if (P) {
      query += 'P ';
    }
    if (Q) {
      query += 'Q ';
    }
    if (C) {
      query += 'C ';
    }
    if (D) {
      query += 'D ';
    }
    if (S) {
      query += 'S ';
    }
    if (M) {
      query += 'M ';
    }
    if (E) {
      query += 'E';
    }
    return query;
  }

  List<QPCR> getQPCRList(var decodedData) {
    List data = decodedData;
    log(decodedData.toString());
    List<QPCR> QPCRList = [];
    //print(data.length);
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        QPCR qpcr = QPCR();
        //  print("getting id");
        qpcr.id = data[i]['_id'];
        // print("getting problem");
        qpcr.problem = data[i]['problem'];
        //print("getting desc");
        qpcr.problemDescription = data[i]['description'];
        // print("getting rd");
        qpcr.raisingDept = data[i]['raisingDept'];
        qpcr.rejectingReason = data[i]['rejectingReason'];
        qpcr.deptResponsible = data[i]['deptResponsible'];
        qpcr.closingRemarks = data[i]['closingRemarks'];
        qpcr.status = data[i]['status'];
        qpcr.acceptingPerson = data[i]['acceptingPerson'];
        Machines machine = Machines();
        machine.machineId = data[i]['machine']['_id'].toString();
        machine.machineName = data[i]['machine']['name'];
        machine.machineCode = data[i]['machine']['code'];
        qpcr.machine = machine;
        qpcr.effectingAreas = getEffectingAreas(
            P: data[i]['impactProd'],
            Q: data[i]['impactQual'],
            C: data[i]['impactCost'],
            D: data[i]['impactDisp'],
            S: data[i]['impactSafe'],
            M: data[i]['impactMora'],
            E: data[i]['impactEnvi']);
        print("getting rootcause");
        if (data[i]['rootCause'] != null) {
          //print("rootcause: " + data[i]['rootCause']);
          qpcr.rootCause = data[i]['rootCause'];
        } else {
          qpcr.rootCause = " ";
        }
        if (data[i]["photoURL"] != null) {
          //print("rootcause: " + data[i]['rootCause']);
          qpcr.photoURL = data[i]["photoURL"];
        } else {
          qpcr.photoURL = "";
        }
        //  print("getting targetDate");
        if (data[i]['targetDate'] != null) {
          //  print("date: " + data[i]['targetDate']);
          qpcr.targetDate = data[i]['targetDate'];
        } else {
          qpcr.targetDate = "";
        }
        if (data[i]['action'] != null) {
          //  print("date: " + data[i]['targetDate']);
          qpcr.action = data[i]['action'];
        } else {
          qpcr.action = "";
        }
        if (data[i]['actualClosingDate'] != null) {
          //  print("date: " + data[i]['targetDate']);
          qpcr.actualClosingTime = data[i]['actualClosingDate'];
        } else {
          qpcr.actualClosingTime = "";
        }
        // print("getting rasing date");
        qpcr.raisingDate = DateTime.parse(data[i]['raisingDate']);
        // print("getting rperson");
        qpcr.raisingPerson = data[i]['raisingPerson']['username'];
        // print("getting line");
        qpcr.lineName = data[i]['line']['name'];
        qpcr.lineId = data[i]['line']['_id'].toString();

        QPCRList.add(qpcr);
      }
      return QPCRList;
    } else {
      return [];
    }
  }
}

class QPCR {
  String id;
  String action;
  String problem;
  String problemDescription;
  String raisingDept;
  String deptResponsible;
  int status;
  DateTime raisingDate;
  String actualClosingTime;
  Machines machine;
  String lineName;
  String lineId;
  String raisingPerson;
  String targetDate;
  String rootCause;
  String photoURL;
  String acceptingPerson;
  String effectingAreas;
  String rejectingReason;
  String closingRemarks;
}
