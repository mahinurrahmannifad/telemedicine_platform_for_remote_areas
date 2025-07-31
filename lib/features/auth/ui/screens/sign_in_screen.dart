import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
import 'package:telemedicine_platform_for_remote_areas/core/extensions/localization_extension.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/centered_circular_progress_indicator.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/show_snack_bar_message.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/data/models/sign_in_request_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/widgets/app_logo.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/ui/screen/main_bottom_nav_bar_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const AppLogo(),
                const SizedBox(height: 24),
                Text(
                  context.localization.welcomeBack,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  context.localization.enterYourEmailAndPassword,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: context.localization.email),
                    validator: (String? value) {
                      String email = value ?? '';
                      if (!EmailValidator.validate(email)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration:
                  InputDecoration(hintText: context.localization.password),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 8) {
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<SignInController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapSignInButton,
                          child: Text(context.localization.signIn),
                        ),
                      );
                    }
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = _onTapSignUpButton
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignInButton() async {
    if (_formKey.currentState!.validate()) {
      SignInRequestModel signInRequestModel = SignInRequestModel(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
      );
      final bool isSuccess = await _signInController.signIn(signInRequestModel);

      if (!mounted) return; // ✅ Prevent using context if widget is disposed

      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
            context, MainBottomNavBarScreen.name, (value) => false);
      } else {
        showSnackBarMessage(context, _signInController.errorMessage!, true);
      }
    }
  }


  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}