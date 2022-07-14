
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/errors/failures.dart';

ErrorType giveErrorType(Failure failure){
  if(failure is NoConnectionFailure){
    return ErrorType.noInternetConnection;
  }
  return ErrorType.failedRequest;
}