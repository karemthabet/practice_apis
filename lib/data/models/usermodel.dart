class Usermodel {
	int? id;
	String? name;
	String? email;
	String? gender;
	String? status;

	Usermodel({this.id, this.name, this.email, this.gender, this.status});

	factory Usermodel.fromJson(dynamic json) => Usermodel(
				id: json['id'] as int?,
				name: json['name'] as String?,
				email: json['email'] as String?,
				gender: json['gender'] as String?,
				status: json['status'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'email': email,
				'gender': gender,
				'status': status,
			};
}
