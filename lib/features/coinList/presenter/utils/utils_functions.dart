double? calculate7DPercentage(List<double>? lastWeekData) {
  if(lastWeekData != null && lastWeekData.isNotEmpty){
    return double.parse((100 * (lastWeekData[lastWeekData.length - 1] - lastWeekData[0]) / lastWeekData[0]).toStringAsFixed(5));
  }else {
    return null;
  }
}