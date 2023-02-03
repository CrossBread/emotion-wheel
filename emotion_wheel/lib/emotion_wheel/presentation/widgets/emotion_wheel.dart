import 'package:emotion_wheel/emotion_wheel/domain/entities/feeling_wheel_emotions.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

const heatmapData = [
  [0, 0, 10],
  [0, 1, 19],
  [0, 2, 8],
  [0, 3, 24],
  [0, 4, 67],
  [1, 0, 92],
  [1, 1, 58],
  [1, 2, 78],
  [1, 3, 117],
  [1, 4, 48],
  [2, 0, 35],
  [2, 1, 15],
  [2, 2, 123],
  [2, 3, 64],
  [2, 4, 52],
  [3, 0, 72],
  [3, 1, 132],
  [3, 2, 114],
  [3, 3, 19],
  [3, 4, 16],
  [4, 0, 38],
  [4, 1, 5],
  [4, 2, 8],
  [4, 3, 117],
  [4, 4, 115],
  [5, 0, 88],
  [5, 1, 32],
  [5, 2, 12],
  [5, 3, 6],
  [5, 4, 120],
  [6, 0, 13],
  [6, 1, 44],
  [6, 2, 88],
  [6, 3, 98],
  [6, 4, 96],
  [7, 0, 31],
  [7, 1, 1],
  [7, 2, 82],
  [7, 3, 32],
  [7, 4, 30],
  [8, 0, 85],
  [8, 1, 97],
  [8, 2, 123],
  [8, 3, 64],
  [8, 4, 84],
  [9, 0, 47],
  [9, 1, 114],
  [9, 2, 31],
  [9, 3, 48],
  [9, 4, 91]
];

class EmotionWheel extends StatelessWidget {
  final FeelingWheelEmotions emotions;
  final List<MaterialColor> colors;

  const EmotionWheel({super.key, required this.colors, required this.emotions});

  @override
  Widget build(BuildContext context) {
    var emotionData = [
      [1, 1, "core"],
      [2, 1, "core"],
      [3, 1, "core"],
      [1, 2, "sub"],
      [2, 2, "sub"],
      [3, 2, "sub"],
    ];

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            // width: 350,
            // height: 300,
            child: Chart(
              data: emotionData,
              variables: {
                'level': Variable(
                  accessor: (List datum) => datum[0].toString(),
                ),
                'variant': Variable(
                  accessor: (List datum) => datum[1].toString(),
                ),
                'name': Variable(
                  accessor: (List datum) => datum[2].toString(),
                ),
              },
              elements: [
                PolygonElement(
                  shape: ShapeAttr(
                      value: HeatmapShape(
                          sector: true,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10), right: Radius.circular(10)))),
                  label: LabelAttr(
                    encoder: (p0) => Label(p0['name']),
                  ),
                  color: ColorAttr(
                    variable: 'variant',
                    values: [const Color(0xffbae7ff), const Color(0xff1890ff), const Color(0xff0050b3)],
                    updaters: {
                      'tap': {false: (color) => color.withAlpha(70)}
                    },
                  ),
                )
              ],
              coord: PolarCoord(),
              selections: {'tap': PointSelection()},
              // tooltip: TooltipGuide(
              //   anchor: (_) => Offset.zero,
              //   align: Alignment.bottomRight,
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
