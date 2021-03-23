import 'dart:developer';

import 'package:rane_dms/components/lineDataStructure.dart';

class PFUList {
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

  List<PFU> getPFUList(var decodedData) {
    List data = decodedData;
    log(decodedData.toString());
    List<PFU> pfuList = [];
    //print(data.length);
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        PFU pfu = PFU();
        //  print("getting id");
        pfu.id = data[i]['_id'];
        // print("getting problem");
        pfu.problem = data[i]['problem'];
        //print("getting desc");
        pfu.problemDescription = data[i]['description'];
        // print("getting rd");
        pfu.raisingDept = data[i]['raisingDept'];
        pfu.rejectingReason = data[i]['rejectingReason'];
        pfu.deptResponsible = data[i]['deptResponsible'];
        pfu.closingRemarks = data[i]['closingRemarks'];
        pfu.status = data[i]['status'];
        pfu.acceptingPerson = data[i]['acceptingPerson'];
        Machines machine = Machines();
        machine.machineId = data[i]['machine']['_id'].toString();
        machine.machineName = data[i]['machine']['name'];
        machine.machineCode = data[i]['machine']['code'];
        pfu.machine = machine;
        pfu.effectingAreas = getEffectingAreas(
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
          pfu.rootCause = data[i]['rootCause'];
        } else {
          pfu.rootCause = " ";
        }
        if (data[i]["photoURL"] != null) {
          //print("rootcause: " + data[i]['rootCause']);
          pfu.photoURL = data[i]["photoURL"];
        } else {
          pfu.photoURL = "";
        }
        //  print("getting targetDate");
        if (data[i]['targetDate'] != null) {
          //  print("date: " + data[i]['targetDate']);
          pfu.targetDate = data[i]['targetDate'];
        } else {
          pfu.targetDate = "";
        }
        if (data[i]['action'] != null) {
          //  print("date: " + data[i]['targetDate']);
          pfu.action = data[i]['action'];
        } else {
          pfu.action = "";
        }
        if (data[i]['actualClosingDate'] != null) {
          //  print("date: " + data[i]['targetDate']);
          pfu.actualClosingTime = data[i]['actualClosingDate'];
        } else {
          pfu.actualClosingTime = "";
        }
        // print("getting rasing date");
        pfu.raisingDate = DateTime.parse(data[i]['raisingDate']);
        // print("getting rperson");
        pfu.raisingPerson = data[i]['raisingPerson']['username'];
        // print("getting line");
        pfu.lineName = data[i]['line']['name'];
        pfu.lineId = data[i]['line']['_id'].toString();

        pfuList.add(pfu);
      }
      return pfuList;
    } else {
      return [];
    }
  }
}

class PFU {
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
