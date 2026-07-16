enum ViewStatus { idle, loading, success, empty, failure, paginating }

class ViewState<T> {
  const ViewState._({
    required this.status,
    this.data,
    this.message,
    this.requestId,
  });

  final ViewStatus status;
  final T? data;
  final String? message;
  final String? requestId;

  factory ViewState.idle() => const ViewState._(status: ViewStatus.idle);

  factory ViewState.loading() => const ViewState._(status: ViewStatus.loading);

  factory ViewState.success(T data) =>
      ViewState._(status: ViewStatus.success, data: data);

  factory ViewState.empty() => const ViewState._(status: ViewStatus.empty);

  factory ViewState.failure(String message, {String? requestId}) => ViewState._(
    status: ViewStatus.failure,
    message: message,
    requestId: requestId,
  );

  factory ViewState.paginating(T data) =>
      ViewState._(status: ViewStatus.paginating, data: data);
}
