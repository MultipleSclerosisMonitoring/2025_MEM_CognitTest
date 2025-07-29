import 'package:symbols/utils/constants.dart';
import 'package:symbols/utils/test.dart';

/// The different users in the app are instances of this class. Its fields are
///
/// [nickname] Nickname used to identify the user
///
/// [sex] Sex ('M' for male 'F' for female)
///
/// [levelOfStudies] Level of finished studies (1 for primary, 2 for secondary, G for degree, M for master, D for doctorate)
///
/// [dateOfBirth] Date of birth
///
/// [testList] List of the class [Test] with all the completed tests of the profile
///
/// [isSymbols1] Variable that determines the set of symbols used for the test
/// (true for the set [GeneralConstants.symbols1] and false for the set [GeneralConstants.symbols2]
class Profile{
  String? nickname;
  String? sex; //'F' o 'M'
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

  /// Assigns the argument [b] to [isSymbols1]
  void setIsSymbols1(bool b){
    isSymbols1 = b;
  }

  /// Assigns the argument [s] to [sex]
  void setSex(String s){
    sex = s;
  }

  /// Assigns the argument [l] to [levelOfStudies]
  void setLevelOfStudies (String l){
    levelOfStudies = l;
  }

  /// Assigns the argument [n] to [nickname]
  void setNickname(String n){
    nickname = n;
  }

  /// Receives a test instance [t] as an argument and adds it to the [testList]. If the list does not exist, it creates one and adds the new test.
  void addTest(Test t){
    if(testList != null) {
      testList!.add(t);
    } else{
      testList = [];
      testList!.add(t);
    }
  }


  /// Creates a Map in Json format so data can be saved in SharedPreferences
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

  /// Takes the Map [json] as an argument and assigns values to [nickname], [dateOfBirth], [sex], [levelOfStudies], [testList] and [isSymbols1]
  /// Used when loading data from SharedPreferences
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