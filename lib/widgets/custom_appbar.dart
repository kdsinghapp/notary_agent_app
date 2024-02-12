import 'package:notary_agent_app/import.dart';

AppBar appBar(
    {String? title,
    Color appBarColor = CC.primary,
    Color titleColor = Colors.white,
    bool implyLeading = true,
    bool isCentre = false,
    double elevation = 4,
    required BuildContext context,
    List<Widget>? actions}) {
  return AppBar(
    elevation: elevation,
    backgroundColor: appBarColor,
    title: Padding(
        padding: const EdgeInsets.all(2),
        child: CustomText(
          text: title ?? '',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          textColor: titleColor,
        )),
    centerTitle: isCentre,
    toolbarHeight: 70,
    leading: const BackButton(),
    actions:actions,
  );

  //   AppBar(
  //   toolbarHeight: 70,
  //   automaticallyImplyLeading: false,
  //   backgroundColor: appBarColor,
  //   centerTitle: isCentre,
  //   elevation: 0,
  //   title: title == null
  //       ? null
  //       // : AppBarHeadingText(
  //     text: title,
  //     color: titleColor,
  //   ),
  //   leading: implyLeading
  //       ? IconButton(
  //     icon:  Icon(
  //       Icons.chevron_left_outlined,
  //       color: titleColor,
  //       size: 30,
  //     ),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   )
  //       : null,
  //   actions: actions,
  // );
}

// AppBar(
// title: Padding(
// padding: const EdgeInsets.all(2),
// child: CustomText(
// text: 'Check Out',
// fontSize: 18,
// fontWeight: FontWeight.w500,
// textColor: Colors.white,
// )),
// centerTitle: false,
// toolbarHeight: 70,
// leading: const BackButton(),
// )
