import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/privacy_controller.dart';
import '../../utils/util_funcs.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/checkoutUI.dart';
import '../../widgets/custom_appbar.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar(context: context, title: "Privacy Policy"),
      body:GetBuilder(
        init: PrivacyController(),
        builder: (PrivacyController controller) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: CustomText(
                letterSpacing: 0.9,
                // wordSpacing: 1,
                textAlign: TextAlign.justify,
                text: 'Lorem ipsum dolor sit amet consectetur. In '
                    'aliquet hac tincidunt congue tellus pellentesque vestibulum.'
                    'Ultrices ac elementum et non volutpat venenatis dictum id id. Massa tellus fermentum orci ut \n praesent elementum. Dictumst nibh egestas ultricies diam neque id vel netus eget. Augue nulla tincidunt vitae auctor amet malesuada feugiat. Euismod sed tristique tellus scelerisque '
                    'in lectus nec. Eu laoreet pellentesque pretium fermentum vel faucibus. Id est ullamcorper vel congue lacus. Ut \nquis est justo tincidunt purus. Aliquet condimentum varius in odio bibendum vulputate. Maecenas sem quis nibh lacus. Sagittis nullam rutrum convallis nullam neque metus non eget pulvinar. Tortor enim amet tellus malesuada faucibus a suspendisse. Praesent dignissim sollicitudin dictum tristique at elementum ut interdum.'
                    'Non volutpat velit enim enim ac pulvinar. Nulla ullamcorper aliquam ut \nduis sed. Imperdiet sem morbi habitasse risus. In pretium arcu proin massa proin vivamus pellentesque. Elementum massa suspendisse tortor nulla diam. Mi in vel sed justo nec curabitur.',
              ),
            ),
            sbh(50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppButton(
                onTap: () {
                  controller.ok(context);
                },
                text: "OK",
              ),
            )
          ],
        );
      },

      )
    );
  }
}
