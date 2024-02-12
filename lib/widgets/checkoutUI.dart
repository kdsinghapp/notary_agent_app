import 'package:notary_agent_app/import.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? letterSpacing;
  final double? wordSpacing;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color(0xff000000),
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.start,
      this.letterSpacing = 0.5,
      this.wordSpacing = 0.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing),
    );
  }
}

class SpaceRow extends StatelessWidget {
  final String heading;
  final String value;
  const SpaceRow({Key? key, required this.heading, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CustomText(
              text: "${heading}",
              textColor: CC.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                text: "${value}",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
