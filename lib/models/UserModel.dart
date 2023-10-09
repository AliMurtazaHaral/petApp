class UserModel {
  String? email;
  String? username;
  String? password;
  String? animal_name;
  String? animal_image;
  String? animal_kingdom;
  String? animal_class;
  String? animal_order;
  String? animal_species;

  UserModel({
    this.email,
    this.username,
    this.password,
    this.animal_name,
    this.animal_image,
    this.animal_kingdom,
    this.animal_class,
    this.animal_order,
    this.animal_species
  });

  // receiving data from server
  factory UserModel.fromMapRegsitration(map) {
    return UserModel(
      email: map['email'],
      username: map['username'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMapRegistrationDetails() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromAnimalDetails(map) {
    return UserModel(
      animal_image: map['animal_image'],
      animal_name: map['animal_name'],
      animal_kingdom: map['animal_kingdom'],
      animal_class: map['animal_class'],
      animal_order: map['animal_order'],
      animal_species: map['animal_species']

    );
  }

  // sending data to our server
  Map<String, dynamic> toMapAnimalDetails() {
    return {
      'animal_name': animal_name,
      'animal_image': animal_image,
      'animal_kingdom': animal_kingdom,
      'animal_class': animal_class,
      'animal_order': animal_order,
      'animal_species': animal_species
    };
  }

  Map<String, dynamic> toMapUpdateDetails() {
    return {
      'username': username,
      'password': password,
    };
  }

  Map<String, dynamic> toMapUpdateRegistration() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }
}