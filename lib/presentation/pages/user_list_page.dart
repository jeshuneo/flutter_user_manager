import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/responsive_helper.dart';
import '../cubits/user_list/user_list_cubit.dart';
import '../cubits/user_list/user_list_state.dart';
import '../widgets/user_card.dart';
import 'add_user_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    // Widget Lifecycle: initState called once when widget is inserted
    context.read<UserListCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<UserListCubit>().refreshUsers();
            },
          ),
        ],
      ),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            return ResponsiveHelper.isTablet(context)
                ? _buildGridView(state.users)
                : _buildListView(state.users);
          } else if (state is UserListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserListCubit>().loadUsers();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddUserPage()),
          );
          if (result == true) {
            context.read<UserListCubit>().refreshUsers();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(List<dynamic> users) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserListCubit>().refreshUsers();
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }

  Widget _buildGridView(List<dynamic> users) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserListCubit>().refreshUsers();
      },
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveHelper.isDesktop(context) ? 3 : 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    // Widget Lifecycle: Clean up resources
    super.dispose();
  }
}
