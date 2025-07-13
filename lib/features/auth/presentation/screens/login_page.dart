import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.user != null && authBloc.user!.isLoggedIn) {
      Future.delayed(Duration(milliseconds: 300), () {
        context.go(PathConstants.dashboardScreen);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      context: context,
      childWidget: _buildLoginForm(),
      hasHeader: false,
    );
  }

  Widget _buildLoginForm() {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is LoadingState) {
        LoaderWidget().show(context);
      } else if (state is LoginSuccessState) {
        LoaderWidget().hide();
        Future.delayed(Duration(milliseconds: 300), () {
          context.go(PathConstants.dashboardScreen);
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
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Name
              TextWidget(text: AppStrings.appName, isBold: true, fontSize: 32),
              const SizedBox(height: 20),
              // Welcome Text
              TextWidget(text: AppStrings.welcome, isBold: false, fontSize: 20),
              const SizedBox(height: 32),
              // Email Field
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: AppStrings.email,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
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
              const SizedBox(height: 20),
              // Password Field
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: AppStrings.password,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
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
              const SizedBox(height: 30),
              // Login Button
              ButtonWidgets.elevatedButton(
                AppStrings.login,
                _login,
              ),
              const SizedBox(height: 20),
              // Already have an account?
              RichTextWidget(
                primaryText: AppStrings.dntHaveAct,
                secondaryText: AppStrings.signUp,
                onSecondaryTextTap: () {
                  context.go(PathConstants.signUpScreen);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      authBloc.add(LoginEvent(
        email: email,
        password: password,
      ));
    }
  }
}
