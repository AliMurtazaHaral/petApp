class ReportingModel{
  String? description;
  String? image;
  String? lat;
  String? lng;

  ReportingModel({
    this.description,
    this.image,
    this.lat,
    this.lng
      });

  factory ReportingModel.fromMapReport(map){
    return ReportingModel(
      description: map['description'],
      image: map['image'],
      lat: map['lat'],
      lng: map['lng']
    );
  }
  Map<String, dynamic> toMapReportDetails(){
    return{
      'description': description,
      'image': image,
      'lat': lat,
      'lng': lng
    };
  }

}