import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:user_list/src/themes/themes.dart'; // Import the theme file
import '../blocs/user_bloc.dart';
import '../blocs/user_event.dart';
import '../blocs/user_state.dart';
import '../repositories/user_repository.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final RefreshController _refreshController = RefreshController(); // Controller for pull-to-refresh
  final TextEditingController _searchController = TextEditingController(); // Controller for search text field
  String _searchQuery = ''; // Search query string
  bool _isDarkMode = true; // Flag to track the current theme mode

  // Function to refresh the user list
  void _onRefresh(BuildContext context) {
    context.read<UserBloc>().add(FetchUsers());
    _refreshController.refreshCompleted();
  }

  // Function to handle search input
  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  // Function to toggle the theme mode
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: _isDarkMode ? darkTheme : lightTheme, // Apply theme based on _isDarkMode flag
      home: Scaffold(
        body: Container(
          child: BlocProvider(
            create: (context) => UserBloc(userRepository: UserRepository())..add(FetchUsers()), // Initialize UserBloc and fetch users
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                // Display loading indicator while fetching data
                if (state is UserInitial || state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  // Filter users based on the search query
                  final filteredUsers = state.users.where((user) {
                    return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           user.email.toLowerCase().contains(_searchQuery.toLowerCase());
                  }).toList();

                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () => _onRefresh(context),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 150.0,
                          floating: false,
                          pinned: true,
                          flexibleSpace: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: FlexibleSpaceBar(
                                  titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                                  title: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      var top = constraints.biggest.height;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: top > 70 ? 0 : 16,
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'User List',
                                            style: TextStyle(
                                              fontSize: top > 70 ? 24 : 14,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  centerTitle: false,
                                  collapseMode: CollapseMode.parallax,
                                ),
                              ),
                              PreferredSize(
                                preferredSize: Size.fromHeight(56.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search users',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      prefixIcon: Icon(Icons.search, color: Colors.blue),
                                    ),
                                    onChanged: _onSearch,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              PreferredSize(
                                preferredSize: Size.fromHeight(1.0),
                                child: LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints) {
                                    var top = constraints.biggest.height;
                                    return Visibility(
                                      visible: top <= 80,
                                      child: Container(
                                        height: 1.0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            // Toggle button for theme switch
                            IconButton(
                              icon: Icon(_isDarkMode ? Icons.toggle_on : Icons.toggle_off, size: 50,),
                              onPressed: _toggleTheme,
                            ),
                          ],
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Column(
                                children: [
                                  UserCard(user: filteredUsers[index]), // Display user card
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Divider(height: 1.0,),
                                  ),
                                ],
                              );
                            },
                            childCount: filteredUsers.length,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is UserError) {
                  return Center(child: Text(state.message)); // Display error message
                } else {
                  return Center(child: Text('Unknown error')); // Handle unknown error state
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
