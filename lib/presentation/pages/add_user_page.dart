import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/validators.dart';
import '../cubits/add_user/add_user_cubit.dart';
import '../cubits/add_user/add_user_state.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedGender = 'male';
  String _selectedStatus = 'active';

  @override
  void initState() {
    super.initState();
    // Reset state when page opens
    context.read<AddUserCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User'), elevation: 0),
      body: BlocListener<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User added successfully')),
            );
            Navigator.pop(context, true);
          } else if (state is AddUserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNameField(),
                SizedBox(height: 16.h),
                _buildEmailField(),
                SizedBox(height: 16.h),
                _buildGenderDropdown(),
                SizedBox(height: 16.h),
                _buildStatusDropdown(),
                SizedBox(height: 24.h),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) => Validators.validateName(value),
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) => Validators.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.people),
      ),
      items: const [
        DropdownMenuItem(value: 'male', child: Text('Male')),
        DropdownMenuItem(value: 'female', child: Text('Female')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Status',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.toggle_on),
      ),
      items: const [
        DropdownMenuItem(value: 'active', child: Text('Active')),
        DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedStatus = value!;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AddUserCubit, AddUserState>(
      builder: (context, state) {
        final isLoading = state is AddUserLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.h),
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Add User'),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AddUserCubit>().addUser(
        name: _nameController.text,
        email: _emailController.text,
        gender: _selectedGender,
        status: _selectedStatus,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
