import 'package:flutter/services.dart';

import '../import.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';

// class _TheState {}

// var _theState = RM.inject(() => _TheState());

class AppTextFormField extends StatefulWidget {
  final String? floatingLabel;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int maxLines;
  final int minLines;
  final String? label;
  final Color? fillColor;
  final Color? textColor;
  final Color? labelColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool readOnly;
  final String? placeholder;
  final String? initialValue;
  final TextEditingController? controller;
  final List<BoxShadow>? shadow;
  final void Function()? onTap;

  const AppTextFormField({
    final Key? key,
    this.floatingLabel,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
    this.label,
    this.fillColor,
    this.textColor,
    this.readOnly = false,
    this.labelColor,
    this.inputFormatters,
    this.autofocus = false,
    this.placeholder,
    this.initialValue,
    this.controller,
    this.shadow,
    this.onTap,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final TextEditingController controller =
      TextEditingController(text: widget.initialValue);

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(
              color: widget.labelColor ?? const Color(0xFF172331),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        if (widget.label != null) const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54,width: 1)
          ),
          child: TextFormField(
            validator: widget.validator,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            keyboardType: widget.keyboardType,
            controller: widget.controller ?? controller,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText ?? false,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
                color: widget.textColor ?? const Color(0xFF2D2D2D),
                fontWeight: FontWeight.w400,
                fontSize: 15),
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              alignLabelWithHint: false,
              suffixIcon: widget.suffixIcon,
              hintText: widget.placeholder,
              prefixIcon: widget.prefixIcon,
              floatingLabelStyle: const TextStyle(color: Color(0xFF9B9B9B)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(inputRadius)),
              fillColor: widget.fillColor ?? Colors.white,
              filled: true,
              labelText: widget.floatingLabel,
              labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    final Key? key,
    this.floatingLabel,
    this.onChanged,
    this.onSaved,
    this.label,
    this.validator,
    this.prefixIcon,
    this.keyboardType,
    this.fillColor,
    this.textColor,
    this.readOnly = false,
    this.labelColor,
    this.inputFormatters,
    this.autofocus = false,
    this.placeholder,
    this.initialValue,
    this.controller,
    this.shadow,
    this.onTap,
  }) : super(key: key);

  final String? floatingLabel;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? label;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Color? textColor;
  final Color? labelColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool readOnly;
  final String? placeholder;
  final String? initialValue;
  final TextEditingController? controller;
  final List<BoxShadow>? shadow;
  final void Function()? onTap;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordVisible = false;

  @override
  Widget build(final BuildContext context) => AppTextFormField(
        label: widget.label,
        floatingLabel: widget.floatingLabel ?? '',
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        obscureText: !passwordVisible,
        keyboardType: TextInputType.visiblePassword,
        suffixIcon: IconButton(
          onPressed: () => setState(() => passwordVisible = !passwordVisible),
          icon: passwordVisible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
        validator: widget.validator,
        prefixIcon: widget.prefixIcon,
        fillColor: widget.fillColor,
        textColor: widget.textColor,
        labelColor: widget.labelColor,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        placeholder: widget.placeholder,
        initialValue: widget.initialValue,
        controller: widget.controller,
        shadow: widget.shadow,
        onTap: widget.onTap,
      );
}

class AppDropdownItem<T> {
  final String text;
  final T value;
  final bool enabled;
  final Widget? child;

  const AppDropdownItem({
    required this.text,
    required this.value,
    this.enabled = true,
    this.child,
  });
}

class AppDropdown<T> extends StatefulWidget {
  late final List<AppDropdownItem<T>> items;
  final void Function(T)? onChangeItem;
  final T? initialSelected;
  final void Function(void Function(T))? changeSelection;
  final String placeholder;
  final String floatingLabel;

  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;
  AppDropdown({
    List<AppDropdownItem<T>>? items,
    this.changeSelection,
    List<String>? protoTypeItems,
    final Key? key,
    this.onChangeItem,
    this.initialSelected,
    this.placeholder = '',
    this.floatingLabel = '',
    this.validator,
    this.onSaved,
  }) : super(key: key) {
    if (items == null) {
      if (protoTypeItems == null) {
        this.items = [];
      }
      this.items = protoTypeItems!
          .map((e) => AppDropdownItem<T>(text: e, value: e as T))
          .toList();
    } else {
      this.items = items;
    }
  }

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  late T? selectedItem = widget.initialSelected;
  @override
  void initState() {
    widget.changeSelection?.call((final T val) {
      setState(() {
        selectedItem = val;
      });
      widget.onChangeItem?.call(val);
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0.0, 0.0),
              blurRadius: 4.0)
        ],
      ),
      child: DropdownButtonFormField<T>(
        onChanged: (final T? val) {
          if (val != null) {
            setState(() => selectedItem = val);
            widget.onChangeItem?.call(val);
          }
        },
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          hintText: widget.placeholder,
          floatingLabelStyle: const TextStyle(color: Color(0xFF9B9B9B)),
          border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(inputRadius)),
          fillColor: Colors.white,
          filled: true,
          labelText: widget.floatingLabel,
          labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
          // contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        ),
        icon: Icon(CupertinoIcons.chevron_down,
            size: 18, color: theme.primaryColor),
        value: selectedItem,
        hint: widget.placeholder.isNotEmpty ? Text(widget.placeholder) : null,
        items: widget.items
            .map(
              (final AppDropdownItem<T> e) => DropdownMenuItem<T>(
                value: e.value,
                enabled: e.enabled,
                child: e.child ?? Text(e.text),
              ),
            )
            .toList(),
      ),
    );
  }
}

