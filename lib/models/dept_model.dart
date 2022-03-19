// @dart=2.9
class Debt {
  int _id;
  String _name;
  String _reason;
  int _value;
  String _date;

  Debt(dynamic obj) {
    _id = obj["id"];
    _name = obj["name"];
    _reason = obj["reason"];
    _value = obj["value"];
    _date = obj["date"];
  }

  Debt.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _name = map["name"];
    _reason = map["reason"];
    _value = map["value"];
    _date = map["date"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "name": _name,
      "reason": _reason,
      "value": _value,
      "date": _date,
    };
  }

  int get value => _value;

  String get reason => _reason;

  String get name => _name;

  int get id => _id;

  String get date => _date;
}
