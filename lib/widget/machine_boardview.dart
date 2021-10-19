import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:flutter/material.dart';
import 'package:koutei_kanban/api/data_api.dart';
import 'package:koutei_kanban/model/machine_status.dart';

class MachineBoardView extends StatefulWidget {
  const MachineBoardView({
    Key? key,
  }) : super(key: key);

  @override
  State<MachineBoardView> createState() => _MachineBoardViewState();
}

class _MachineBoardViewState extends State<MachineBoardView> {
  @override
  Widget build(BuildContext context) {
    // A Create Board Header Column With String List
    List<String> boardColumns = ['PLAN', 'WIP', 'DONE'];
    // B Create Array of Board List Object in the eventually it will be used in BoardView
    List<BoardList> boardLists;
    // C Create Array of Board Item Object in the eventually it will be used in BoardList
    List<BoardItem> boardItems;
    // Color parameter
    Color? boardColor;
    // status
    int? status;

    return FutureBuilder(
        future: DataApi.loadMachineStatus('ED-12'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Clear Array of BoardList object
            boardLists = [];
            var machstats = snapshot.data as List<MachineStatus>;
            // var machstats = snapshot.data as List<MachineStatus>;
            //A Loop inside Board Header Column to Create Array of Board List

            for (String boardColumn in boardColumns) {
              if (boardColumn == 'PLAN') {
                boardColor = Colors.green[300];
              } else if (boardColumn == 'WIP') {
                boardColor = Colors.pink[300];
              } else {
                boardColor = Colors.yellow[300];
              }
              // Clear Array of Board Item
              boardItems = [];
              for (MachineStatus machstat in machstats) {
                if (machstat.status == boardColumn) {
                  BoardItem boardItem = BoardItem(
                    onDropItem: (int? listIndex,
                        int? itemIndex,
                        int? oldListIndex,
                        int? oldItemIndex,
                        BoardItemState state) {
                      if (listIndex == 0) {
                        status = 1;
                      } else if (listIndex == 1) {
                        status = 2;
                      } else if (listIndex == 2) {
                        status = 4;
                      }
                      setState(() {
                        DataApi.updateMachineStatus(machstat.barcode, status);
                      });
                    },
                    item: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: boardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              machstat.jobno.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            Text(machstat.jobnm1.toString(),
                                style: const TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                  );
                  boardItems.add(boardItem);
                }
              }
              // Run 3 times Create PLAN, WIP, DONE for Board List
              // B Create Single BoardList object and initial header with (A) Column Header
              BoardList boardList = BoardList(
                backgroundColor: Colors.blue[50],
                items: boardItems,
                header: [
                  Row(
                    children: [
                      const Icon(Icons.lock_clock),
                      Text(boardColumn,
                          style: const TextStyle(color: Colors.black))
                    ],
                  )
                ],
              );
              // B Add Single of BoardList object into Array of BoardList object
              boardLists.add(boardList);
            }

            // B Received Array of Board List Object
            return BoardView(
              lists: boardLists,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
