import 'dart:convert';

ViewTyreResponse viewTyreResponseFromJson(String str) =>
    ViewTyreResponse.fromJson(json.decode(str));

String viewTyreResponseToJson(ViewTyreResponse data) =>
    json.encode(data.toJson());

class ViewTyreResponse {
  dynamic message;
  bool didError;
  dynamic errorMessage;
  int httpStatusCode;
  Model model;

  ViewTyreResponse({
    required this.message,
    required this.didError,
    required this.errorMessage,
    required this.httpStatusCode,
    required this.model,
  });

  factory ViewTyreResponse.fromJson(Map<String, dynamic> json) =>
      ViewTyreResponse(
        message: json["message"],
        didError: json["didError"],
        errorMessage: json["errorMessage"],
        httpStatusCode: json["httpStatusCode"],
        model: Model.fromJson(json["model"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "didError": didError,
    "errorMessage": errorMessage,
    "httpStatusCode": httpStatusCode,
    "model": model.toJson(),
  };
}

class Model {
  int tireId;
  String tireSerialNo;
  int vehicleId;
  int locationId;
  int parentAccountId;
  String brandNo;
  DateTime registeredDate;
  String mileageType;
  int currentMiles;
  int currentHours;
  int dispositionId;
  int tireStatusId;
  String wheelPosition;
  bool isMountToRim;
  dynamic mountedRimId;
  String mountedRimSerialNo;
  int originalTread;
  int purchasedTread;
  int removeAt;
  int outsideTread;
  int middleTread;
  int insideTread;
  int averageTreadDepth;
  int recommendedPressure;
  int currentTreadDepth;
  int currentPressure;
  int percentageWorn;
  int manufacturerId;
  int sizeId;
  int starRatingId;
  int plyId;
  int typeId;
  int indCodeId;
  int compoundId;
  int loadRatingId;
  int speedRatingId;
  int purchaseCost;
  int casingValue;
  int fillTypeId;
  int fillCost;
  int repairCost;
  int retreadCost;
  int repairCount;
  int retreadCount;
  int costAdjustment;
  int warrantyAdjustment;
  int soldAmount;
  int netCost;
  TireGraphData tireGraphData;
  String vehicleNumber;
  dynamic tireHistory;
  List<TireHistory1> tireHistory1;
  String createdBy;
  bool isEditable;
  String evaluationNo;
  String lotNo;
  String poNo;
  String imagesLocation;

  Model({
    required this.tireId,
    required this.tireSerialNo,
    required this.vehicleId,
    required this.locationId,
    required this.parentAccountId,
    required this.brandNo,
    required this.registeredDate,
    required this.mileageType,
    required this.currentMiles,
    required this.currentHours,
    required this.dispositionId,
    required this.tireStatusId,
    required this.wheelPosition,
    required this.isMountToRim,
    required this.mountedRimId,
    required this.mountedRimSerialNo,
    required this.originalTread,
    required this.purchasedTread,
    required this.removeAt,
    required this.outsideTread,
    required this.middleTread,
    required this.insideTread,
    required this.averageTreadDepth,
    required this.recommendedPressure,
    required this.currentTreadDepth,
    required this.currentPressure,
    required this.percentageWorn,
    required this.manufacturerId,
    required this.sizeId,
    required this.starRatingId,
    required this.plyId,
    required this.typeId,
    required this.indCodeId,
    required this.compoundId,
    required this.loadRatingId,
    required this.speedRatingId,
    required this.purchaseCost,
    required this.casingValue,
    required this.fillTypeId,
    required this.fillCost,
    required this.repairCost,
    required this.retreadCost,
    required this.repairCount,
    required this.retreadCount,
    required this.costAdjustment,
    required this.warrantyAdjustment,
    required this.soldAmount,
    required this.netCost,
    required this.tireGraphData,
    required this.vehicleNumber,
    required this.tireHistory,
    required this.tireHistory1,
    required this.createdBy,
    required this.isEditable,
    required this.evaluationNo,
    required this.lotNo,
    required this.poNo,
    required this.imagesLocation,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    tireId: json["tireId"],
    tireSerialNo: json["tireSerialNo"],
    vehicleId: json["vehicleId"],
    locationId: json["locationId"],
    parentAccountId: json["parentAccountId"],
    brandNo: json["brandNo"],
    registeredDate: DateTime.parse(json["registeredDate"]),
    mileageType: json["mileageType"],
    currentMiles: json["currentMiles"],
    currentHours: json["currentHours"],
    dispositionId: json["dispositionId"],
    tireStatusId: json["tireStatusId"],
    wheelPosition: json["wheelPosition"],
    isMountToRim: json["isMountToRim"],
    mountedRimId: json["mountedRimId"],
    mountedRimSerialNo: json["mountedRimSerialNo"],
    originalTread: json["originalTread"],
    purchasedTread: json["purchasedTread"],
    removeAt: json["removeAt"],
    outsideTread: json["outsideTread"],
    middleTread: json["middleTread"],
    insideTread: json["insideTread"],
    averageTreadDepth: json["averageTreadDepth"],
    recommendedPressure: json["recommendedPressure"],
    currentTreadDepth: json["currentTreadDepth"],
    currentPressure: json["currentPressure"],
    percentageWorn: json["percentageWorn"],
    manufacturerId: json["manufacturerId"],
    sizeId: json["sizeId"],
    starRatingId: json["starRatingId"],
    plyId: json["plyId"],
    typeId: json["typeId"],
    indCodeId: json["indCodeId"],
    compoundId: json["compoundId"],
    loadRatingId: json["loadRatingId"],
    speedRatingId: json["speedRatingId"],
    purchaseCost: json["purchaseCost"],
    casingValue: json["casingValue"],
    fillTypeId: json["fillTypeId"],
    fillCost: json["fillCost"],
    repairCost: json["repairCost"],
    retreadCost: json["retreadCost"],
    repairCount: json["repairCount"],
    retreadCount: json["retreadCount"],
    costAdjustment: json["costAdjustment"],
    warrantyAdjustment: json["warrantyAdjustment"],
    soldAmount: json["soldAmount"],
    netCost: json["netCost"],
    tireGraphData: TireGraphData.fromJson(json["tireGraphData"]),
    vehicleNumber: json["vehicleNumber"],
    tireHistory: json["tireHistory"],
    tireHistory1: List<TireHistory1>.from(
      json["tireHistory1"].map((x) => TireHistory1.fromJson(x)),
    ),
    createdBy: json["createdBy"],
    isEditable: json["isEditable"],
    evaluationNo: json["evaluationNo"],
    lotNo: json["lotNo"],
    poNo: json["poNo"],
    imagesLocation: json["imagesLocation"],
  );

  Map<String, dynamic> toJson() => {
    "tireId": tireId,
    "tireSerialNo": tireSerialNo,
    "vehicleId": vehicleId,
    "locationId": locationId,
    "parentAccountId": parentAccountId,
    "brandNo": brandNo,
    "registeredDate": registeredDate.toIso8601String(),
    "mileageType": mileageType,
    "currentMiles": currentMiles,
    "currentHours": currentHours,
    "dispositionId": dispositionId,
    "tireStatusId": tireStatusId,
    "wheelPosition": wheelPosition,
    "isMountToRim": isMountToRim,
    "mountedRimId": mountedRimId,
    "mountedRimSerialNo": mountedRimSerialNo,
    "originalTread": originalTread,
    "purchasedTread": purchasedTread,
    "removeAt": removeAt,
    "outsideTread": outsideTread,
    "middleTread": middleTread,
    "insideTread": insideTread,
    "averageTreadDepth": averageTreadDepth,
    "recommendedPressure": recommendedPressure,
    "currentTreadDepth": currentTreadDepth,
    "currentPressure": currentPressure,
    "percentageWorn": percentageWorn,
    "manufacturerId": manufacturerId,
    "sizeId": sizeId,
    "starRatingId": starRatingId,
    "plyId": plyId,
    "typeId": typeId,
    "indCodeId": indCodeId,
    "compoundId": compoundId,
    "loadRatingId": loadRatingId,
    "speedRatingId": speedRatingId,
    "purchaseCost": purchaseCost,
    "casingValue": casingValue,
    "fillTypeId": fillTypeId,
    "fillCost": fillCost,
    "repairCost": repairCost,
    "retreadCost": retreadCost,
    "repairCount": repairCount,
    "retreadCount": retreadCount,
    "costAdjustment": costAdjustment,
    "warrantyAdjustment": warrantyAdjustment,
    "soldAmount": soldAmount,
    "netCost": netCost,
    "tireGraphData": tireGraphData.toJson(),
    "vehicleNumber": vehicleNumber,
    "tireHistory": tireHistory,
    "tireHistory1": List<dynamic>.from(tireHistory1.map((x) => x.toJson())),
    "createdBy": createdBy,
    "isEditable": isEditable,
    "evaluationNo": evaluationNo,
    "lotNo": lotNo,
    "poNo": poNo,
    "imagesLocation": imagesLocation,
  };
}

class TireGraphData {
  List<CostPerHourListElement> treadDepthList;
  List<CostPerHourListElement> pressureList;
  List<CostPerHourListElement> costPerHourList;
  List<CostPerHourListElement> hoursPerTreadDepthList;
  List<CostPerHourListElement> milesPerTreadDepthList;

  TireGraphData({
    required this.treadDepthList,
    required this.pressureList,
    required this.costPerHourList,
    required this.hoursPerTreadDepthList,
    required this.milesPerTreadDepthList,
  });

  factory TireGraphData.fromJson(Map<String, dynamic> json) => TireGraphData(
    treadDepthList: List<CostPerHourListElement>.from(
      json["treadDepthList"].map((x) => CostPerHourListElement.fromJson(x)),
    ),
    pressureList: List<CostPerHourListElement>.from(
      json["pressureList"].map((x) => CostPerHourListElement.fromJson(x)),
    ),
    costPerHourList: List<CostPerHourListElement>.from(
      json["costPerHourList"].map((x) => CostPerHourListElement.fromJson(x)),
    ),
    hoursPerTreadDepthList: List<CostPerHourListElement>.from(
      json["hoursPerTreadDepthList"].map(
        (x) => CostPerHourListElement.fromJson(x),
      ),
    ),
    milesPerTreadDepthList: List<CostPerHourListElement>.from(
      json["milesPerTreadDepthList"].map(
        (x) => CostPerHourListElement.fromJson(x),
      ),
    ),
  );

  Map<String, dynamic> toJson() => {
    "treadDepthList": List<dynamic>.from(treadDepthList.map((x) => x.toJson())),
    "pressureList": List<dynamic>.from(pressureList.map((x) => x.toJson())),
    "costPerHourList": List<dynamic>.from(
      costPerHourList.map((x) => x.toJson()),
    ),
    "hoursPerTreadDepthList": List<dynamic>.from(
      hoursPerTreadDepthList.map((x) => x.toJson()),
    ),
    "milesPerTreadDepthList": List<dynamic>.from(
      milesPerTreadDepthList.map((x) => x.toJson()),
    ),
  };
}

class CostPerHourListElement {
  double tireMetric;
  DateTime timeSpan;
  String? info;

  CostPerHourListElement({
    required this.tireMetric,
    required this.timeSpan,
    required this.info,
  });

  factory CostPerHourListElement.fromJson(Map<String, dynamic> json) =>
      CostPerHourListElement(
        tireMetric: json["tireMetric"]?.toDouble(),
        timeSpan: DateTime.parse(json["timeSpan"]),
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
    "tireMetric": tireMetric,
    "timeSpan": timeSpan.toIso8601String(),
    "info": info,
  };
}

class TireHistory1 {
  int eventId;
  String eventName;
  DateTime eventDate;
  String disposition;
  int treadDepth;
  int pressure;
  int hours;
  int km;
  int cost;
  String vehicleNumber;
  String wheelPosition;
  dynamic comments;
  String user;
  int tireId;
  DateTime createdDate;
  DateTime updatedDate;
  String pressureType;

  TireHistory1({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.disposition,
    required this.treadDepth,
    required this.pressure,
    required this.hours,
    required this.km,
    required this.cost,
    required this.vehicleNumber,
    required this.wheelPosition,
    required this.comments,
    required this.user,
    required this.tireId,
    required this.createdDate,
    required this.updatedDate,
    required this.pressureType,
  });

  factory TireHistory1.fromJson(Map<String, dynamic> json) => TireHistory1(
    eventId: json["eventId"],
    eventName: json["eventName"],
    eventDate: DateTime.parse(json["eventDate"]),
    disposition: json["disposition"],
    treadDepth: json["treadDepth"],
    pressure: json["pressure"],
    hours: json["hours"],
    km: json["km"],
    cost: json["cost"],
    vehicleNumber: json["vehicleNumber"],
    wheelPosition: json["wheelPosition"],
    comments: json["comments"],
    user: json["user"],
    tireId: json["tireId"],
    createdDate: DateTime.parse(json["createdDate"]),
    updatedDate: DateTime.parse(json["updatedDate"]),
    pressureType: json["pressureType"],
  );

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "eventName": eventName,
    "eventDate": eventDate.toIso8601String(),
    "disposition": disposition,
    "treadDepth": treadDepth,
    "pressure": pressure,
    "hours": hours,
    "km": km,
    "cost": cost,
    "vehicleNumber": vehicleNumber,
    "wheelPosition": wheelPosition,
    "comments": comments,
    "user": user,
    "tireId": tireId,
    "createdDate": createdDate.toIso8601String(),
    "updatedDate": updatedDate.toIso8601String(),
    "pressureType": pressureType,
  };
}
