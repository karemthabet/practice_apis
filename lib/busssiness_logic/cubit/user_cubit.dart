import 'package:bloc/bloc.dart';
import 'package:practice_apis/data/api/api_service.dart';
import 'package:practice_apis/data/models/usermodel.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  getAllUsers() async {
    emit(UserLoading());

    var response = await ApiService.get(endPoint: "users");
    response.fold((fail) => emit(UserError(message: fail.errMessage)),
        (jsonData) {
      List<Usermodel> getAllUsersList = [];

      for (var user in jsonData) {
        getAllUsersList.add(Usermodel.fromJson(user));
        emit(UserSuccess(users: getAllUsersList));
      }
    });
  }

}
