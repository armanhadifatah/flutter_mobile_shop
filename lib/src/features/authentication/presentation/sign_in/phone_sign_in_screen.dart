import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile_shop/src/configs/app_images.dart';
import 'package:mobile_shop/src/features/authentication/data/auth_notifier.dart';
import 'package:mobile_shop/src/features/authentication/data/phone_auth_state.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';
import 'package:mobile_shop/src/routing/app_router.dart';

import '../../../../common_widgets/custom_image.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../constants/app_sizes.dart';
import 'phone_auth_validators.dart';

class PhoneSignInScreen extends StatelessWidget {
  // * Keys for testing using find.byKey()

  const PhoneSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'.hardcoded)),
      body: const phoneSignInContents(),
    );
  }
}

/// A widget for email & password authentication, supporting the following:
/// - sign in
/// - register (create an account)
class phoneSignInContents extends ConsumerStatefulWidget {
  const phoneSignInContents({
    super.key,
    this.onSignedIn,
  });
  final VoidCallback? onSignedIn;

  @override
  ConsumerState<phoneSignInContents> createState() =>
      _phonedSignInContentsState();
}

class _phonedSignInContentsState extends ConsumerState<phoneSignInContents>
    with PhoneValidators {
  final _node = FocusScopeNode();
  String? phonenumberWithCode;
  String? _code;
  final bool _codeSend = false;
  final GlobalKey<FormState> _phonenumberKey = GlobalKey<FormState>();

  final _submitted = false;
  // track the formType as a local state variable

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _node.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // only submit the form if validation passes
    if (_phonenumberKey.currentState!.validate()) {
      final controller = ref.read(authNotifierProvider.notifier);
      final success = controller.verifyPhoneNumber(phonenumberWithCode!);
      // if (success) {
      //   widget.onSignedIn?.call();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    // ref.listen<AsyncValue>(
    //   phoneAuthNotifierProviderProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );

    // final authNotifier = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider, (previous, next) {
      print(next);
      print(previous);
      if (next.status == PhoneAuthStatus.signInSuccessful) {
        context.goNamed(AppRoute.home.name);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.5,
                child: const CustomImage(
                  imageUrl: AppImages.signin,
                ),
              ),

              // back button with white background

              // add favorite button

              // detail area
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SizedBox(
                      height: size.height * 0.5,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final authNotifier = ref.watch(authNotifierProvider);
                          var isCodeSend =
                              authNotifier.status == PhoneAuthStatus.codeSent;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              gapH8,
                              const Spacer(),
                              const Row(
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: AppFontSize.headLine1),
                                  )
                                ],
                              ),
                              const Spacer(),
                              isCodeSend
                                  ? Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: VerificationCode(
                                        itemSize: 50,
                                        length: 6,
                                        underlineWidth: 3,
                                        fullBorder: true,
                                        digitsOnly: true,
                                        onCompleted: (code) {
                                          setState(() {
                                            _code = code;
                                          });
                                        },
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                        ),
                                        underlineColor:
                                            Theme.of(context).primaryColor,
                                        keyboardType: TextInputType.number,
                                        underlineUnfocusedColor:
                                            Theme.of(context).dividerColor,
                                        onEditing: (value) {},
                                      ),
                                    )
                                  : Form(
                                      key: _phonenumberKey,
                                      child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: IntlPhoneField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[1-9]\d*')),
                                            ],
                                            decoration: const InputDecoration(
                                              labelText: 'Phone Number',
                                              hintText: "Just English Numbers",
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(),
                                              ),
                                            ),
                                            initialCountryCode: 'IQ',
                                            onChanged: (phone) {
                                              phonenumberWithCode =
                                                  phone.completeNumber;
                                            },
                                          )),
                                    ),
                              const Spacer(),
                              SizedBox(
                                height: 60,
                                child: isCodeSend
                                    ? PrimaryButton(
                                        onPressed: () {
                                          // authNotifier.signInWithCode(
                                          //     verificationId, _code!);
                                          ref
                                              .read(
                                                  authNotifierProvider.notifier)
                                              .signInWithCode(_code!);
                                        },
                                        text: 'Send Login'.hardcoded,
                                      )
                                    : PrimaryButton(
                                        onPressed: () {
                                          _submit();
                                        },
                                        text: 'Next'.hardcoded,
                                      ),
                              ),
                              const Spacer(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
