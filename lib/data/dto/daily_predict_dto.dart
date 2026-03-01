final class DailyPredictDto {
  DailyPredictDto.fromJson(Map<String, dynamic> json)
      : predict = (json['prediction']) as String;

  final String predict;
}
