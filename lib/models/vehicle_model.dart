import 'package:emtrack/models/vehicle_history.dart';

class VehicleModel {
  final int? vehicleId;
  final int? parentAccountId;
  final String? parentAccountName;

  final int? locationId;
  final String? locationName;

  final int? manufacturerId;
  final String? manufacturer;

  final int? modelId;
  final String? modelName;

  final int? typeId;
  final String? typeName;

  final int? tireSizeId;
  final String? tireSize;

  final String? vehicleNumber;
  final DateTime? registeredDate;

  int? mileageType;
  final int? trackingMethod;

  final double? currentMiles;
  final double? currentHours;
  final double? removalTread;

  final String? axleConfig;
  final int? axleConfigId;

  final String? areaOfOperation;
  final String? modifications;
  final String? imagesLocation;

  double? recommendedPressure;
  final String? severityComments;

  final int? installedTireCount;
  final bool? isEditable;

  final String? assetNumber;
  final bool? hasMultipleTireSizes;
  final String? multipleTireSizeIds;
  final String? vehjsonFootprint;

  final DateTime? hoursDate;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? updatedDate;
  final String? updatedBy;
  final DateTime? lastUpdatedDate;

  final int? averageLoadingReqId;
  final String? averageLoadingReq;
  final int? speedId;
  final String? speed;
  final String? cutting;
  final int? cuttingId;

  final List<VehicleHistory>? vehicleHistory;

  VehicleModel({
    this.vehicleId,
    this.parentAccountId,
    this.parentAccountName,
    this.locationId,
    this.locationName,
    this.manufacturerId,
    this.manufacturer,
    this.modelId,
    this.modelName,
    this.typeId,
    this.typeName,
    this.tireSizeId,
    this.tireSize,
    this.vehicleNumber,
    this.registeredDate,
    this.mileageType,
    this.trackingMethod,
    this.currentMiles,
    this.currentHours,
    this.removalTread,
    this.axleConfig,
    this.axleConfigId,
    this.areaOfOperation,
    this.modifications,
    this.imagesLocation,
    this.recommendedPressure,
    this.severityComments,
    this.installedTireCount,
    this.isEditable,
    this.assetNumber,
    this.hasMultipleTireSizes,
    this.multipleTireSizeIds,
    this.vehjsonFootprint,
    this.hoursDate,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.lastUpdatedDate,
    this.vehicleHistory,
    this.averageLoadingReqId,
    this.averageLoadingReq,
    this.speedId,
    this.speed,
    this.cutting,
    this.cuttingId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "locationId": locationId,
      "manufacturerId": manufacturerId,
      "modelId": modelId,
      "parentAccountId": parentAccountId,
      "registeredDate": registeredDate?.toIso8601String(),
      "tireSizeId": tireSizeId,
      "typeId": typeId,
      "vehicleNumber": vehicleNumber,
      "mileageType": mileageType,
      "manufacturer": manufacturer,
      "typeName": typeName,
      "modelName": modelName,
      "hoursDate": hoursDate?.toIso8601String(),
      "vehjsonFootprint": vehjsonFootprint,
      "tireSize": tireSize,
      "axleConfig": axleConfig,
      "areaOfOperation": areaOfOperation,
      "modifications": modifications,
      "imagesLocation": imagesLocation,
      "installedTireCount": installedTireCount,
      "axleConfigId": axleConfigId,
      "currentMiles": currentMiles,
      "currentHours": currentHours,
      "averageLoadingReqId": averageLoadingReqId,
      "averageLoadingReq": averageLoadingReq,
      "speedId": speedId,
      "speed": speed,
      "cutting": cutting,
      "cuttingId": cuttingId,
      "removalTread": removalTread,
      "trackingMethod": trackingMethod,
      "severityComments": severityComments,
      "recommendedPressure": recommendedPressure,
    };

    /// 👇 vehicleId sirf tab bhejo jab NOT NULL ho (EDIT case)
    if (vehicleId != null) {
      data["vehicleId"] = vehicleId;
    }

    return data;
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      vehicleId: _toInt(json['vehicleId']),
      parentAccountId: _toInt(json['parentAccountId']),
      parentAccountName: json['parentAccountName'],

      locationId: _toInt(json['locationId']),
      locationName: json['locationName'],

      manufacturerId: _toInt(json['manufacturerId']),
      manufacturer: json['manufacturer'],

      modelId: _toInt(json['modelId']),
      modelName: json['modelName'],

      typeId: _toInt(json['typeId']),
      typeName: json['typeName'],

      tireSizeId: _toInt(json['tireSizeId']),
      tireSize: json['tireSize'],

      vehicleNumber: json['vehicleNumber'],
      registeredDate: _toDate(json['registeredDate']),

      mileageType: _toInt(json['mileageType']),
      trackingMethod: _toInt(json['trackingMethod']),

      currentMiles: _toDouble(json['currentMiles']),
      currentHours: _toDouble(json['currentHours']),
      removalTread: _toDouble(json['removalTread']),

      axleConfig: json['axleConfig'],
      axleConfigId: _toInt(json['axleConfigId']),

      areaOfOperation: json['areaOfOperation'],
      modifications: json['modifications'],
      imagesLocation: json['imagesLocation'],

      recommendedPressure: _toDouble(json['recommendedPressure']),
      severityComments: json['severityComments'],

      installedTireCount: _toInt(json['installedTireCount']),
      isEditable: _toBool(json['isEditable']),

      assetNumber: json['assetNumber'],
      hasMultipleTireSizes: _toBool(json['hasMultipleTireSizes']),
      multipleTireSizeIds: json['multipleTireSizeIds'],
      vehjsonFootprint: json['vehjsonFootprint'],

      hoursDate: _toDate(json['hoursDate']),
      createdDate: _toDate(json['createdDate']),
      createdBy: json['createdBy'],
      updatedDate: _toDate(json['updatedDate']),
      updatedBy: json['updatedBy'],
      lastUpdatedDate: _toDate(json['lastUpdatedDate']),

      averageLoadingReqId: _toInt(json['averageLoadingReqId']),
      averageLoadingReq: json['averageLoadingReq'],
      speedId: _toInt(json['speedId']),
      speed: json['speed'],
      cutting: json['cutting'],
      cuttingId: _toInt(json['cuttingId']),

      vehicleHistory: (json['vehicleHistory'] as List?)
          ?.map((e) => VehicleHistory.fromJson(e))
          .toList(),
    );
  }
}

int? _toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is String) return int.tryParse(v);
  if (v is double) return v.toInt();
  return null;
}

double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

bool? _toBool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is String) return v.toLowerCase() == 'true';
  if (v is int) return v == 1;
  return null;
}

DateTime? _toDate(dynamic v) {
  if (v == null) return null;
  if (v is String) return DateTime.tryParse(v);
  return null;
}
