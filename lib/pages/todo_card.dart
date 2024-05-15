import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(
      {super.key,
      required this.title,
      required this.iconData,
      required this.iconColor,
      required this.check,
      required this.iconBgColor,
      this.onChange,
      required this.index});

  final String title;
  final IconData iconData;
  final Color iconColor;

  final bool check;
  final iconBgColor;
  final Function? onChange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff4e616a),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Colors.grey,
                checkColor: Color(0xff0e3e26),
                value: check,
                onChanged: (bool? change) {
                  onChange!(index);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        iconData,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration:
                                check ? TextDecoration.lineThrough : null),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
