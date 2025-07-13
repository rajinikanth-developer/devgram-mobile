import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/button_widgets.dart';
import '../../../../core/common_widgets/loader_widget.dart';
import '../../../../core/common_widgets/parent_widget.dart';
import '../../../../core/common_widgets/rich_text_widget.dart';
import '../../../../core/common_widgets/snackbar_widget.dart';
import '../../../../core/common_widgets/text_widget.dart';
import '../../../../core/constants/path_constants.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../../core/constants/strings/validation_messages.dart';
import '../../../../core/utils/app_validators.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedGender;
  DateTime? selectedDOB;

  bool _obscurePassword = true;
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      context: context,
      childWidget: _buildSignupForm(),
      hasHeader: false,
    );
  }

  Widget _buildSignupForm() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingState) {
          LoaderWidget().show(context);
        } else if (state is SuccessState) {
          LoaderWidget().hide();
          SnackBarWidget(
            context: context,
            message: AppValidationMessages.regSuccess,
            messageType: AppStrings.success,
          ).show();
          Future.delayed(Duration(milliseconds: 300), () {
            context.go(PathConstants.loginScreen);
          });
        } else if (state is FailureState) {
          LoaderWidget().hide();
          if (ScaffoldMessenger.of(context).mounted) {
            SnackBarWidget(
              context: context,
              message: state.error,
              messageType: AppStrings.failure,
            ).show();
          }
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  TextWidget(
                      text: AppStrings.appName, isBold: true, fontSize: 32),
                  const SizedBox(height: 20),
                  TextWidget(
                      text: AppStrings.createAccount,
                      isBold: false,
                      fontSize: 20),
                  const SizedBox(height: 32),

                  // Name
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: AppStrings.name,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (AppValidators.emptyValidator(value!)) {
                        return AppValidationMessages.requiredField;
                      } else if (AppValidators.nameValidator(value)) {
                        return AppValidationMessages.invalidName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (AppValidators.emptyValidator(value!)) {
                        return AppValidationMessages.requiredEmail;
                      } else if (AppValidators.emailValidator(value)) {
                        return AppValidationMessages.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // DOB
                  TextFormField(
                    controller: dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: AppStrings.dateOfBirth,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _pickDOB,
                      ),
                    ),
                    validator: (value) => AppValidators.emptyValidator(value!)
                        ? AppValidationMessages.dobRequired
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Age (read-only)
                  TextFormField(
                    controller: ageController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: AppStrings.age,
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),

                  // Gender dropdown
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    items: AppStrings.genderList
                        .map((gender) => DropdownMenuItem(
                            value: gender, child: Text(gender)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedGender = value),
                    decoration: const InputDecoration(
                        labelText: AppStrings.gender,
                        border: OutlineInputBorder()),
                    validator: (value) => value == null
                        ? AppValidationMessages.invalidGender
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => setState(() {
                          _obscurePassword = !_obscurePassword;
                        }),
                      ),
                    ),
                    validator: (value) {
                      if (AppValidators.emptyValidator(value!)) {
                        return AppValidationMessages.requiredPassword;
                      } else if (AppValidators.lengthValidator(value)) {
                        return AppValidationMessages.passwordTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: AppStrings.confirmPassword,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (AppValidators.emptyValidator(value!))
                        return AppValidationMessages.reEnterPassword;
                      if (AppValidators.matchValidator(
                          value, passwordController.text))
                        return AppValidationMessages.passwordsDoNotMatch;
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Sign Up button
                  ButtonWidgets.elevatedButton(
                    AppStrings.signUp,
                    _signUp,
                  ),
                  const SizedBox(height: 20),

                  RichTextWidget(
                    primaryText: AppStrings.haveAct,
                    secondaryText: AppStrings.login,
                    onSecondaryTextTap: () {
                      context.go(PathConstants.loginScreen);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _signUp() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      UserEntity user = UserEntity(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          dob: dobController.text.trim(),
          age: int.tryParse(ageController.text.trim()),
          password: passwordController.text.trim(),
          isLoggedIn: false);

      authBloc.add(
        RegisterEvent(user: user),
      );
    }
  }

  void _pickDOB() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDOB = pickedDate;
      dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      final today = DateTime.now();
      final age = today.year -
          pickedDate.year -
          ((today.month < pickedDate.month ||
                  (today.month == pickedDate.month &&
                      today.day < pickedDate.day))
              ? 1
              : 0);
      ageController.text = age.toString();
    }
  }
}
