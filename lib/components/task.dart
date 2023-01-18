import 'package:flutter/material.dart';
import 'package:flutter_tasklist/components/difficulty.dart';
import 'package:flutter_tasklist/data/task_dao.dart';

class Task extends StatefulWidget {
  final String name;
  final String photo;
  final int difficulty;

  Task(this.name, this.photo, this.difficulty, {Key? key}) : super(key: key);

  int level = 1;
  int belt = 1;
  bool buttonIsActive = true;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.photo.contains('http')) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: (widget.belt == 2)
                      ? Colors.amber
                      : (widget.belt == 3)
                      ? Colors.green
                      : (widget.belt == 4)
                      ? Colors.red
                      : (widget.belt == 5)
                      ? Colors.black
                      : Colors.blue),
              height: 140),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(widget.photo, fit: BoxFit.cover)
                              : Image.network(widget.photo, fit: BoxFit.cover)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        Difficulty(difficultyLevel: widget.difficulty),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Deleting the task \"${widget.name}\""),
                                  content: Text("Are you sure you want to delete it?"),
                                  actions: [
                                    TextButton(onPressed: (){Navigator.pop(context);},
                                        child: Text("No")),
                                    TextButton(onPressed: (){
                                      TaskDAO().delete(widget.name);
                                      Navigator.pop(context);
                                      setState(() {});
                                    }, child: Text("Yes")),
                                  ],
                                ),
                            );
                          },
                          onPressed: () {
                            setState(() {
                              if (widget.belt < 5) {
                                if (widget.level < (widget.difficulty * 10)) {
                                  // if it's not the last level
                                  widget.level++;
                                } else {
                                  // if it is the last level
                                  widget.level = 1;
                                  widget.belt++;
                                }
                              } else {
                                // if it's within belt 5
                                if (widget.level <
                                    ((widget.difficulty * 10) - 1)) {
                                  // if it's below the last level
                                  widget.level++;
                                } else if (widget.level ==
                                    (widget.difficulty * 10) - 1) {
                                  //if it's at the one but last step
                                  widget.level++;
                                  widget.buttonIsActive = false;
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.buttonIsActive
                                ? Colors.blue
                                : Colors.black26,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              (widget.buttonIsActive
                                  ? const Icon(Icons.arrow_drop_up)
                                  : const Icon(Icons.circle_outlined)),
                              Text(
                                (widget.buttonIsActive ? 'UP' : 'OFF'),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.difficulty > 0)
                            ? (widget.level / widget.difficulty) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Belt: ${widget.belt}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Level: ${widget.level}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
