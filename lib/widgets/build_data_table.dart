import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/dummy_data/password_info_dump.dart';
import 'package:password_manager/model/password_info.dart';

class BuildDataTable extends StatelessWidget {
  final List<PasswordInfo> userRecords;

  BuildDataTable(this.userRecords);


  @override
  Widget build(BuildContext context) {
    // final colNum = 5;
    // final rowHeight = (MediaQuery.of(context).size.height - 56) / colNum;
    // final colHeight = (MediaQuery.of(context).size.width);

    print("Print BuildDataTable: ${(userRecords.map((e) => e.username)).toList()}");

    const headerFontSize = 22.0;

    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
      constraints: BoxConstraints(
        maxHeight: 500,
        minWidth: 1000,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 80,
          horizontalMargin: 50,

          // dataRowHeight: rowHeight,
          // headingRowHeight: 56,
          // headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          //   if (states.contains(MaterialState.hovered))
          //     return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          //   return Theme.of(context).colorScheme.primary.withOpacity(0.08);  // Use the default value.
          // }),
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.blueGrey),
              ),
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.blueGrey),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Title',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Username',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Password',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'URL',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Notes',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          // rows: DUMMY_INFO
            rows: userRecords
              .map((info) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // All rows will have the same selected color.
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                  }
                  // Even rows will have a grey color.
                  if (info.id.isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null; // Use default value for other states and odd rows.
                }),
                    //Extracting from Map element the value
                    cells: <DataCell>[
                      DataCell(
                        Text(info.title),
                      ),
                      DataCell(
                        Text(info.username),
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: info.username),
                          );
                        },
                      ),
                      DataCell(
                        Text(r"**************"),
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: info.password),
                          );
                        },
                      ),
                      // DataCell(
                      //   TextFormField(
                      //     obscureText: true,
                      //     enabled: true,
                      //       Hasan123
                      //   ),
                      // ),
                      DataCell(
                        Text(info.url),
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: info.url),
                          );
                        },
                      ),
                      DataCell(Text(info.notes)),
                      // DataCell(
                      //   TextFormField(
                      //     initialValue: info.notes,
                      //     keyboardType: TextInputType.text,
                      //     onFieldSubmitted: (val) {
                      //       print('onSubmitted $key $val');
                      //     },
                      //   ),
                      //   showEditIcon: true,
                      // ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
