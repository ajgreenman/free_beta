import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return CreateAccountScreen();
    });
  }

  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _gymPasswordController = TextEditingController();
  String? _gymPasswordErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('create-account'),
      appBar: AppBar(
        title: Text('Create Account'),
        leading: FreeBetaBackButton(),
      ),
      body: ref.watch(authenticationStreamProvider).when(
            data: (user) {
              if (user == null || user.isAnonymous) {
                return _buildCreateAccountForm();
              }
              return _Loading();
            },
            loading: () => _Loading(),
            error: (error, stackTrace) {
              ref.read(crashlyticsApiProvider).logError(
                    error,
                    stackTrace,
                    'CreateAccountScreen',
                    'authenticationProvider',
                  );

              return ErrorCard();
            },
          ),
    );
  }

  Widget _buildCreateAccountForm() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: FreeBetaPadding.mAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: FreeBetaTextStyle.h3,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        TextFormField(
                          key: Key('CreateAccountScreen-email'),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null ||
                                email.isEmpty ||
                                !email.contains('@')) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FreeBetaColors.red,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: FreeBetaSizes.m,
                            ),
                            hintStyle: FreeBetaTextStyle.h4.copyWith(
                              color: FreeBetaColors.grayLight,
                            ),
                            hintText: 'Email',
                          ),
                          style: FreeBetaTextStyle.h4,
                        ),
                      ],
                    ),
                    SizedBox(height: FreeBetaSizes.xl),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: FreeBetaTextStyle.h3,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        TextFormField(
                          key: Key('CreateAccountScreen-password'),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (password) {
                            if (password == null ||
                                password.isEmpty ||
                                password.length < 8) {
                              return 'Password must be 8 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FreeBetaColors.red,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: FreeBetaSizes.m,
                            ),
                            hintStyle: FreeBetaTextStyle.h4.copyWith(
                              color: FreeBetaColors.grayLight,
                            ),
                            hintText: 'Password',
                          ),
                          style: FreeBetaTextStyle.h4,
                        ),
                      ],
                    ),
                    SizedBox(height: FreeBetaSizes.xl),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Password',
                          style: FreeBetaTextStyle.h3,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        TextFormField(
                          key: Key('CreateAccountScreen-confirm'),
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (password) {
                            if (password == null ||
                                password != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FreeBetaColors.red,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: FreeBetaSizes.m,
                            ),
                            hintStyle: FreeBetaTextStyle.h4.copyWith(
                              color: FreeBetaColors.grayLight,
                            ),
                            hintText: 'Confirm Password',
                          ),
                          style: FreeBetaTextStyle.h4,
                        ),
                      ],
                    ),
                    SizedBox(height: FreeBetaSizes.xl),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gym Password',
                          style: FreeBetaTextStyle.h3,
                        ),
                        SizedBox(height: FreeBetaSizes.m),
                        TextFormField(
                          key: Key('CreateAccountScreen-gymPassword'),
                          controller: _gymPasswordController,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Please enter the gym password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FreeBetaColors.red,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: FreeBetaSizes.m,
                            ),
                            hintStyle: FreeBetaTextStyle.h4.copyWith(
                              color: FreeBetaColors.grayLight,
                            ),
                            hintText: 'Gym Password',
                            errorText: _gymPasswordErrorMessage,
                          ),
                          style: FreeBetaTextStyle.h4,
                        ),
                      ],
                    ),
                    SizedBox(height: FreeBetaSizes.xl),
                    ElevatedButton(
                      key: Key('CreateAccountScreen-create'),
                      onPressed: _onCreateAccount,
                      child: Center(
                        child: Text(
                          'Create Account',
                          style: FreeBetaTextStyle.h4.copyWith(
                            color: FreeBetaColors.white,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(FreeBetaColors.black),
                        side: WidgetStateProperty.all(
                          BorderSide(
                            width: 2,
                          ),
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                            vertical: FreeBetaSizes.ml,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: FreeBetaPadding.lAll,
              child: Text(
                'Currently, accounts are only needed for route setters to create and upload new routes. If you believe you need an account, please contact a gym owner or email AGreenman13@gmail.com.',
                style: FreeBetaTextStyle.body3.copyWith(
                  color: FreeBetaColors.grayLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCreateAccount() async {
    setState(() {
      _gymPasswordErrorMessage = null;
    });
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final userApi = ref.read(userApiProvider);
    var checkPassword = await userApi.checkGymPassword(
      _gymPasswordController.text,
    );

    if (!checkPassword) {
      _gymPasswordController.text = '';

      setState(() {
        _gymPasswordErrorMessage = 'Invalid gym password';
      });

      await showDialog(
        context: context,
        builder: (_) => _InvalidGymPasswordDialog(),
      );
      return;
    }

    var result = await userApi.signUp(
      _emailController.text,
      _passwordController.text,
    );

    if (!result) {
      await showDialog(
        context: context,
        builder: (_) => _UnableToCreateDialog(),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _AccountCreatedDialog(),
    );
    Navigator.of(context).pop();
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

class _AccountCreatedDialog extends StatelessWidget {
  const _AccountCreatedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success!"),
      content: Text("Your account was successfully created! Please sign in."),
    );
  }
}

class _InvalidGymPasswordDialog extends StatelessWidget {
  const _InvalidGymPasswordDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Invalid gym password"),
      content:
          Text("The gym password you entered is incorrect, please try again."),
    );
  }
}

class _UnableToCreateDialog extends StatelessWidget {
  const _UnableToCreateDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Unable to create account"),
      content: Text(
          "Something went wrong and we were unable to create your account, please try again later."),
    );
  }
}
