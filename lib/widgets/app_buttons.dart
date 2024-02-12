import '../import.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onTap,
    final Key? key,
    this.text,
    this.disabled = false,
    this.enabled = true,
    this.loading = false,
    this.color,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.fontSize,
    this.builder,
    this.borderRadius,
    this.badge,
  })  : assert(text != null || builder != null, 'Either text or builder must be passed'),
        super(key: key);

  final void Function() onTap;
  final String? text;
  final Widget Function(BuildContext, TextStyle)? builder;
  final bool disabled; // changes background to grey
  final bool enabled; // Just disables click
  final bool loading;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final int? badge;

  @override
  Widget build(final BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: loading ? CC.disabled : color ?? CC.primary,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
        ),
        child: AppTouchable(
          onTap: !disabled && enabled && !loading ? onTap : null,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          child: Padding(
            padding: padding,
            child: Badge(
              badgeContent: Text('$badge', style: const TextStyle(fontSize: 10)),
              badgeStyle: const BadgeStyle(badgeColor: Colors.white),
              showBadge: badge != 0 && badge != null,
              child: Center(
                child: loading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: CC.primaryDark,
                          strokeWidth: 2,
                        ),
                      )
                    : builder != null
                        ? builder!(
                            context,
                            TextStyle(
                              color: loading ? Colors.white : textColor ?? Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize ?? 18,
                            ),
                          )
                        : Text(
                            text!,
                            style: TextStyle(
                              color: loading ? Colors.white : textColor ?? Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize ?? 18,
                            ),
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineAppButton extends StatelessWidget {
  const OutlineAppButton({
    required this.onTap,
    final Key? key,
    this.text,
    this.disabled = false,
    this.enabled = true,
    this.loading = false,
    this.color,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
    this.fontSize,
    this.builder,
  })  : assert(text != null || builder != null, 'Either text or builder must be passed'),
        super(key: key);

  final void Function() onTap;
  final String? text;
  final Widget Function(BuildContext, TextStyle)? builder;
  final bool disabled; // changes background to grey
  final bool enabled; // Just disables click
  final bool loading;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final double? fontSize;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: disabled || loading ? CC.disabled : color ?? CC.primary, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: AppTouchable(
        onTap: !disabled && enabled && !loading ? onTap : null,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: padding,
          child: Center(
            child: loading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : builder != null
                    ? builder!(
                        context,
                        TextStyle(
                          color: disabled || loading ? CC.disabled : color ?? CC.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: fontSize ?? 18,
                        ),
                      )
                    : Text(
                        text!,
                        style: TextStyle(
                          color: disabled || loading ? CC.disabled : color ?? CC.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: fontSize ?? 18,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBarBackButton(color: CC.white);
  }
}
