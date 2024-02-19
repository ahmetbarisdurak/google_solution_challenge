class BuildingInfo {
  int countFloors;
  int ageBuilding;
  double plinthAreaSqFt;
  double heightFt;
  String landSurfaceCondition;
  String foundationType;
  String groundFloorType;
  String otherFloorType;
  String position;
  String planConfiguration;
  double damageGrade;

  BuildingInfo({
    required this.countFloors,
    required this.ageBuilding,
    required this.plinthAreaSqFt,
    required this.heightFt,
    required this.landSurfaceCondition,
    required this.foundationType,
    required this.groundFloorType,
    required this.otherFloorType,
    required this.position,
    required this.planConfiguration,
    required this.damageGrade,
  });

  Map<String, dynamic> toJson() {
    return {
      'countFloors': countFloors,
      'ageBuilding': ageBuilding,
      'plinthAreaSqFt': plinthAreaSqFt,
      'heightFt': heightFt,
      'landSurfaceCondition': landSurfaceCondition,
      'foundationType': foundationType,
      'groundFloorType': groundFloorType,
      'otherFloorType': otherFloorType,
      'position': position,
      'planConfiguration': planConfiguration,
      'damageGrade': damageGrade,
    };
  }

  List<double> toInputArray() {
    // Örneğin, kategorik verileri one-hot encoding yöntemiyle dönüştürme
    var landSurfaceConditionIndex = _landSurfaceConditionIndex(landSurfaceCondition);
    var foundationTypeIndex = _foundationTypeIndex(foundationType);
    var groundFloorTypeIndex = _groundFloorTypeIndex(groundFloorType);
    var otherFloorTypeIndex = _otherFloorTypeIndex(otherFloorType);
    var positionIndex = _positionIndex(position);
    var planConfigurationIndex = _planConfigurationIndex(planConfiguration);

    return [
      countFloors.toDouble(),
      ageBuilding.toDouble(),
      plinthAreaSqFt,
      heightFt,
      landSurfaceConditionIndex,
      foundationTypeIndex,
      groundFloorTypeIndex,
      otherFloorTypeIndex,
      positionIndex,
      planConfigurationIndex,
    ];
  }

  double _landSurfaceConditionIndex(String condition) {
    switch (condition) {
      case 'Flat':
        return 0.0;
      case 'Moderate slope':
        return 1.0;
      case 'Steep slope':
        return 2.0;
      default:
        return 0.0;
    }
  }

  double _foundationTypeIndex(String type) {
    switch (type) {
      case 'Mud mortar-Stone/Brick':
        return 0.0;
      case 'Bamboo/Timber':
        return 1.0;
      case 'RC':
        return 2.0;
      case 'Other':
        return 3.0;
      default:
        return 0.0;
    }
  }

  double _groundFloorTypeIndex(String type) {
    switch (type) {
      case 'Not applicable':
        return 0.0;
      case 'Mud':
        return 1.0;
      case 'Wood':
        return 2.0;
      case 'Other':
        return 3.0;
      default:
        return 0.0;
    }
  }

  double _otherFloorTypeIndex(String type) {
    switch (type) {
      case 'Not applicable':
        return 0.0;
      case 'Mud':
        return 1.0;
      case 'Wood':
        return 2.0;
      case 'Other':
        return 3.0;
      default:
        return 0.0;
    }
  }

  double _positionIndex(String position) {
    switch (position) {
      case 'Not attached':
        return 0.0;
      case 'Attached-1 side':
        return 1.0;
      case 'Attached-2 sides':
        return 2.0;
      case 'Attached-3 sides':
        return 3.0;
      default:
        return 0.0;
    }
  }

  double _planConfigurationIndex(String configuration) {
    switch (configuration) {
      case 'Rectangular':
        return 0.0;
      case 'Square':
        return 1.0;
      case 'L-shape':
        return 2.0;
      case 'T-shape':
        return 3.0;
      case 'Other':
        return 4.0;
      default:
        return 0.0;
    }
  }

}
