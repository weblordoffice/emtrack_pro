class TireResponseModel {
  final String? message;
  final bool didError;
  final String? errorMessage;
  final int httpStatusCode;
  final int pageSize;
  final int pageNumber;
  final int currentTimeStamp;
  final List<TireItem> model;

  TireResponseModel({
    required this.message,
    required this.didError,
    required this.errorMessage,
    required this.httpStatusCode,
    required this.pageSize,
    required this.pageNumber,
    required this.currentTimeStamp,
    required this.model,
  });

  factory TireResponseModel.fromJson(Map<String, dynamic> json) {
    return TireResponseModel(
      message: json['message'],
      didError: json['didError'] ?? false,
      errorMessage: json['errorMessage'],
      httpStatusCode: json['httpStatusCode'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pageNumber: json['pageNumber'] ?? 0,
      currentTimeStamp: json['currentTimeStamp'] ?? 0,
      model: json['model'] != null
          ? List<TireItem>.from(json['model'].map((x) => TireItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "didError": didError,
      "errorMessage": errorMessage,
      "httpStatusCode": httpStatusCode,
      "pageSize": pageSize,
      "pageNumber": pageNumber,
      "currentTimeStamp": currentTimeStamp,
      "model": model.map((x) => x.toJson()).toList(),
    };
  }
}

class TireItem {
  final int tireId;
  final int vehicleId;
  final int locationId;
  final String locationName;
  final int parentAccountId;
  final String tireSerialNo;
  final String brandNo;
  final int typeId;
  final int sizeId;
  final String sizeName;
  final String typeName;
  final String manufacturerName;
  final int manufacturerId;
  final double currentHours;
  final double currentMiles;
  final double currentTreadDepth;
  final double percentageWorn;
  final String mileageType;
  final int dispositionId;
  final String dispositionName;
  final String tireStatusName;
  final int dispositionGroupId;
  final String? wearNonSkid;
  final bool isMountToRim;
  final String? dateRetired;
  final String vehicleNumber;
  final int compoundId;
  final int? mountedRimId;
  final double recommendedPressure;
  final double currentPressure;
  final String? rimSerialNo;
  final String wheelPosition;
  final String lotNo;
  final String evaluationNo;
  final String compoundName;
  final String ratingName;

  TireItem({
    required this.tireId,
    required this.vehicleId,
    required this.locationId,
    required this.locationName,
    required this.parentAccountId,
    required this.tireSerialNo,
    required this.brandNo,
    required this.typeId,
    required this.sizeId,
    required this.sizeName,
    required this.typeName,
    required this.manufacturerName,
    required this.manufacturerId,
    required this.currentHours,
    required this.currentMiles,
    required this.currentTreadDepth,
    required this.percentageWorn,
    required this.mileageType,
    required this.dispositionId,
    required this.dispositionName,
    required this.tireStatusName,
    required this.dispositionGroupId,
    required this.wearNonSkid,
    required this.isMountToRim,
    required this.dateRetired,
    required this.vehicleNumber,
    required this.compoundId,
    required this.mountedRimId,
    required this.recommendedPressure,
    required this.currentPressure,
    required this.rimSerialNo,
    required this.wheelPosition,
    required this.lotNo,
    required this.evaluationNo,
    required this.compoundName,
    required this.ratingName,
  });

  factory TireItem.fromJson(Map<String, dynamic> json) {
    return TireItem(
      tireId: json['tireId'] ?? 0,
      vehicleId: json['vehicleId'] ?? 0,
      locationId: json['locationId'] ?? 0,
      locationName: json['locationName'] ?? '',
      parentAccountId: json['parentAccountId'] ?? 0,
      tireSerialNo: json['tireSerialNo'] ?? '',
      brandNo: json['brandNo'] ?? '',
      typeId: json['typeId'] ?? 0,
      sizeId: json['sizeId'] ?? 0,
      sizeName: json['sizeName'] ?? '',
      typeName: json['typeName'] ?? '',
      manufacturerName: json['manufacturerName'] ?? '',
      manufacturerId: json['manufacturerId'] ?? 0,
      currentHours: (json['currentHours'] ?? 0).toDouble(),
      currentMiles: (json['currentMiles'] ?? 0).toDouble(),
      currentTreadDepth: (json['currentTreadDepth'] ?? 0).toDouble(),
      percentageWorn: (json['percentageWorn'] ?? 0).toDouble(),
      mileageType: json['mileageType'] ?? '',
      dispositionId: json['dispositionId'] ?? 0,
      dispositionName: json['dispositionName'] ?? '',
      tireStatusName: json['tireStatusName'] ?? '',
      dispositionGroupId: json['dispositionGroupId'] ?? 0,
      wearNonSkid: json['wearNonSkid'],
      isMountToRim: json['isMountToRim'] ?? false,
      dateRetired: json['dateRetired'],
      vehicleNumber: json['vehicleNumber'] ?? '',
      compoundId: json['compoundId'] ?? 0,
      mountedRimId: json['mountedRimId'],
      recommendedPressure: (json['recommendedPressure'] ?? 0).toDouble(),
      currentPressure: (json['currentPressure'] ?? 0).toDouble(),
      rimSerialNo: json['rimSerialNo'],
      wheelPosition: json['wheelPosition'] ?? '',
      lotNo: json['lotNo'] ?? '',
      evaluationNo: json['evaluationNo'] ?? '',
      compoundName: json['compoundName'] ?? '',
      ratingName: json['ratingName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tireId": tireId,
      "vehicleId": vehicleId,
      "locationId": locationId,
      "locationName": locationName,
      "parentAccountId": parentAccountId,
      "tireSerialNo": tireSerialNo,
      "brandNo": brandNo,
      "typeId": typeId,
      "sizeId": sizeId,
      "sizeName": sizeName,
      "typeName": typeName,
      "manufacturerName": manufacturerName,
      "manufacturerId": manufacturerId,
      "currentHours": currentHours,
      "currentMiles": currentMiles,
      "currentTreadDepth": currentTreadDepth,
      "percentageWorn": percentageWorn,
      "mileageType": mileageType,
      "dispositionId": dispositionId,
      "dispositionName": dispositionName,
      "tireStatusName": tireStatusName,
      "dispositionGroupId": dispositionGroupId,
      "wearNonSkid": wearNonSkid,
      "isMountToRim": isMountToRim,
      "dateRetired": dateRetired,
      "vehicleNumber": vehicleNumber,
      "compoundId": compoundId,
      "mountedRimId": mountedRimId,
      "recommendedPressure": recommendedPressure,
      "currentPressure": currentPressure,
      "rimSerialNo": rimSerialNo,
      "wheelPosition": wheelPosition,
      "lotNo": lotNo,
      "evaluationNo": evaluationNo,
      "compoundName": compoundName,
      "ratingName": ratingName,
    };
  }
}
