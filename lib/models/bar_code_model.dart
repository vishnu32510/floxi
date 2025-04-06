class BarCodeModel {
  String? barcode;
  String? brands;
  String? categories;
  Ecoscore? ecoscore;
  String? imageUrl;
  String? productNameEn;
  String? productType;
  List<Recommendations>? recommendations;

  BarCodeModel(
      {this.barcode,
      this.brands,
      this.categories,
      this.ecoscore,
      this.imageUrl,
      this.productNameEn,
      this.productType,
      this.recommendations});

  BarCodeModel.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
    brands = json['brands'];
    categories = json['categories'];
    ecoscore = json['ecoscore'] != null
        ? new Ecoscore.fromJson(json['ecoscore'])
        : null;
    imageUrl = json['image_url'];
    productNameEn = json['product_name_en'];
    productType = json['product_type'];
    if (json['recommendations'] != null) {
      recommendations = <Recommendations>[];
      json['recommendations'].forEach((v) {
        recommendations!.add(new Recommendations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcode'] = this.barcode;
    data['brands'] = this.brands;
    data['categories'] = this.categories;
    if (this.ecoscore != null) {
      data['ecoscore'] = this.ecoscore!.toJson();
    }
    data['image_url'] = this.imageUrl;
    data['product_name_en'] = this.productNameEn;
    data['product_type'] = this.productType;
    if (this.recommendations != null) {
      data['recommendations'] =
          this.recommendations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ecoscore {
  int? sumOfBonusesAndMaluses;
  String? adjustments;
  EcoImpact? ecoImpact;
  String? gradeOverall;
  int? lifeCycleAnalysisScore;
  String? ref;
  int? score;

  Ecoscore(
      {this.sumOfBonusesAndMaluses,
      this.adjustments,
      this.ecoImpact,
      this.gradeOverall,
      this.lifeCycleAnalysisScore,
      this.ref,
      this.score});

  Ecoscore.fromJson(Map<String, dynamic> json) {
    sumOfBonusesAndMaluses = json['Sum_of_bonuses_and_maluses'];
    adjustments = json['adjustments'];
    ecoImpact = json['eco_impact'] != null
        ? new EcoImpact.fromJson(json['eco_impact'])
        : null;
    gradeOverall = json['grade_overall'];
    lifeCycleAnalysisScore = json['life_cycle_analysis_score'];
    ref = json['ref'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sum_of_bonuses_and_maluses'] = this.sumOfBonusesAndMaluses;
    data['adjustments'] = this.adjustments;
    if (this.ecoImpact != null) {
      data['eco_impact'] = this.ecoImpact!.toJson();
    }
    data['grade_overall'] = this.gradeOverall;
    data['life_cycle_analysis_score'] = this.lifeCycleAnalysisScore;
    data['ref'] = this.ref;
    data['score'] = this.score;
    return data;
  }
}

class EcoImpact {
  List<ImpactBreakdown>? impactBreakdown;

  EcoImpact({this.impactBreakdown});

  EcoImpact.fromJson(Map<String, dynamic> json) {
    if (json['impactBreakdown'] != null) {
      impactBreakdown = <ImpactBreakdown>[];
      json['impactBreakdown'].forEach((v) {
        impactBreakdown!.add(new ImpactBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.impactBreakdown != null) {
      data['impactBreakdown'] =
          this.impactBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImpactBreakdown {
  String? iconIdentifier;
  double? impactPercentage;
  String? stageName;

  ImpactBreakdown({this.iconIdentifier, this.impactPercentage, this.stageName});

  ImpactBreakdown.fromJson(Map<String, dynamic> json) {
    iconIdentifier = json['iconIdentifier'];
    impactPercentage = json['impactPercentage'];
    stageName = json['stageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iconIdentifier'] = this.iconIdentifier;
    data['impactPercentage'] = this.impactPercentage;
    data['stageName'] = this.stageName;
    return data;
  }
}

class Recommendations {
  String? brand;
  String? carbonFootprint;
  String? ecoscoreGrade;
  String? productName;
  String? reason;

  Recommendations(
      {this.brand,
      this.carbonFootprint,
      this.ecoscoreGrade,
      this.productName,
      this.reason});

  Recommendations.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    carbonFootprint = json['carbon_footprint'];
    ecoscoreGrade = json['ecoscore_grade'];
    productName = json['product_name'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['carbon_footprint'] = this.carbonFootprint;
    data['ecoscore_grade'] = this.ecoscoreGrade;
    data['product_name'] = this.productName;
    data['reason'] = this.reason;
    return data;
  }
}
