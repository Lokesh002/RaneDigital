import 'dart:developer';

import 'package:rane_dms/components/lineDataStructure.dart';

class QPCRList {
  /////////////ONE QPCR  ONLY
  QPCR getQPCR(var data) {
    QPCR qpcr = new QPCR();
    qpcr.qpcrNo = data['QPCRNo'];
    qpcr.problemDescription = data['problemDescription'];
    qpcr.id = data['_id'];
    qpcr.totalLotQty = data['totalLotQty'];

    qpcr.supplierInvoiceNumber = data['supplierInvoiceNumber'];
    qpcr.complaintImpactAreas.safetyImpact =
        data['complaintImpactAreas']['Safety'];
    qpcr.complaintImpactAreas.visualImpact =
        data['complaintImpactAreas']['Visual'];
    qpcr.complaintImpactAreas.fitmentImpact =
        data['complaintImpactAreas']['Fitment'];
    qpcr.complaintImpactAreas.functionalImpact =
        data['complaintImpactAreas']['Functional'];
    qpcr.complaintImpactAreas.otherImpact =
        data['complaintImpactAreas']['Others'];
    qpcr.defectiveQuantity = data['defectiveQuantity'];
    qpcr.raisingDept = data['raisingDept'];
    qpcr.deptResponsible = data["deptResponsible"];
    qpcr.okPhotoURL = data['OKPhotoURL'];
    qpcr.ngPhotoURL = data['NGPhotoURL'];
    qpcr.status = data['status'];
    qpcr.targetSubmittingDate = data['targetSubmittingDate'] != null
        ? DateTime.parse(data['targetSubmittingDate'])
        : null;
    qpcr.rejectingReason = data['rejectingReason'];
    qpcr.interimContainmentAction = data['interimContainmentAction'];

    if (data['segregationDetails'] != null) {
      qpcr.segregationDetails = [];

      for (int j = 0; j < data['segregationDetails'].length; j++) {
        SegregationDetails segregationDetails = SegregationDetails();
        segregationDetails.partsCheckedAt =
            data['segregationDetails'][j]['partsCheckedAt'];
        segregationDetails.occurringDate =
            DateTime.parse(data['segregationDetails'][j]['occurringDate']);
        segregationDetails.segregationDate =
            DateTime.parse(data['segregationDetails'][j]['segregationDate']);
        segregationDetails.okQty = data['segregationDetails'][j]['OKqty'];
        segregationDetails.rejectedQtyBeforeRework =
            data['segregationDetails'][j]['RejectedQtyBeforeRework'];
        segregationDetails.sapQtyToBeChecked =
            data['segregationDetails'][j]['SAPqtyToBeChecked'];
        segregationDetails.reworkQty =
            data['segregationDetails'][j]['reworkQty'];
        segregationDetails.reworkOKQty =
            data['segregationDetails'][j]['reworkOKQty'];
        segregationDetails.remarks = data['segregationDetails'][j]['remarks'];
        qpcr.segregationDetails.add(segregationDetails);
      }
    }
    if (data['whyWhyAnalysis'] != null) {
      qpcr.whyWhyAnalysis = [];

      for (int j = 0; j < data['whyWhyAnalysis'].length; j++) {
        WhyWhyAnalysis whyWhyAnalysis = WhyWhyAnalysis();
        whyWhyAnalysis.problem = data['whyWhyAnalysis'][j]['problem'];

        whyWhyAnalysis.occurrenceWhyWhy = new List<String>.from(
            data['whyWhyAnalysis'][j]['occurrenceWhyWhy']);
        whyWhyAnalysis.detectionWhyWhy =
            new List<String>.from(data['whyWhyAnalysis'][j]['detectionWhyWhy']);
        qpcr.whyWhyAnalysis.add(whyWhyAnalysis);
      }
    }

    if (data['fishBoneAnalysis'] != null) {
      qpcr.fishBoneAnalysis = FishBone();
      qpcr.fishBoneAnalysis.man =
          new List<String>.from(data['fishBoneAnalysis']['man']);

      qpcr.fishBoneAnalysis.machine =
          new List<String>.from(data['fishBoneAnalysis']['machine']);
      qpcr.fishBoneAnalysis.method =
          new List<String>.from(data['fishBoneAnalysis']['method']);
      qpcr.fishBoneAnalysis.material =
          new List<String>.from(data['fishBoneAnalysis']['material']);
      qpcr.fishBoneAnalysis.environment =
          new List<String>.from(data['fishBoneAnalysis']['environment']);
    }

    if (data['validationReport'] != null) {
      qpcr.validationReports = [];

      for (int j = 0; j < data['validationReport'].length; j++) {
        ValidationReport validationReport = ValidationReport();

        validationReport.cause = data['validationReport'][j]['cause'];

        validationReport.specification =
            data['validationReport'][j]['specification'];
        validationReport.isValid = data['validationReport'][j]['isValid'];
        validationReport.remarks = data['validationReport'][j]['remarks'];
        qpcr.validationReports.add(validationReport);
      }
    }
    if (data['measures'] != null) {
      qpcr.measures = [];

      for (int j = 0; j < data['measures'].length; j++) {
        Measures measures = Measures();
        measures.cause = data['measures'][j]['cause'];
        CorrectiveMeasures correctiveMeasures = CorrectiveMeasures();
        PreventiveMeasures preventiveMeasures = PreventiveMeasures();

        correctiveMeasures.cmOccurrenceMeasure =
            data['measures'][j]['correctiveMeasures']['CMOccurenceMeasure'];
        correctiveMeasures.cmOccurrencePhotoURL =
            data['measures'][j]['correctiveMeasures']['CMOccurencePhotoURL'];
        correctiveMeasures.cmOutflowMeasure =
            data['measures'][j]['correctiveMeasures']['CMOutflowMeasure'];
        correctiveMeasures.cmOutflowPhotoURL =
            data['measures'][j]['correctiveMeasures']['CMOutflowPhotoURL'];
        measures.correctiveMeasures = correctiveMeasures;
        preventiveMeasures.pmOccurrenceMeasure =
            data['measures'][j]['preventiveMeasures']['PMOccurenceMeasure'];
        preventiveMeasures.pmOccurrencePhotoURL =
            data['measures'][j]['preventiveMeasures']['PMOccurencePhotoURL'];
        preventiveMeasures.pmOutflowMeasure =
            data['measures'][j]['preventiveMeasures']['PMOutflowMeasure'];
        preventiveMeasures.pmOutflowPhotoURL =
            data['measures'][j]['preventiveMeasures']['PMOutflowPhotoURL'];
        measures.preventiveMeasures = preventiveMeasures;
        qpcr.measures.add(measures);
      }
    }

    if (data['standardization'] != null) {
      StandardizationDetails standardization = StandardizationDetails();
      standardization.drawingDocNumber =
          data['standardization']['drawingDocNumber'];

      standardization.pfdDocNumber = data['standardization']['PFDDocNumber'];
      standardization.fmeaDocNumber = data['standardization']['FMEADocNumber'];
      standardization.cpDocNumber = data['standardization']['CPDocNumber'];
      standardization.pisDocNumber = data['standardization']['PISDocNumber'];
      standardization.sopDocNumber = data['standardization']['SOPDocNumber'];
      standardization.fipDocNumber = data['standardization']['FIPDocNumber'];
      standardization.fdDocNumber = data['standardization']['FDDocNumber'];
      standardization.psDocNumber = data['standardization']['PSDocNumber'];
      standardization.otherStandardization =
          data['standardization']['otherStandardization'];

      qpcr.standardization = standardization;
    }
    if (data['teamInvolved'] != null) {
      qpcr.teamInvolved = [];
      for (int j = 0; j < data['teamInvolved'].length; j++) {
        qpcr.teamInvolved[j].id = data['teamInvolved'][j]['_id'];
        qpcr.teamInvolved[j].username = data['teamInvolved'][j]['username'];
        qpcr.teamInvolved[j].department = data['teamInvolved'][j]['department'];
        qpcr.teamInvolved[j].genId = data['teamInvolved'][j]['genId'];
      }
    }
    if (data['effectivenessMonitoring'] != null) {
      qpcr.effectivenessMonitoring = [];
      for (int j = 0; j < data['effectivenessMonitoring'].length; j++) {
        qpcr.effectivenessMonitoring[j].actionTaken =
            data['effectivenessMonitoring'][j]['ActionTaken'];
        qpcr.effectivenessMonitoring[j].grnOfFirstLot =
            data['effectivenessMonitoring'][j]['GRNofFirstLot'];
        qpcr.effectivenessMonitoring[j].dateOfFirstImplementation =
            DateTime.parse(data['effectivenessMonitoring'][j]
                ['dateOfFirstImplementation']);
        qpcr.effectivenessMonitoring[j].suppliedQty =
            data['effectivenessMonitoring'][j]['suppliedQty'];
        qpcr.effectivenessMonitoring[j].acceptedQty =
            data['effectivenessMonitoring'][j]['acceptedQty'];
        qpcr.effectivenessMonitoring[j].remarks =
            data['effectivenessMonitoring'][j]['remarks'];
      }
    }
    if (data['horizontalDeploymentDetails'] != null) {
      qpcr.horizontalDeploymentDetails = [];
      for (int j = 0; j < data['horizontalDeploymentDetails'].length; j++) {
        qpcr.horizontalDeploymentDetails[j].isApplicable =
            data['horizontalDeploymentDetails'][j]['isApplicable'];
        qpcr.horizontalDeploymentDetails[j].similarProcessOrProductName =
            data['horizontalDeploymentDetails'][j]
                ['similarProcessOrProductName'];
        qpcr.horizontalDeploymentDetails[j].descOfMeasure =
            data['horizontalDeploymentDetails'][j]['descOfMeasure'];
        qpcr.horizontalDeploymentDetails[j].targetDate = DateTime.parse(
            data['horizontalDeploymentDetails'][j]['targetDate']);
        qpcr.horizontalDeploymentDetails[j].isEffective =
            data['horizontalDeploymentDetails'][j]['isEffective'];
      }
    }
    qpcr.submissionDate = data['submissionDate'] != null
        ? DateTime.parse(data['submissionDate'])
        : null;

    qpcr.actualClosingDate = data['actualClosingDate'] != null
        ? DateTime.parse(data['actualClosingDate'])
        : null;

    qpcr.submissionRejectingReason = data['submissionRejectingReason'];
    if (data['acceptingPerson'] != null) {
      qpcr.acceptingPerson = data['acceptingPerson'];
    }
    // qpcr.id = data['_id'];
    qpcr.partName = data['partName'];
    qpcr.partNumber = data['partNumber'];
    qpcr.lotCode = data['lotCode'];
    qpcr.productionOrderQty = data['productionOrderQty'];
    qpcr.manufacturingDate = data['manufacturingDate'] != null
        ? DateTime.parse(data['manufacturingDate'])
        : null;
    qpcr.productionOrderNumber = data['productionOrderNumber'];
    qpcr.supplierInvoiceNumber = data['supplierInvoiceNumber'];
    qpcr.model = data['model'];
    qpcr.concernType = data['concernType'];

    qpcr.problem = data['problem'];
    if (data['detectionStage'] != null) {
      qpcr.detectionStage.receiptStage = data['detectionStage']['recieptStage'];
      qpcr.detectionStage.customerEnd = data['detectionStage']['customerEnd'];
      qpcr.detectionStage.others = data['detectionStage']['other'];
      qpcr.detectionStage.pdi = data['detectionStage']['PDI'];
      qpcr.detectionStage.detectionMachine.machineName =
          data['detectionStage']['detectionMachine'] != null
              ? data['detectionStage']['detectionMachine']['name']
              : null;
      qpcr.detectionStage.detectionMachine.machineCode =
          data['detectionStage']['detectionMachine'] != null
              ? data['detectionStage']['detectionMachine']['code']
              : null;
      qpcr.detectionStage.detectionLine.lineName =
          data['detectionStage']['detectionLine'] != null
              ? data['detectionStage']['detectionLine']['name']
              : null;
    }

    qpcr.defectRank = data['defectRank'];
    if (data['raisingPerson'] != null) {
      qpcr.raisingPerson.username = data['raisingPerson']['username'];
      qpcr.raisingPerson.id = data['raisingPerson']['_id'];
      qpcr.raisingPerson.genId = data['raisingPerson']['genId'];
      qpcr.raisingPerson.department = data['raisingPerson']['department'];
    }
    qpcr.raisingDate = DateTime.parse(data['raisingDate']);

    return qpcr;
  }

///////////////// QPCR SHORT LIST
  List<QPCR> getQPCRShortList(var decodedData) {
    List data = decodedData;

    List<QPCR> QPCRList = [];
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        QPCR qpcr = new QPCR();
        qpcr.id = data[i]['_id'];
        qpcr.qpcrNo = data[i]['QPCRNo'];
        qpcr.problem = data[i]['problem'];
        qpcr.status = data[i]['status'];
        qpcr.concernType = data[i]['concernType'];
        qpcr.partName = data[i]['partName'];

        qpcr.deptResponsible = data[i]['deptResponsible'];
        qpcr.defectRank = data[i]['defectRank'];
        qpcr.raisingPerson.username = data[i]['raisingPerson']['username'];
        qpcr.raisingPerson.id = data[i]['raisingPerson']['_id'];
        qpcr.raisingPerson.genId = data[i]['raisingPerson']['genId'];
        qpcr.raisingPerson.department = data[i]['raisingPerson']['department'];
        qpcr.raisingDate = DateTime.parse(data[i]['raisingDate']);
        qpcr.raisingDept = data[i]['raisingDept'];
        QPCRList.add(qpcr);
      }
      return QPCRList;
    } else {
      return null;
    }
  }

  //////////////////QPCR LONG LIST
  List<QPCR> getQPCRLongList(var decodedData) {
    List data = decodedData;

    List<QPCR> QPCRList = [];
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        QPCR qpcr = new QPCR();

        qpcr.id = data[i]['_id'];
        qpcr.qpcrNo = data[i]['QPCRNo'];
        qpcr.totalLotQty = data[i]['totalLotQty'];
        qpcr.problemDescription = data[i]['problemDescription'];

        qpcr.supplierInvoiceNumber = data[i]['supplierInvoiceNumber'];
        qpcr.complaintImpactAreas.safetyImpact =
            data[i]['complaintImpactAreas']['Safety'];
        qpcr.complaintImpactAreas.visualImpact =
            data[i]['complaintImpactAreas']['Visual'];
        qpcr.complaintImpactAreas.fitmentImpact =
            data[i]['complaintImpactAreas']['Fitment'];
        qpcr.complaintImpactAreas.functionalImpact =
            data[i]['complaintImpactAreas']['Functional'];
        qpcr.complaintImpactAreas.otherImpact =
            data[i]['complaintImpactAreas']['Others'];
        qpcr.defectiveQuantity = data[i]['defectiveQuantity'];
        qpcr.raisingDept = data[i]['raisingDept'];
        qpcr.deptResponsible = data[i]["deptResponsible"];
        qpcr.okPhotoURL = data[i]['OKPhotoURL'];
        qpcr.ngPhotoURL = data[i]['NGPhotoURL'];
        qpcr.status = data[i]['status'];
        qpcr.targetSubmittingDate = data[i]['targetSubmittingDate'] != null
            ? DateTime.parse(data[i]['targetSubmittingDate'])
            : null;
        qpcr.rejectingReason = data[i]['rejectingReason'];
        qpcr.interimContainmentAction = data[i]['interimContainmentAction'];

        if (data[i]['segregationDetails'] != null) {
          qpcr.segregationDetails = [];
          for (int j = 0; j < data[i]['segregationDetails'].length; j++) {
            qpcr.segregationDetails[j].partsCheckedAt =
                data[i]['segregationDetails'][j]['partsCheckedAt'];
            qpcr.segregationDetails[j].occurringDate = DateTime.parse(
                data[i]['segregationDetails'][j]['occurringDate']);
            qpcr.segregationDetails[j].segregationDate = DateTime.parse(
                data[i]['segregationDetails'][j]['segregationDate']);
            qpcr.segregationDetails[j].okQty =
                data[i]['segregationDetails'][j]['OKqty'];
            qpcr.segregationDetails[j].rejectedQtyBeforeRework =
                data[i]['segregationDetails'][j]['RejectedQtyBeforeRework'];
            qpcr.segregationDetails[j].sapQtyToBeChecked =
                data[i]['segregationDetails'][j]['SAPqtyToBeChecked'];
            qpcr.segregationDetails[j].reworkQty =
                data[i]['segregationDetails'][j]['reworkQty'];
            qpcr.segregationDetails[j].reworkOKQty =
                data[i]['segregationDetails'][j]['reworkOKQty'];
            qpcr.segregationDetails[j].remarks =
                data[i]['segregationDetails'][j]['remarks'];
          }
        }
        if (data[i]['whyWhyAnalysis'] != null) {
          qpcr.whyWhyAnalysis = [];
          for (int j = 0; j < data[i]['whyWhyAnalysis'].length; j++) {
            qpcr.whyWhyAnalysis[j].problem =
                data[i]['whyWhyAnalysis'][j]['problem'];

            qpcr.whyWhyAnalysis[j].occurrenceWhyWhy =
                data[i]['whyWhyAnalysis'][j]['occurrenceWhyWhy'];
            qpcr.whyWhyAnalysis[j].detectionWhyWhy =
                data[i]['whyWhyAnalysis'][j]['detectionWhyWhy'];
          }
        }

        if (data[i]['fishBoneAnalysis'] != null) {
          qpcr.fishBoneAnalysis.man = data[i]['fishBoneAnalysis']['man'];

          qpcr.fishBoneAnalysis.machine =
              data[i]['fishBoneAnalysis']['machine'];
          qpcr.fishBoneAnalysis.method = data[i]['fishBoneAnalysis']['method'];
          qpcr.fishBoneAnalysis.material =
              data[i]['fishBoneAnalysis']['material'];
          qpcr.fishBoneAnalysis.environment =
              data[i]['fishBoneAnalysis']['environment'];
        }

        if (data[i]['validationReport'] != null) {
          qpcr.validationReports = [];
          for (int j = 0; j < data[i]['validationReport'].length; j++) {
            qpcr.validationReports[j].cause =
                data[i]['validationReport'][j]['cause'];

            qpcr.validationReports[j].specification =
                data[i]['validationReport'][j]['specification'];
            qpcr.validationReports[j].isValid =
                data[i]['validationReport'][j]['isValid'];
            qpcr.validationReports[j].remarks =
                data[i]['validationReport'][j]['remarks'];
          }
        }
        if (data[i]['measures'] != null) {
          qpcr.measures = [];
          for (int j = 0; j < data[i]['measures'].length; j++) {
            qpcr.measures[j].cause = data[i]['measures'][j]['cause'];

            qpcr.measures[j].correctiveMeasures.cmOccurrenceMeasure = data[i]
                ['measures'][j]['correctiveMeasures']['CMOccurenceMeasure'];
            qpcr.measures[j].correctiveMeasures.cmOccurrencePhotoURL = data[i]
                ['measures'][j]['correctiveMeasures']['CMOccurencePhotoURL'];
            qpcr.measures[j].correctiveMeasures.cmOutflowMeasure = data[i]
                ['measures'][j]['correctiveMeasures']['CMOutflowMeasure'];
            qpcr.measures[j].correctiveMeasures.cmOutflowPhotoURL = data[i]
                ['measures'][j]['correctiveMeasures']['CMOutflowPhotoURL'];

            qpcr.measures[j].preventiveMeasures.pmOccurrenceMeasure = data[i]
                ['measures'][j]['preventiveMeasures']['PMOccurenceMeasure'];
            qpcr.measures[j].preventiveMeasures.pmOccurrencePhotoURL = data[i]
                ['measures'][j]['preventiveMeasures']['PMOccurencePhotoURL'];
            qpcr.measures[j].preventiveMeasures.pmOutflowMeasure = data[i]
                ['measures'][j]['preventiveMeasures']['PMOutflowMeasure'];
            qpcr.measures[j].preventiveMeasures.pmOutflowPhotoURL = data[i]
                ['measures'][j]['preventiveMeasures']['PMOutflowPhotoURL'];
          }
        }

        if (data[i]['standardization'] != null) {
          qpcr.standardization.drawingDocNumber =
              data[i]['standardization']['drawingDocNumber'];

          qpcr.standardization.pfdDocNumber =
              data[i]['standardization']['PFDDocNumber'];
          qpcr.standardization.fmeaDocNumber =
              data[i]['standardization']['FMEADocNumber'];
          qpcr.standardization.cpDocNumber =
              data[i]['standardization']['CPDocNumber'];
          qpcr.standardization.pisDocNumber =
              data[i]['standardization']['PISDocNumber'];
          qpcr.standardization.sopDocNumber =
              data[i]['standardization']['SOPDocNumber'];
          qpcr.standardization.fipDocNumber =
              data[i]['standardization']['FIPDocNumber'];
          qpcr.standardization.fdDocNumber =
              data[i]['standardization']['FDDocNumber'];
          qpcr.standardization.psDocNumber =
              data[i]['standardization']['PSDocNumber'];
          qpcr.standardization.otherStandardization =
              data[i]['standardization']['otherStandardization'];
        }
        if (data[i]['teamInvolved'] != null) {
          qpcr.teamInvolved = [];
          for (int j = 0; j < data[i]['teamInvolved'].length; j++) {
            qpcr.teamInvolved[j].id = data[i]['teamInvolved'][j]['_id'];
            qpcr.teamInvolved[j].username =
                data[i]['teamInvolved'][j]['username'];
            qpcr.teamInvolved[j].department =
                data[i]['teamInvolved'][j]['department'];
            qpcr.teamInvolved[j].genId = data[i]['teamInvolved'][j]['genId'];
          }
        }
        if (data[i]['effectivenessMonitoring'] != null) {
          for (int j = 0; j < data[i]['effectivenessMonitoring'].length; j++) {
            qpcr.effectivenessMonitoring[j].actionTaken =
                data[i]['effectivenessMonitoring'][j]['ActionTaken'];
            qpcr.effectivenessMonitoring[j].grnOfFirstLot =
                data[i]['effectivenessMonitoring'][j]['GRNofFirstLot'];
            qpcr.effectivenessMonitoring[j].dateOfFirstImplementation =
                DateTime.parse(data[i]['effectivenessMonitoring'][j]
                    ['dateOfFirstImplementation']);
            qpcr.effectivenessMonitoring[j].suppliedQty =
                data[i]['effectivenessMonitoring'][j]['suppliedQty'];
            qpcr.effectivenessMonitoring[j].acceptedQty =
                data[i]['effectivenessMonitoring'][j]['acceptedQty'];
            qpcr.effectivenessMonitoring[j].remarks =
                data[i]['effectivenessMonitoring'][j]['remarks'];
          }
        }
        if (data[i]['horizontalDeploymentDetails'] != null) {
          qpcr.horizontalDeploymentDetails = [];
          for (int j = 0;
              j < data[i]['horizontalDeploymentDetails'].length;
              j++) {
            qpcr.horizontalDeploymentDetails[j].isApplicable =
                data[i]['horizontalDeploymentDetails'][j]['isApplicable'];
            qpcr.horizontalDeploymentDetails[j].similarProcessOrProductName =
                data[i]['horizontalDeploymentDetails'][j]
                    ['similarProcessOrProductName'];
            qpcr.horizontalDeploymentDetails[j].descOfMeasure =
                data[i]['horizontalDeploymentDetails'][j]['descOfMeasure'];
            qpcr.horizontalDeploymentDetails[j].targetDate = DateTime.parse(
                data[i]['horizontalDeploymentDetails'][j]['targetDate']);
            qpcr.horizontalDeploymentDetails[j].isEffective =
                data[i]['horizontalDeploymentDetails'][j]['isEffective'];
          }
        }
        qpcr.submissionDate = data[i]['submissionDate'] != null
            ? DateTime.parse(data[i]['submissionDate'])
            : null;

        qpcr.actualClosingDate = data[i]['actualClosingDate'] != null
            ? DateTime.parse(data[i]['actualClosingDate'])
            : null;

        qpcr.submissionRejectingReason = data[i]['submissionRejectingReason'];
        if (data[i]['acceptingPerson'] != null) {
          qpcr.acceptingPerson = data[i]['acceptingPerson'];
        }
        qpcr.partName = data[i]['partName'];
        qpcr.partNumber = data[i]['partNumber'];
        qpcr.lotCode = data[i]['lotCode'];
        qpcr.productionOrderQty = data[i]['productionOrderQty'];
        qpcr.manufacturingDate = data[i]['manufacturingDate'] != null
            ? DateTime.parse(data[i]['manufacturingDate'])
            : null;
        qpcr.productionOrderNumber = data[i]['productionOrderNumber'];
        qpcr.supplierInvoiceNumber = data[i]['supplierInvoiceNumber'];
        qpcr.model = data[i]['model'];
        qpcr.concernType = data[i]['concernType'];

        qpcr.problem = data[i]['problem'];
        if (data[i]['detectionStage'] != null) {
          qpcr.detectionStage.receiptStage =
              data[i]['detectionStage']['recieptStage'];
          qpcr.detectionStage.customerEnd =
              data[i]['detectionStage']['customerEnd'];
          qpcr.detectionStage.others = data[i]['detectionStage']['other'];
          qpcr.detectionStage.pdi = data[i]['detectionStage']['PDI'];
          qpcr.detectionStage.detectionMachine.machineName =
              data[i]['detectionStage']['detectionMachine'] != null
                  ? data[i]['detectionStage']['detectionMachine']['name']
                  : null;
          qpcr.detectionStage.detectionMachine.machineCode =
              data[i]['detectionStage']['detectionMachine'] != null
                  ? data[i]['detectionStage']['detectionMachine']['code']
                  : null;
          qpcr.detectionStage.detectionLine.lineName =
              data[i]['detectionStage']['detectionLine'] != null
                  ? data[i]['detectionStage']['detectionLine']['name']
                  : null;
        }
        qpcr.id = data[i]['_id'];
        qpcr.defectRank = data[i]['defectRank'];
        if (data[i]['raisingPerson'] != null) {
          qpcr.raisingPerson.username = data[i]['raisingPerson']['username'];
          qpcr.raisingPerson.id = data[i]['raisingPerson']['_id'];
          qpcr.raisingPerson.genId = data[i]['raisingPerson']['genId'];
          qpcr.raisingPerson.department =
              data[i]['raisingPerson']['department'];
        }
        qpcr.raisingDate = DateTime.parse(data[i]['raisingDate']);
        QPCRList.add(qpcr);
      }
      return QPCRList;
    } else {
      return null;
    }
  }

  Map QpcrToMap(QPCR qpcr) {
    Map<String, dynamic> qpcrMap = Map<String, dynamic>();
    qpcrMap["_id"] = qpcr.id;
    qpcrMap["interimContainmentAction"] = qpcr.interimContainmentAction;
    qpcrMap["segregationDetails"] = [];
    for (int i = 0; i < qpcr.segregationDetails.length; i++) {
      Map<String, dynamic> segDetails = Map<String, dynamic>();
      segDetails["partsCheckedAt"] = qpcr.segregationDetails[i].partsCheckedAt;
      segDetails["occurringDate"] =
          qpcr.segregationDetails[i].occurringDate.toString();
      segDetails["segregationDate"] =
          qpcr.segregationDetails[i].segregationDate.toString();
      segDetails["OKqty"] = qpcr.segregationDetails[i].okQty;
      segDetails["RejectedQtyBeforeRework"] =
          qpcr.segregationDetails[i].rejectedQtyBeforeRework;
      segDetails["SAPqtyToBeChecked"] =
          qpcr.segregationDetails[i].sapQtyToBeChecked;
      segDetails["reworkQty"] = qpcr.segregationDetails[i].reworkQty;
      segDetails["reworkOKQty"] = qpcr.segregationDetails[i].reworkOKQty;
      segDetails["remarks"] = qpcr.segregationDetails[i].remarks;

      qpcrMap["segregationDetails"].add(segDetails);
    }
    qpcrMap['fishBoneAnalysis'] = Map<String, dynamic>();
    qpcrMap['fishBoneAnalysis']['man'] = qpcr.fishBoneAnalysis.man;
    qpcrMap['fishBoneAnalysis']['machine'] = qpcr.fishBoneAnalysis.machine;
    qpcrMap['fishBoneAnalysis']['method'] = qpcr.fishBoneAnalysis.method;
    qpcrMap['fishBoneAnalysis']['material'] = qpcr.fishBoneAnalysis.material;
    qpcrMap['fishBoneAnalysis']['environment'] =
        qpcr.fishBoneAnalysis.environment;
    // print(qpcrMap.toString());
    qpcrMap['validationReport'] = [];
    for (int i = 0; i < qpcr.validationReports.length; i++) {
      Map<String, dynamic> validationReport = Map<String, dynamic>();

      validationReport['cause'] = qpcr.validationReports[i].cause;
      validationReport['isValid'] = qpcr.validationReports[i].isValid;
      validationReport['specification'] =
          qpcr.validationReports[i].specification;
      validationReport['remarks'] = qpcr.validationReports[i].remarks;

      qpcrMap['validationReport'].add(validationReport);
    }
    qpcrMap['whyWhyAnalysis'] = [];
    for (int i = 0; i < qpcr.whyWhyAnalysis.length; i++) {
      Map<String, dynamic> whyWhy = Map<String, dynamic>();

      whyWhy['problem'] = qpcr.whyWhyAnalysis[i].problem;
      whyWhy['occurrenceWhyWhy'] = qpcr.whyWhyAnalysis[i].occurrenceWhyWhy;
      whyWhy['detectionWhyWhy'] = qpcr.whyWhyAnalysis[i].detectionWhyWhy != null
          ? qpcr.whyWhyAnalysis[i].detectionWhyWhy
          : [];

      qpcrMap['whyWhyAnalysis'].add(whyWhy);
    }
    qpcrMap['measures'] = [];
    for (int i = 0; i < qpcr.measures.length; i++) {
      Map<String, dynamic> measures = Map<String, dynamic>();

      measures['cause'] = qpcr.measures[i].cause;
      Map<String, dynamic> preventiveMeasures = Map<String, dynamic>();
      Map<String, dynamic> correctiveMeasures = Map<String, dynamic>();
      preventiveMeasures['PMOutflowMeasure'] =
          qpcr.measures[i].preventiveMeasures.pmOutflowMeasure;
      preventiveMeasures['PMOutflowPhotoURL'] =
          qpcr.measures[i].preventiveMeasures.pmOutflowPhotoURL;
      preventiveMeasures['PMOccurenceMeasure'] =
          qpcr.measures[i].preventiveMeasures.pmOccurrenceMeasure;
      preventiveMeasures['PMOccurencePhotoURL'] =
          qpcr.measures[i].preventiveMeasures.pmOccurrencePhotoURL;
      correctiveMeasures['CMOutflowMeasure'] =
          qpcr.measures[i].correctiveMeasures.cmOutflowMeasure;
      correctiveMeasures['CMOutflowPhotoURL'] =
          qpcr.measures[i].correctiveMeasures.cmOutflowPhotoURL;
      correctiveMeasures['CMOccurenceMeasure'] =
          qpcr.measures[i].correctiveMeasures.cmOccurrenceMeasure;
      correctiveMeasures['CMOccurencePhotoURL'] =
          qpcr.measures[i].correctiveMeasures.cmOccurrencePhotoURL;
      measures['correctiveMeasures'] = correctiveMeasures;
      measures['preventiveMeasures'] = preventiveMeasures;

      qpcrMap['measures'].add(measures);
    }
    if (qpcr.standardization != null) {
      Map<String, dynamic> standardization = Map<String, dynamic>();
      standardization["drawingDocNumber"] =
          qpcr.standardization.drawingDocNumber;
      standardization["PFDDocNumber"] = qpcr.standardization.pfdDocNumber;
      standardization["FMEADocNumber"] = qpcr.standardization.fmeaDocNumber;

      standardization["CPDocNumber"] = qpcr.standardization.cpDocNumber;

      standardization["PISDocNumber"] = qpcr.standardization.pisDocNumber;

      standardization["SOPDocNumber"] = qpcr.standardization.sopDocNumber;

      standardization["FIPDocNumber"] = qpcr.standardization.fipDocNumber;

      standardization["FDDocNumber"] = qpcr.standardization.fdDocNumber;

      standardization["PSDocNumber"] = qpcr.standardization.psDocNumber;

      standardization["otherStandardization"] =
          qpcr.standardization.otherStandardization;
      qpcrMap['standardization'] = standardization;
    }
    return qpcrMap;
  }
}

