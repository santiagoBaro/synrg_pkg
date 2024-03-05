// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:synrg/src/class.dart';
import 'package:synrg/src/indexer.dart';
import 'package:synrg/synrg.dart';

//? Indexed Class Implementation
final projectIndex = Indexer<Project>('projects', Project.fromMap);

class Project extends SynrgClass {
  String name;
  String type;
  Project(
    super.id, {
    required this.name,
    required this.type,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
    };
  }

  @override
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      map['name'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  @override
  Future<void> save() async {
    await projectIndex.save(this);
  }

  @override
  Project copyWith({String? id, String? name, String? type}) {
    return Project(
      id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}

//? Synrg Bloc Provider implementation
class DummyWidget extends StatelessWidget {
  const DummyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SynrgBlocProvider<SynrSessionBloc>(
      bloc: SynrSessionBloc(),
      builder: (context, state) {
        // Your widget content based on state
        return Container();
      },
    );
  }
}

//? Stateless ful validation implementation
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: validatePlainText,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

//? Stateless form validation implementation
class MyStatelessForm extends StatelessWidget {
  MyStatelessForm({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: validatePlainText,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