class MultiSelectAppDropdownItem<T> {
  final String text;
  final T value;
  final bool enabled;

  const MultiSelectAppDropdownItem({
    required this.text,
    required this.value,
    this.enabled = true,
  });
}

class MultiSelectAppDropdown extends StatefulWidget {
  late final List<MultiSelectAppDropdownItem<String>> items;
  final void Function(List<String>)? onChangeItem;
  final List<String>? initialSelected;
  final void Function(void Function(List<String>))? changeSelection;
  final String placeholder;
  final String floatingLabel;

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  MultiSelectAppDropdown({
    List<MultiSelectAppDropdownItem<String>>? items,
    this.changeSelection,
    List<String>? protoTypeItems,
    final Key? key,
    this.onChangeItem,
    this.initialSelected,
    this.placeholder = '',
    this.floatingLabel = '',
    this.validator,
    this.onSaved,
  }) : super(key: key) {
    if (items == null) {
      if (protoTypeItems == null) {
        this.items = [];
      }
      this.items = protoTypeItems!
          .map((e) => MultiSelectAppDropdownItem<String>(text: e, value: e))
          .toList();
    } else {
      this.items = items;
    }
  }

  @override
  State<MultiSelectAppDropdown> createState() => _MultiSelectAppDropdownState();
}

class _MultiSelectAppDropdownState extends State<MultiSelectAppDropdown> {
  late List<String> selectedItem = widget.initialSelected ?? [];
  @override
  void initState() {
    widget.changeSelection?.call((final List<String> val) {
      setState(() {
        selectedItem = val;
      });
      widget.onChangeItem?.call(val);
    });
    super.initState();
  }

  void onChanged(final List<String> val) {
    setState(() => selectedItem = val);
    widget.onChangeItem?.call(val);
  }

  @override
  Widget build(final BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0.0, 0.0),
              blurRadius: 4.0)
        ],
      ),
      child: PopupMenuButton(
        // onChanged: (final List<String>? val) {
        //   if (val != null) {
        //     setState(() => selectedItem = val);
        //     widget.onChangeItem?.call(val);
        //   }
        // },
        // decoration: InputDecoration(
        //   alignLabelWithHint: false,
        //   hintText: widget.placeholder,
        //   floatingLabelStyle: const TextStyle(color: Color(0xFF9B9B9B)),
        //   border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(inputRadius)),
        //   fillColor: Colors.white,
        //   filled: true,
        //   labelText: widget.floatingLabel,
        //   labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
        //   contentPadding: const EdgeInsets.fromLTRB(12, 30, 12, 30),
        // ),

        // selectedValues: selectedItem ?? [],
        // options: widget.items.map((e) => e.text).toList(),
        // childBuilder: (context) => Text((selectedItem ?? []).join(', '), style: TextStyle(color: Colors.black)),
        // whenEmpty: widget.placeholder.isNotEmpty ? widget.placeholder : widget.floatingLabel,
        itemBuilder: (BuildContext context) => widget.items
            .map(
              (item) => PopupMenuItem(
                child: _SelectRow(
                  onChange: (val) {
                    val
                        ? onChanged([...selectedItem, item.value])
                        : onChanged(selectedItem
                            .where((element) => element != item.value)
                            .toList());
                    setState(() {});
                  },
                  selected:
                      selectedItem.any((element) => element == item.value),
                  text: item.text,
                ),
              ),
            )
            .toList(),
        child: AbsorbPointer(
          child: AppTextFormField(
            placeholder: widget.placeholder,
            floatingLabel: widget.floatingLabel,
            controller: TextEditingController(
              text: widget.items
                  .where((item) => selectedItem.any((i) => i == item.value))
                  .map((item) => item.text)
                  .join(', '),
            ),
            maxLines: 3,
            minLines: 1,
            readOnly: true,
          ),
        ),

        // icon: Icon(CupertinoIcons.chevron_down, size: 18, color: theme.primaryColor),
        // value: selectedItem,
        // hint: widget.placeholder.isNotEmpty ? Text(widget.placeholder) : null,
        // items: widget.items
        //     .map((final MultiSelectAppDropdownItem<String> e) => DropdownMenuItem<String>(value: e.value, enabled: e.enabled, child: Text(e.text)))
        //     .toList(),
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow(
      {Key? key,
      required this.onChange,
      required this.selected,
      required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!selected);
      },
      child: Row(
        children: [
          Checkbox(
            value: selected,
            onChanged: (x) {
              onChange(!selected);
            },
          ),
          Text(text),
        ],
      ),
    );
  }
}