class QPCR {
  String id;
  String qpcrNo;
  String partName;
  String partNumber;
  String lotCode;
  int totalLotQty;

  String problem;
  String productionOrderNumber;
  String problemDescription;
  int productionOrderQty;
  DateTime manufacturingDate;
  String supplierInvoiceNumber;
  String model;
  String concernType;
  DetectionStage detectionStage = DetectionStage();
  ComplaintImpactAreas complaintImpactAreas = ComplaintImpactAreas();
  String defectRank;
  int defectiveQuantity;
  String raisingDept;
  User raisingPerson = User();
  String deptResponsible;
  DateTime raisingDate;
  String okPhotoURL;
  String ngPhotoURL;
  int status;
  DateTime targetSubmittingDate;
  String rejectingReason;

  String interimContainmentAction;

  List<SegregationDetails> segregationDetails = [];

  List<WhyWhyAnalysis> whyWhyAnalysis = [];

  FishBone fishBoneAnalysis = FishBone();

  List<ValidationReport> validationReports = [];

  List<Measures> measures = [];

  StandardizationDetails standardization;

  List<User> teamInvolved = [];

  List<CAPAEffectivenessDetails> effectivenessMonitoring = [];
  List<HorizontalDeploymentDetails> horizontalDeploymentDetails = [];
  DateTime submissionDate;
  DateTime actualClosingDate;
  String submissionRejectingReason;

