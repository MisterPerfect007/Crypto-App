double calculate7DPercentage(lastWeekData) {
  return (100 * (lastWeekData[lastWeekData.length -1] - lastWeekData[0])) / lastWeekData[0];
}