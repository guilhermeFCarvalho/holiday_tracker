import 'package:flutter/material.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

class HolidayWidget extends StatefulWidget {
  final HolidayDto dto;

  const HolidayWidget({
    super.key,
    required this.dto,
  });

  @override
  State<HolidayWidget> createState() => _HolidayWidgetState();
}

class _HolidayWidgetState extends State<HolidayWidget> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.dto.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.dto.holiday.localName),
        const Spacer(),
        Text(widget.dto.holiday.date),
        IconButton(
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          icon: Icon(
            Icons.bookmark,
            color: _isFavorite ? Colors.yellow : null,
          ),
        )
      ],
    );
  }
}
