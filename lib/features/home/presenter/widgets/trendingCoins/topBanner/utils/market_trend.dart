
///Returns a trend according to the given [percentage]
String getMarketTrendAsString(double? percentage){
  if(percentage != null){
    if(percentage > 0){
      return "uptrend";
    }else if(percentage < 0){
      return "downtrend";
    }else{
      return "balanced";
    }
  }else {
    return "unknown";
  }
}