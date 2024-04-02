
extension StringExtension on Iterable<String> {

  List<String> get joinSqlFields => map((e) => "'$e'").toList();

  String get valuesMarkSqlFields => "( ${map((e) => '?').join(", ")} )";
}