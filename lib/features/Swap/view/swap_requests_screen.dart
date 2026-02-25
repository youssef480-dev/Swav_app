import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/Swap/cubit/cubit/swap_cubit.dart';
import 'package:graduation_project/features/Swap/cubit/cubit/swap_state.dart';
import 'package:graduation_project/features/Swap/model/SwapRequestModel.dart';


class SwapRequestsScreen extends StatelessWidget {
  const SwapRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Swap Requests")),
      body: BlocBuilder<SwapCubit, SwapState>(
        builder: (context, state) {
          final requests = state.requests;

          if (requests.isEmpty) {
            return const Center(child: Text("No Swap Requests"));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text("${request.offeredProductName} ➜ ${request.requestedProductName}"),
                  subtitle: Text("Status: ${request.status.name}"),
                  trailing: request.status == SwapStatus.pending
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.green),
                              onPressed: () => context.read<SwapCubit>().acceptRequest(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => context.read<SwapCubit>().rejectRequest(index),
                            ),
                          ],
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}