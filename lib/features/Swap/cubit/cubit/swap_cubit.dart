import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/Swap/model/SwapRequestModel.dart';
import 'swap_state.dart';

class SwapCubit extends Cubit<SwapState> {
  SwapCubit() : super(const SwapState());

  void sendSwapRequest(SwapRequestModel request) {
    final updatedRequests = List<SwapRequestModel>.from(state.requests)..add(request);
    emit(state.copyWith(requests: updatedRequests));
  }

  void acceptRequest(int index) {
    final updatedRequests = state.requests
        .asMap()
        .entries
        .map((entry) => entry.key == index
            ? entry.value.copyWith(status: SwapStatus.accepted)
            : entry.value)
        .toList();
    emit(state.copyWith(requests: updatedRequests));
  }

  void rejectRequest(int index) {
    final updatedRequests = state.requests
        .asMap()
        .entries
        .map((entry) => entry.key == index
            ? entry.value.copyWith(status: SwapStatus.rejected)
            : entry.value)
        .toList();
    emit(state.copyWith(requests: updatedRequests));
  }
}