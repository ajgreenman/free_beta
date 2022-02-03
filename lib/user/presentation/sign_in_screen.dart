import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/back_button.dart';
import 'package:free_beta/app/presentation/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';

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
    var authenticationState = ref.watch(authenticationProvider);

    ref.listen(authenticationProvider, (_, current) {
      if (current == null) return;
      var user = current as AsyncData<User?>;
      if (user.value != null) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      key: Key('sign-in'),
      appBar: AppBar(
        title: Text('Sign In'),
        leading: FreeBetaBackButton(),
      ),
      body: authenticationState.when(
        data: (data) {
          if (data == null) {
            return _buildSignInForm();
          }
          return _buildLoading();
        },
        loading: () => _buildLoading(),
        error: (error, stackTrace) => ErrorCard(
          error: error,
          stackTrace: stackTrace,
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildSignInForm() {
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null ||
                                email.isEmpty ||
                                !email.contains('@')) {
                              return 'Please enter valid email';
                            }
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
                          controller: _passwordController,
                          obscureText: true,
                          validator: (password) {
                            if (password == null ||
                                password.isEmpty ||
                                password.length < 8) {
                              return 'Password must be 8 characters';
                            }
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
                      onPressed: _onPressed,
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: FreeBetaTextStyle.h4.copyWith(
                            color: FreeBetaColors.white,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(
                            width: 2,
                          ),
                        ),
                        padding: MaterialStateProperty.all(
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
                'Accounts are only needed to create and upload new routes. If you believe you need an account, please email AGreenman13@gmail.com.',
                style: FreeBetaTextStyle.body3.copyWith(
                  color: FreeBetaColors.grayLight,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPressed() async {
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
        builder: (_) => _InvalidLoginDialog(),
      );
    }
  }
}

class _InvalidLoginDialog extends StatelessWidget {
  const _InvalidLoginDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Invalid login"),
      content: Text("Email/Password combination is incorrect"),
    );
  }
}
