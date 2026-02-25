
import 'package:graduation_project/features/Swap/model/SwapRequestModel.dart';

class SwapState {
  final List<SwapRequestModel> requests;

  const SwapState({this.requests = const []});

  SwapState copyWith({List<SwapRequestModel>? requests}) {
    return SwapState(
      requests: requests ?? this.requests,
    );
  }
}