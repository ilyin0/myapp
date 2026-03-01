final class DailyPredictDto {
  DailyPredictDto.fromJson(Map<String, dynamic> json)
      : predict = json['description'];

  final String predict;
}
