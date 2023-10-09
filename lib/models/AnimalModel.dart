class QRModel{
  String? animal_id;
  String? animal_name;
  String? animal_habitat;
  String? animal_fact;
  String? animal_sound;
  String? animal_image;

  QRModel({
    this.animal_id,
    this.animal_name,
    this.animal_habitat,
    this.animal_fact,
    this.animal_sound,
    this.animal_image
});

  factory QRModel.fromMapAnimals(map){
    return QRModel(
        animal_id: map['animal_id'],
        animal_name: map['animal_ame'],
        animal_habitat: map['habitat'],
        animal_fact : map['animal_fact'],
        animal_image: map['animal_image'],
        animal_sound: map['animal_sound'],
    );
  }

  Map<String, dynamic> toMapAnimalsDetails(){
    return{
      'animal_id':animal_id,
      'animal_name':animal_name,
      'animal_habitat':animal_habitat,
      'animal_fact': animal_fact,
      'animal_image':animal_image,
      'animal_sound': animal_sound
    };
  }

}