// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note, this.onTap}) : super(key: key);

  final NoteInfoResult note;

  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext _context) => noteCard(note: note, onTap: onTap);
}

class HomePageBody extends HookConsumerWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      homePageBody(_context, _ref);
}
