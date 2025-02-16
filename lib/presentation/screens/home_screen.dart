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
  List<Usermodel> searchedList = [];
  bool isSearched = false;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getAllUsers();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.blue,
      decoration: const InputDecoration(
        hintText: "Find a user",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style: const TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (searchedNameOfUser) {
        addSearchedItemsToList(searchedNameOfUser);
      },
    );
  }

  void addSearchedItemsToList(String searchedNameOfUser) {
    if (searchedNameOfUser.isEmpty) {
      searchedList = usersList;
    } else {
      searchedList = usersList
          .where((user) =>
              user.name?.toLowerCase().startsWith(searchedNameOfUser.toLowerCase()) ?? false)
          .toList();
    }
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (isSearched) {
      return [
        IconButton(
          onPressed: _stopSearching,
          icon: const Icon(Icons.clear),
          color: Colors.grey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearching,
          icon: const Icon(Icons.search),
          color: Colors.grey,
        ),
      ];
    }
  }

  void _startSearching() {
    setState(() {
      isSearched = true;
      searchedList = usersList;
    });
  }

  void _stopSearching() {
    setState(() {
      searchTextController.clear();
      isSearched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearched
            ? _buildSearchField()
            : const Text(
                "Users",
                style: TextStyle(color: Colors.black),
              ),
        actions: [..._buildAppBarActions()],
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            usersList = state.users;
            final displayedList = isSearched ? searchedList : usersList;
            
            if (isSearched && displayedList.isEmpty) {
              return const Center(
                child: Text(
                  "No user found with that name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: displayedList.length,
              itemBuilder: (context, index) {
                return CardItem(usermodel: displayedList[index]);
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
