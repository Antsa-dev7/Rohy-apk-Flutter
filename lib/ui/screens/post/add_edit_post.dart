import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/ui/providers/user_provider.dart';

class AddEditPostScreen extends StatefulWidget {
  const AddEditPostScreen({Key? key}) : super(key: key);

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  @override
  Widget build(BuildContext context) {
    RohyUser? user = Provider.of<UserProvider>(context, listen: false).user;
    return Text("${user!.nom}");
  }
}
