// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'side_bar.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class NetworkVideoAuthorAvatar extends StatelessWidget {
  const NetworkVideoAuthorAvatar({Key? key, required this.avatarUrl})
    : super(key: key);

  final String avatarUrl;

  @override
  Widget build(BuildContext _context) =>
      networkVideoAuthorAvatar(_context, avatarUrl: avatarUrl);
}

class DefaultVideoAuthorAvatar extends StatelessWidget {
  const DefaultVideoAuthorAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => defaultVideoAuthorAvatar(_context);
}

class SideBarIconButton extends StatelessWidget {
  const SideBarIconButton({
    Key? key,
    required this.icon,
    required this.label,
    this.number,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;

  final String label;

  final int? number;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext _context) => sideBarIconButton(
    icon: icon,
    label: label,
    number: number,
    onPressed: onPressed,
  );
}

class ShortVideoSideBar extends StatelessWidget {
  const ShortVideoSideBar({Key? key, required this.videoInfo})
    : super(key: key);

  final ShortVideoInfoResult? videoInfo;

  @override
  Widget build(BuildContext _context) =>
      shortVideoSideBar(_context, videoInfo: videoInfo);
}
