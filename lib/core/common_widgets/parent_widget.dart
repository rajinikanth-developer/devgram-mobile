import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/path_constants.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

class ParentWidget extends StatelessWidget {
  final BuildContext context;
  final Widget childWidget;
  final bool hasHeader;
  final bool? hasBackBtn;
  final String appbarTitle;
  final Widget? floatingActionButton;

  const ParentWidget(
      {super.key,
      required this.context,
      required this.childWidget,
      this.appbarTitle = '',
      this.hasBackBtn = false,
      this.floatingActionButton,
      required this.hasHeader});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: hasHeader
            ? AppBar(
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  appbarTitle,
                  style: TextStyle(
                    color: AppColors.buttonTextColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                elevation: 0.0,
                toolbarHeight: 60,
                leading: hasBackBtn!
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.buttonTextColor,
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            SystemNavigator.pop();
                          }
                        },
                      )
                    : SizedBox.shrink(),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.buttonTextColor,
                    ),
                    onPressed: () async {
                      AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                      authBloc.logout();
                      Future.delayed(Duration(milliseconds: 300), () {
                        context.go(PathConstants.loginScreen);
                      });
                    },
                  ),
                ],
              )
            : null,
        backgroundColor: AppColors.backgroundColor,
        body: childWidget,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
