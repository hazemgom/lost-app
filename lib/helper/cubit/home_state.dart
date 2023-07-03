part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ShopChangeBottomNavState extends HomeState {}

class GetSuccessUserDataState extends HomeState {}

class GetLoadingUserDataState extends HomeState {}

class GetErrorUserDataState extends HomeState {}

class UpdateSuccessUserDataState extends HomeState {}

class UpdateLoadingUserDataState extends HomeState {}

class UpdateErrorUserDataState extends HomeState {}

class GetPostsLoadingHomePageStates extends HomeState {}

class GetPostsSuccessHomePageStates extends HomeState {}

class GetPostsErrorHomePageStates extends HomeState {}

class CreatePostSuccessHomePageStates extends HomeState {}

class CreatePostLoadingHomePageStates extends HomeState {}

class CreatePostErrorHomePageStates extends HomeState {}

class CommentLoadingState extends HomeState {}

class CommentSuccessState extends HomeState {}

class CommentErrorState extends HomeState {}

class RemoveImageFile extends HomeState {}

class deletepost extends HomeState {}
class deletepostlo extends HomeState {}

class ImagePostSuccess extends HomeState {}
class ImagePostError extends HomeState {}
