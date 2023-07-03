import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_stone/feature/onboarding/onboarding_cubit/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>
{
  OnBoardingCubit() : super(InitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  bool isLastPage = false;

  void listenPageLastIndex(bool isLast)
  {
    isLastPage = isLast;
    emit(ChangePageLastIndexState());
  }
}