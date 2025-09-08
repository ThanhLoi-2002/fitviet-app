import 'dart:convert';

import 'package:fitness_client/common/widgets/custom_ink_well.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/images.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    return Column(
      children: [
        Text('hoặc đăng nhập', style: fontRegular.copyWith(color: Colors.grey[500])),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                border: Border.all(width: 0.5, color: Colors.grey[500]!),
                boxShadow: [BoxShadow(color: Colors.grey[300]!, spreadRadius: 1, blurRadius: 5, offset: const Offset(2, 2))],
              ),
              child: CustomInkWell(
                radius: Dimensions.radiusExtraLarge,
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                onTap: () => _googleLogin(googleSignIn),
                child: Image.asset(Images.googleIcon),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: Dimensions.paddingSizeLarge),
              child: InkWell(
                onTap: () => _facebookLogin(),
                borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.5, color: Colors.grey[500]!),
                    boxShadow: [BoxShadow(color: Colors.grey[300]!, spreadRadius: 1, blurRadius: 5, offset: const Offset(2, 2))],
                  ),
                  child: Image.asset(Images.facebookIcon, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _googleLogin(GoogleSignIn googleSignIn) async {
    try {
      googleSignIn.signOut();
      GoogleSignInAccount googleAccount = (await googleSignIn.signIn())!;
      GoogleSignInAuthentication auth = await googleAccount.authentication;
      debugPrint(jsonEncode(auth));
      showCustomSnackBar(jsonEncode(auth));
    } catch (error) {
      debugPrint(jsonEncode(error));
    }

    // SocialLogInBody googleBodyModel = SocialLogInBody(
    //   email: googleAccount.email, token: auth.accessToken, uniqueId: googleAccount.id,
    //   medium: 'google', accessToken: 1, loginType: CentralizeLoginType.social.name,
    // );

    // Get.find<AuthController>().loginWithSocialMedia(googleBodyModel).then((response) {
    //   if (response.isSuccess) {
    //     _processSocialSuccessSetup(response, googleBodyModel, null, null);
    //   } else {
    //     showCustomSnackBar(response.message);
    //   }
    // });
  }

  void _facebookLogin() async {
    LoginResult result = await FacebookAuth.instance.login(permissions: ["public_profile", "email"]);
    if (result.status == LoginStatus.success) {
      Map userData = await FacebookAuth.instance.getUserData();
      debugPrint(jsonEncode(userData));

      // SocialLogInBody facebookBodyModel = SocialLogInBody(
      //   email: userData['email'],
      //   token: result.accessToken!.token,
      //   uniqueId: result.accessToken!.userId,
      //   medium: 'facebook',
      //   loginType: CentralizeLoginType.social.name,
      // );

      // Get.find<AuthController>().loginWithSocialMedia(facebookBodyModel).then((response) {
      //   if (response.isSuccess) {
      //     _processSocialSuccessSetup(response, null, null, facebookBodyModel);
      //   } else {
      //     showCustomSnackBar(response.message);
      //   }
      // });
    }
  }
}
