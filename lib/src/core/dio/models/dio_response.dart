enum DioStatus { success, failure, unauthorized }

class DioResponse {
  final dynamic data;
  final DioStatus status;

  DioResponse({required this.data, required this.status});
}
