class Test{
  DateTime? date;
  String? hand; // 'L' o 'R'
  int? displayed;
  int? mistakes;

  Test({this.date, this.hand, this.displayed, this.mistakes});

  void setDate(DateTime d){
    date = d;
  }

  void setHand(String h){
    hand = h;
  }

  void setDisplayed(int d){
    displayed = d;
  }

  void setMistakes(int m){
    mistakes = m;
  }

  Map<String,dynamic> toJson() => {
    'date': date?.toIso8601String(),
    'hand': hand,
    'displayed': displayed,
    'mistakes': mistakes,
  };

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    date: DateTime.parse(json['date']),
    hand: json['hand'],
    displayed: json['displayed'],
    mistakes: json['mistakes'],
  );

}