import 'package:symbols/utils/test.dart';

class Profile{
  String? nickname;
  String? sex; //'H' o 'M'
  String? levelOfStudies; // '1' '2' 'G' 'M' 'D'
  DateTime? dateOfBirth;
  List<Test>? testList;
  bool? isSymbols1;

  Profile({
    this.nickname,
    this.sex,
    this.levelOfStudies,
    this.dateOfBirth,
    this.testList,
    this.isSymbols1,
  });


  void setIsSymbols1(bool b){
    isSymbols1 = b;
  }

  void setSex(String s){
    sex = s;
  }

  void setLevelOfStudies (String l){
    levelOfStudies = l;
  }

  void setNickname(String n){
    nickname = n;
  }

  void addTest(Test t){
    if(testList != null)
      testList!.add(t);
    else{
      testList = [];
      testList!.add(t);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'sex': sex,
      'levelOfStudies': levelOfStudies,
      'testList': testList?.map((test) => test.toJson()).toList(),
      'isSymbols1': isSymbols1,
    };
  }
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      nickname: json['nickname'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : DateTime(2000,1,1),
      sex: json['sex'].toString() ?? '',
      levelOfStudies: json['levelOfStudies'].toString() ?? '',
      testList: json['testList'] != null ? (json['testList'] as List<dynamic>).map((test) => Test.fromJson(test)).toList() : [],
      isSymbols1: json['isSymbols1'] ?? true,
    );
  }

}