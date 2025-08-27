// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_toggle_button.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class OptionToggleButton extends HookWidget {
  const OptionToggleButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  final Widget label;

  final Widget icon;

  final dynamic Function(bool) onChanged;

  @override
  Widget build(BuildContext _context) => optionToggleButton(
    _context,
    label: label,
    icon: icon,
    onChanged: onChanged,
  );
}
