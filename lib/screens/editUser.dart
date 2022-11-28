import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/user.dart';
import '../services/userService.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  final _userService = UserService();

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.user.name ?? '';
      _userContactController.text = widget.user.contact ?? '';
      _userDescriptionController.text = widget.user.description ?? '';
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    log("EDIT USER: didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant EditUser oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    log("EDIT USER: didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    log('EDIT USER: deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log('EDIT USER: dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  errorText: _validateName ? 'Name can\'t be empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: _userContactController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Contact',
                  labelText: 'Contact',
                  errorText: _validateContact
                      ? 'Contact must have 10 characters'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userDescriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  errorText: _validateDescription
                      ? 'Description can\'t be empty'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 15,
                          )),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty ||
                                  _userContactController.text.length != 10
                              ? _validateContact = true
                              : _validateContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        if (_validateName == false &&
                            _validateContact == false &&
                            _validateDescription == false) {
                          //print('Data can save');
                          var _user = User();
                          _user.id = widget.user.id;
                          _user.name = _userNameController.text;
                          _user.contact = _userContactController.text;
                          _user.description = _userDescriptionController.text;
                          var result = await _userService.updateUser(_user);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';
                      },
                      child: const Text('Clear Details')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
