/// Contains the test data that is then displayed in "view my tests". Its fields are
///
/// [date] Date of the test
/// [hand] Hand the test is done with
/// [displayed] Number of symbols displayed in total
/// [mistakes] Number of mistakes made
class Test{
  DateTime? date;
  String? hand; // 'L' o 'R'
  int? displayed;
  int? mistakes;

  Test({this.date, this.hand, this.displayed, this.mistakes});

  ///Assigns the argument [d] to [date]
  void setDate(DateTime d){
    date = d;
  }
  ///Assigns the argument [h] to [hand]
  void setHand(String h){
    hand = h;
  }

  ///Assigns the argument [d] to [displayed]
  void setDisplayed(int d){
    displayed = d;
  }

  ///Assigns the argument [m] to [mistakes]
  void setMistakes(int m){
    mistakes = m;
  }

  /// Creates a Map in JSon format so data can be saved in SharedPreferences
  Map<String,dynamic> toJson() => {
    'date': date?.toIso8601String(),
    'hand': hand,
    'displayed': displayed,
    'mistakes': mistakes,
  };

  /// Takes the Map [json] as an argument and assigns values to [date], [hand], [displayed] and [mistakes]
  /// Used when loading data from SharedPreferences
  factory Test.fromJson(Map<String, dynamic> json) => Test(
    date: DateTime.parse(json['date']),
    hand: json['hand'],
    displayed: json['displayed'],
    mistakes: json['mistakes'],
  );

}