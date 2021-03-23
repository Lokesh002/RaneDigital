import 'package:rane_dms/components/networking.dart';

class Line {
  String lineId;
  String lineName;
  List<Machines> machines;
}

class Machines {
  String machineId;
  String machineName;
  String machineCode;
}

class LineDataStructure {
  Future<List<Line>> getLines() async {
    Networking networking = Networking();
    var data = await networking.getData("Line/getAllLines");

    var lineList = _getData(data);

    return lineList;
  }

  _getData(var lineDecodedData) {
    List<Line> lineList = [];
    List lineData = lineDecodedData;
    if (lineData.isNotEmpty) {
      for (int i = 0; i < lineData.length; i++) {
        Line line = Line();
        line.lineId = lineData[i]["_id"];
        line.lineName = lineData[i]["name"];
        line.machines = [];
        List machineData = lineData[i]["machine"];
        for (int j = 0; j < machineData.length; j++) {
          Machines machine = Machines();
          machine.machineId = machineData[j]["_id"];
          machine.machineCode = machineData[j]["code"];
          machine.machineName = machineData[j]["name"];

          line.machines.add(machine);
        }
        lineList.add(line);
      }

      return lineList;
    } else {}
  }
}
