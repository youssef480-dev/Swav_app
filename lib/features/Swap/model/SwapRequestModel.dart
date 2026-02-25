enum SwapStatus { pending, accepted, rejected }

class SwapRequestModel {
  final String requestedProductName;
  final String offeredProductName;
  final String ownerName;
  final String message;
  SwapStatus status;

  SwapRequestModel({
    required this.requestedProductName,
    required this.offeredProductName,
    required this.ownerName,
    required this.message,
    this.status = SwapStatus.pending,
  });

  SwapRequestModel copyWith({
    String? requestedProductName,
    String? offeredProductName,
    String? ownerName,
    String? message,
    SwapStatus? status,
  }) {
    return SwapRequestModel(
      requestedProductName: requestedProductName ?? this.requestedProductName,
      offeredProductName: offeredProductName ?? this.offeredProductName,
      ownerName: ownerName ?? this.ownerName,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}