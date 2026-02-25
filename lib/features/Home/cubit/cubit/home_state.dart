
import 'package:graduation_project/features/Home/models/property_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PropertyModel> properties;

  HomeLoaded(this.properties);
}
