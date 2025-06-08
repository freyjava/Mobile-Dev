

class Student {
  Student({
    this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.phone,
    required this.className,
    required this.department,
    required this.dateRegistered,
    this.present = false,
  });

  int? id;
  String name;
  String gender;
  String email;
  String phone;
  String className;
  String department;
  String dateRegistered;
  bool present;

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'gender':gender,
      'email':email,
      'phone':phone,
      'className':className,
      'department':department,
      'dateRegistered':dateRegistered,
      'present': present? 1: 0,
    };
  }

  factory Student.fromMap(Map<String,dynamic> map){
    return Student(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      email: map['email'],
      phone: map['phone'],
      className: map['className'],
      department: map['department'],
      dateRegistered: map['dateRegistered'],
      present: map['present'] == 1,
    );
  }

  Student copyWith({
    int? id,
    String? name,
    String? gender,
    String? email,
    String? phone,
    String? className,
    String? department,
    String? dateRegistered,
    bool? present,
  }){
    return Student(
      name: name ?? this.name, 
      gender: gender ?? this.gender, 
      email: email ?? this.email, 
      phone: phone ?? this.phone, 
      className: className ?? this.className, 
      department: department ?? this.department, 
      dateRegistered: dateRegistered ?? this.dateRegistered,
      );
  }
}

