import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_apis/busssiness_logic/cubit/user_cubit.dart';
import 'package:practice_apis/data/models/usermodel.dart';
import 'package:practice_apis/presentation/widgets/card_item/card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Usermodel> usersList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            usersList = state.users;
            return ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return CardItem(usermodel: usersList[index]);
              },
            );
          } else if (state is UserError) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Error',
                    desc: state.message,
                    btnOkOnPress: () {},
                  ).show();
                },
                child: const Text("Show Error"),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
