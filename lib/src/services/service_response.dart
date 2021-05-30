class ServiceResponse<T> {
 bool result;
   T value;
   String errorMsg;

  ServiceResponse({this.result, this.value, this.errorMsg});
}
