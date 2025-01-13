// import 'package:flutter/material.dart';
// import 'package:real_time_collaboration_application/common/colors.dart';

// class MembersDropdown extends StatelessWidget {
//   List<String> membersName = [];
//   List<String> selectedMembers = [];
//    MembersDropdown({super.key, required this.membersName, required this.selectedMembers});

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       isExpanded: true,
//       hint: const Text("Select Members"),
//       value:
//           null, // Leave value as null to manage the selection with checkboxes
//       onChanged:
//           (value) {}, // We don't need to update the value here as we manage selection with checkboxes
//       items: membersName.map((String member) {
//         return DropdownMenuItem<String>(
//           value: member,
//           child: StatefulBuilder(
//             builder: (context, setState) {
//               return CheckboxListTile(
//                 title: Row(
//                   children: [
//                     const SizedBox(width: 8.0),
//                     Text(
//                       member,
//                       style: const TextStyle(
//                           color: Colors.black), // Display member name
//                     ),
//                   ],
//                 ),
//                 value: selectedMembers.contains(
//                     member), // Checked state based on whether the member is selected
//                 onChanged: (bool? value) {
//                   setState(() {
//                     if (value == true) {
//                       // Add member to the selectedMembers list if checked
//                       selectedMembers.add(member);
//                     } else {
//                       // Remove member from the selectedMembers list if unchecked
//                       selectedMembers.remove(member);
//                     }
//                   });
//                 },
//                 checkColor: Colors
//                     .white, // Set the color of the tick mark (checked state)
//                 activeColor:
//                     textColor2, // Set the background color of the checkbox when selected
//                 side: const BorderSide(
//                     color: Colors.grey,
//                     width: 1.5), // Border color and width for checkbox
//               );
//             },
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/common/colors.dart';

class MembersDropdown extends StatelessWidget {
  final List<String> membersName;
  final List<String> selectedMembers;
  final Function(List<String>)? onSelectionChanged; // Add the onSelectionChanged callback

  // Update the constructor to accept membersName, selectedMembers, and onSelectionChanged
  MembersDropdown({
    super.key,
    required this.membersName,
    required this.selectedMembers,
     this.onSelectionChanged,  // Add the required onSelectionChanged parameter
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      hint: const Text("Select Members"),
      value: null, // Leave value as null to manage the selection with checkboxes
      onChanged: (value) {}, // We don't need to update the value here as we manage selection with checkboxes
      items: membersName.map((String member) {
        return DropdownMenuItem<String>(
          value: member,
          child: StatefulBuilder(
            builder: (context, setState) {
              return CheckboxListTile(
                title: Row(
                  children: [
                    const SizedBox(width: 8.0),
                    Text(
                      member,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                value: selectedMembers.contains(member), // Checked state based on whether the member is selected
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      // Add member to the selectedMembers list if checked
                      selectedMembers.add(member);
                    } else {
                      // Remove member from the selectedMembers list if unchecked
                      selectedMembers.remove(member);
                    }

                    // Call the onSelectionChanged callback to update the parent
                    onSelectionChanged!(selectedMembers);
                  });
                },
                checkColor: Colors.white, // Set the color of the tick mark (checked state)
                activeColor: textColor2, // Set the background color of the checkbox when selected
                side: const BorderSide(color: Colors.grey, width: 1.5), // Border color and width for checkbox
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
