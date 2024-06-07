import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/notification.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_listview.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationEntity> notifications = [
      NotificationEntity(time: DateTime(2024, 6, 4, 9, 36), category: 'Bill', content: 'Your host, Đỗ Quốc Hùng has publish a bill for your room,',
      title: 'Bill'),
            NotificationEntity(time: DateTime(2024, 6, 1, 7, 00), category: 'Appointment', content: "You will have an appointment with Trần Tiến Đạt to discuss about room Phòng 40 at Nhà trọ Cầu Ông Bố today",
      title: 'Appointment'),
    ];
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.check),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: CommonListView(
            items: notifications,
            builder: (context, index) {
              var notification = notifications[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      notification.category == 'Bill' ? Icon(Icons.info_outline) : Icon(Icons.calendar_month),
                      Expanded(
                        child: ListTile(
                          title: Text(notification.title ?? 'Notification'),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.content ?? ''),
                                const SizedBox(height: 5,),
                                Text(notification.time != null ? DateFormat('hh:mm - dd, MMM yyyy').format(notification.time!) : '')
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