  String acceptingPerson;
}

class DetectionStage {
  bool receiptStage;
  bool customerEnd;
  bool pdi;
  Machines detectionMachine = Machines();
  Line detectionLine = Line();
  String others;
}

class ComplaintImpactAreas {
  bool safetyImpact;
  bool fitmentImpact;
  bool functionalImpact;
  bool visualImpact;
  String otherImpact;
}

class SegregationDetails {
  String partsCheckedAt;

  DateTime occurringDate;
  DateTime segregationDate;

  int okQty;

  int rejectedQtyBeforeRework;

  int sapQtyToBeChecked;
  int reworkQty;
  int reworkOKQty;
  String remarks;
}

class WhyWhyAnalysis {
  int id;
  String problem;
  List<String> occurrenceWhyWhy = [];
  List<String> detectionWhyWhy = [];
}

class FishBone {
  List<String> man = [];
  List<String> machine = [];
  List<String> method = [];
  List<String> material = [];
  List<String> environment = [];
}

class ValidationReport {
  String cause;
  String specification;
  String remarks;
  bool isValid;
}

class Measures {
  String cause;
  CorrectiveMeasures correctiveMeasures = CorrectiveMeasures();
  PreventiveMeasures preventiveMeasures = PreventiveMeasures();
}

class PreventiveMeasures {
  String pmOutflowMeasure;
  String pmOutflowPhotoURL;
  String pmOccurrenceMeasure;
  String pmOccurrencePhotoURL;
}

class CorrectiveMeasures {
  String cmOutflowMeasure;
  String cmOutflowPhotoURL;
  String cmOccurrenceMeasure;
  String cmOccurrencePhotoURL;
}

class StandardizationDetails {
  String drawingDocNumber;
  String pfdDocNumber;
  String fmeaDocNumber;
  String cpDocNumber;
  String pisDocNumber;
  String sopDocNumber;
  String fipDocNumber;
  String fdDocNumber;
  String psDocNumber;
  String otherStandardization;
}

class CAPAEffectivenessDetails {
  String actionTaken;
  String grnOfFirstLot;
  DateTime dateOfFirstImplementation;
  int suppliedQty;
  int acceptedQty;
  String remarks;
}

class HorizontalDeploymentDetails {
  bool isApplicable;
  String similarProcessOrProductName;

  String descOfMeasure;
  DateTime targetDate;
  bool isEffective;
}

class User {
  String username;
  String id;
  String genId;

  String department;
}
