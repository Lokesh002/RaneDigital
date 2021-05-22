import 'dart:developer';

class FTA {
  String id;
  String description;
  String parentId;
  String parentDesc;
  String machineId;
  String machineCode;
  String machineName;
  String lineName;
  String lineId;
  String photo;
  FTA(
      {this.id,
      this.description,
      this.machineName,
      this.lineName,
      this.machineCode,
      this.machineId,
      this.parentDesc,
      this.parentId,
      this.lineId,
      this.photo});
}

class FTAList {
  List<FTA> getFTAList(decodedData) {
    List<FTA> ftaList = [];
    //log(decodedData.toString());
    List data = decodedData;
    for (int i = 0; i < data.length; i++) {
      FTA fta = FTA(
          description: data[i]['description'],
          id: data[i]['_id'],
          lineName: data[i]['line']['name'],
          machineCode: data[i]['machine']['code'],
          machineName: data[i]['machine']['name'],
          machineId: data[i]['machine']['_id'],
          lineId: data[i]['line']['_id'],
          parentId: data[i]['parent'] != null ? data[i]['parent']['_id'] : null,
          parentDesc: data[i]['parent'] != null
              ? data[i]['parent']['description']
              : null,
          photo: data[i]['photoURL'] != "" ? data[i]['photoURL'] : null);
      ftaList.add(fta);
    }
    return ftaList;
  }
}
