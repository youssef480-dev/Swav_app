import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/Home/cubit/cubit/home_state.dart';
import 'package:graduation_project/features/Home/models/property_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) =>
      BlocProvider.of<HomeCubit>(context);

  void loadProperties() {
    final properties = [
      PropertyModel(
        image: "assets/images/onboarding1.png",
        title: "Apartment in New Cairo",
        price: "250,000 EGP",
        details: "3 beds • 2 baths • 150 sqm",
      ),
      PropertyModel(
        image: "assets/images/onboarding1.png",
        title: "Villa in October",
        price: "1,200,000 EGP",
        details: "5 beds • 4 baths • 400 sqm",
      ),
    ];

    emit(HomeLoaded(properties));
  }
}
