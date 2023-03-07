import 'package:flutter/material.dart';

class SavedCitiesContainer extends StatelessWidget {
  final String cityName;
  final Function() onPressed;
  final Function() delete;

  SavedCitiesContainer(
      {required this.delete,
      required this.cityName,
      required this.onPressed,
      super.key}) {
    super.key;
  }

  void showConfirmationDialog(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 262.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10.0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 0,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteAlertDialog(cityName: cityName, delete: delete);
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
             // const Spacer(),
              Flexible(
                child: Center(
                    child: Text(
                  cityName,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w400,),
                )),
              ),
              //const Spacer(),
              Flexible(
                flex: 0,
                child: IconButton(
                  padding: const EdgeInsets.only(
                    right: 13.0,
                  ),
                  alignment: AlignmentDirectional.centerEnd,
                  onPressed: onPressed,
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  //replace with our own icon data.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    Key? key,
    required this.cityName,
    required this.delete,
  }) : super(key: key);

  final String cityName;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content:
          Text('Are you sure you want to delete $cityName?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop();
            delete();
          },
        ),
      ],
    );
  }
}
