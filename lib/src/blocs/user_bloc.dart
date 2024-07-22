import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final users = await userRepository.fetchUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to fetch users'));
    }
  }
}
