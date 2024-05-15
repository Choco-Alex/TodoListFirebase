import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDataPage extends StatefulWidget {
  ViewDataPage({super.key, this.document, this.id});

  final Map<String, dynamic>? document;
  final String? id;
  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  String type = "";
  String state = "";
  String category = "";
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document?["title"] == null
        ? "hey thereeee"
        : widget.document?["title"];
    _titleController = TextEditingController(text: title);
    _descriptionController =
        TextEditingController(text: widget.document?["description"]);
    type = widget.document?["task_type"];
    category = widget.document?["category"];
    state = widget.document?["state"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1d1e26),
              Color(0xff252041),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.arrow_left),
                    color: Colors.white,
                    iconSize: 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(Icons.edit),
                        color: edit ? Colors.red : Colors.white,
                        iconSize: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Todo")
                              .doc(widget.id)
                              .delete()
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red.withOpacity(0.7),
                        iconSize: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Editing" : "Detail Of",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "your Todo",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Task Title"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 30,
                    ),
                    label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        task_typeSelect("Important", 0xff800080),
                        SizedBox(
                          width: 20,
                        ),
                        task_typeSelect("Pro", 0xff2bc819),
                        SizedBox(
                          width: 20,
                        ),
                        task_typeSelect("Perso", 0xff000000),
                        SizedBox(
                          width: 20,
                        ),
                        task_typeSelect("Daily", 0xff0000ff),
                        SizedBox(
                          width: 20,
                        ),
                        task_typeSelect("Urgent", 0xffff0000),
                        SizedBox(
                          width: 20,
                        ),
                        task_typeSelect("Ponctu", 0xffffa500),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 25,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect("Food", 0xffa52a2a),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Work", 0xff2bc8d9),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Sport", 0xff6552ff),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Coding", 0xff234ebd),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("School", 0xff2bc819),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Love", 0xffffc0cb),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Perso", 0xff000000),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Evenement", 0xffff7f50),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("TV", 0xffc0c0c0),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    label("State"),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(runSpacing: 10, children: [
                      taskState("Finish", 0xff2bc819),
                      SizedBox(
                        width: 20,
                      ),
                      taskState("No Finish", 0xffff0000),
                    ]),
                    SizedBox(
                      height: 50,
                    ),
                    edit ? button() : Container(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget task_typeSelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: type == label ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget taskState(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                state = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: state == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: state == label ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: category == label ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        enabled: edit,
        style: TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Description",
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").doc(widget.id).update({
          "title": _titleController!.text,
          "task_type": type,
          "category": category,
          "state": state,
          "description": _descriptionController!.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.black,
              Colors.blueAccent,
            ],
          ),
        ),
        child: Center(
            child: Text(
          "Update Todo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.5,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    );
  }
}
