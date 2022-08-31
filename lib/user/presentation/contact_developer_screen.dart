import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/email_api.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/presentation/widgets/text_field.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/models/feedback_form_model.dart';

class ContactDeveloperScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return ContactDeveloperScreen();
    });
  }

  const ContactDeveloperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('contact-developer'),
      appBar: AppBar(
        title: Text('Contact Developer'),
        leading: FreeBetaBackButton(),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: _ContactDeveloperForm(),
        ),
      ),
    );
  }
}

class _ContactDeveloperForm extends ConsumerStatefulWidget {
  const _ContactDeveloperForm({Key? key}) : super(key: key);

  @override
  ConsumerState<_ContactDeveloperForm> createState() =>
      _ContactDeveloperFormState();
}

class _ContactDeveloperFormState extends ConsumerState<_ContactDeveloperForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nameController = TextEditingController();
  final _commentsController = TextEditingController();

  var _category = FeedbackCategory.suggestion;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: FreeBetaPadding.mAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NameField(
              controller: _nameController,
            ),
            _CategoryField(
              value: _category,
              onChanged: _onCategoryChanged,
            ),
            _CommentsField(
              controller: _commentsController,
            ),
            _SendButton(
              onPressed: _onSend,
            ),
          ],
        ),
      ),
    );
  }

  _onCategoryChanged(category) {
    if (category != null && _category != category) {
      setState(() {
        _category = category;
      });
    }
  }

  void _onSend(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final emailApi = ref.read(emailApiProvider);
    var result = await emailApi.sendEmail(
      FeedbackFormModel(
        name: _nameController.text,
        category: _category,
        comments: _commentsController.text,
      ),
    );

    if (result) {
      await showDialog(
        context: context,
        builder: (_) => _SuccessDialog(),
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) => _ErrorDialog(),
      );
    }
    Navigator.of(context).pop();
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: Padding(
        padding: FreeBetaPadding.xlHorizontal,
        child: Text(
          'Send Feedback',
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
    );
  }
}

class _CommentsField extends StatelessWidget {
  const _CommentsField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comments',
          style: FreeBetaTextStyle.h3,
        ),
        SizedBox(height: FreeBetaSizes.m),
        FreeBetaTextField(
          controller: controller,
          validator: (comments) {
            if (comments == null || comments.isEmpty) {
              return 'Please enter comments';
            }
            return null;
          },
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final FeedbackCategory value;
  final Function(FeedbackCategory?) onChanged;

  @override
  Widget build(BuildContext context) {
    var categories = FeedbackCategory.values.map(
      (category) => DropdownMenuItem<FeedbackCategory>(
        value: category,
        child: Text(category.displayName),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FreeBetaDropdownList<FeedbackCategory>(
          label: 'Category',
          items: categories.toList(),
          initialValue: value,
          onChanged: onChanged,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: FreeBetaTextStyle.h3,
        ),
        SizedBox(height: FreeBetaSizes.m),
        TextFormField(
          controller: controller,
          validator: (name) {
            if (name == null || name.isEmpty) {
              return 'Please enter a name';
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
            hintText: 'Name',
          ),
          style: FreeBetaTextStyle.h4,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text("Thank you for your feedback."),
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  const _ErrorDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text("An error occured. Please try again later."),
    );
  }
}
