import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/features/booking/screen/booking_screen.dart';
import 'package:trivago/models/room_models/room_model.dart';
import 'package:trivago/models/room_models/room_model_data.dart';

class DistrictView extends ConsumerStatefulWidget {
  const DistrictView({super.key});

  @override
  ConsumerState createState() => _DistrictViewState();
}

class _DistrictViewState extends ConsumerState<DistrictView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
          children: DistrictsID.values
              .map((e) => DistrictRoom(
                    rooms: roomData[e]!,
                  ))
              .toList()),
    );
  }
}

class DistrictRoom extends StatefulWidget {
  const DistrictRoom({super.key, required this.rooms});
  final List<RoomModel> rooms;
  @override
  State<DistrictRoom> createState() => _DistrictRoomState();
}

class _DistrictRoomState extends State<DistrictRoom> {
  @override
  build(BuildContext context) {
    return ListView(
      children: [
        for (RoomModel room in widget.rooms)
          DistrictTiles(
            roomModel: room,
          )
      ],
    );
  }
}
