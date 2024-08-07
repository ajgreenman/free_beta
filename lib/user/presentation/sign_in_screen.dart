import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/presentation/create_account_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return SignInScreen();
    });
  }

  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('sign-in'),
      appBar: AppBar(
        title: Text('Sign In'),
        leading: FreeBetaBackButton(),
      ),
      body: ref.watch(authenticationStreamProvider).when(
            data: (user) {
              if (user == null || user.isAnonymous) {
                return _buildSignInForm(context);
              }
              return _Loading();
            },
            loading: () => _Loading(),
            error: (error, stackTrace) {
              ref.read(crashlyticsApiProvider).logError(
                    error,
                    stackTrace,
                    'SignInScreen',
                    'authenticationStreamProvider',
                  );

              return ErrorCard();
            },
          ),
    );
  }

  Widget _buildSignInForm(BuildContext context) {
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
                          key: Key('SignInScreen-email'),
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
                          key: Key('SignInScreen-password'),
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
                    ElevatedButton(
                      key: Key('SignInScreen-signIn'),
                      onPressed: () => _onSignIn(context),
                      child: Center(
                        child: Text(
                          'Sign In',
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
                    SizedBox(height: FreeBetaSizes.xl),
                    InfoCard(
                      child: Column(
                        children: [
                          Padding(
                            padding: FreeBetaPadding.mHorizontal,
                            child: Text(
                              'Need an account?',
                              style: FreeBetaTextStyle.h2,
                            ),
                          ),
                          Padding(
                            padding: FreeBetaPadding.mAll,
                            child: Text(
                              'Currently, accounts are only needed by route setters to create and upload new routes.',
                              style: FreeBetaTextStyle.body3,
                            ),
                          ),
                          SizedBox(height: FreeBetaSizes.xl),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              CreateAccountScreen.route(),
                            ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignIn(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final userApi = ref.read(userApiProvider);
    var result = await userApi.signIn(
      _emailController.text,
      _passwordController.text,
    );

    if (!result) {
      await showDialog(
        context: context,
        builder: (_) => _InvalidSignInDialog(),
      );
    }
    Navigator.of(context).pop();
    ref.invalidate(authenticationStreamProvider);
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}

class _InvalidSignInDialog extends StatelessWidget {
  const _InvalidSignInDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Invalid sign in"),
      content: Text("Email/Password combination is incorrect"),
    );
  }
}
