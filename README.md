# cylindrical_pie_chart

A beautiful and customizable Flutter widget for creating cylindrical pie charts with segmented rings, customizable colors, and hollow centers.

![Cylindrical Pie Chart Example](https://raw.githubusercontent.com/Rizwansayyed786/cylindrical_pie_chart/main/assets/example.png)

> **Note**: To add the example image, save your screenshot as `assets/example.png` in the package directory and push it to your GitHub repository.

## Features

- 🎨 **Customizable Segments**: Create pie charts with any number of segments (3, 4, 5, etc.)
- 🌈 **Custom Colors**: Assign different colors to each segment
- 📊 **Dynamic Segment Sizes**: Set segment sizes using percentage values or custom angles
- 🔘 **Hollow Center**: Transparent center area for displaying content
- 📏 **Configurable Radii**: Set inner and outer radius independently
- 🎯 **Gap Control**: Specify gaps between segments in degrees or radians
- ✨ **Dotted Circle**: Optional dotted inner circle with configurable radius and color
- 🎭 **3D Effect**: Beautiful gradient effects for a cylindrical appearance
- 🔄 **Rounded Ends**: Segments have rounded, circular ends
- 📐 **Divider Lines**: Optional white lines from center to visualize segment boundaries

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  cylindrical_pie_chart: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:cylindrical_pie_chart/cylindrical_pie_chart.dart';

CylindricalPieChart(
  numberOfSegments: 3,
  segmentColors: const [
    Color(0xFFE8D5C4), // Light beige
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
  ],
  innerRadius: 100.0,
  outerRadius: 140.0,
  gapAngleDegrees: 10.0,
  centerChild: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Ovulation Phase'),
      Text('Day 15', style: TextStyle(fontSize: 32)),
    ],
  ),
)
```

### Advanced Example with Dynamic Segment Sizes

```dart
CylindricalPieChart(
  numberOfSegments: 5,
  segmentColors: const [
    Color(0xFF4CAF50), // Green
    Color(0xFFE8D5C4), // Light beige
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF2196F3), // Blue
  ],
  segmentValues: const [
    20.0, // 20% - Green
    15.0, // 15% - Light beige
    30.0, // 30% - Pink (largest)
    25.0, // 25% - Purple
    10.0, // 10% - Blue (smallest)
  ], // Values are automatically normalized
  innerRadius: 150.0,
  outerRadius: 170.0,
  gapAngleDegrees: 5.0,
  dottedCircleRadius: 140.0,
  dottedCircleColor: Colors.blue.shade200,
  showDottedCircle: true,
  showDividers: true,
  padding: EdgeInsets.all(20.0),
  centerChild: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Ovulation Phase'),
      Text('Day 15', style: TextStyle(fontSize: 32)),
    ],
  ),
)
```

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `numberOfSegments` | `int` | Yes | - | Number of segments in the chart |
| `segmentColors` | `List<Color>` | Yes | - | Colors for each segment |
| `innerRadius` | `double` | Yes | - | Inner radius (hollow center) |
| `outerRadius` | `double` | Yes | - | Outer radius of the ring |
| `segmentAngles` | `List<double>?` | No | `null` | Custom angles for each segment (in radians) |
| `segmentValues` | `List<double>?` | No | `null` | Values/percentages for each segment (normalized automatically) |
| `dottedCircleRadius` | `double?` | No | `innerRadius - 5` | Radius of the dotted inner circle |
| `dottedCircleColor` | `Color?` | No | `Colors.grey.shade300` | Color of the dotted inner circle |
| `showDottedCircle` | `bool` | No | `true` | Whether to show the dotted inner circle |
| `gapAngle` | `double?` | No | `0.1` | Gap between segments in radians |
| `gapAngleDegrees` | `double?` | No | `null` | Gap between segments in degrees (takes precedence) |
| `centerChild` | `Widget?` | No | `null` | Widget to display in the center |
| `padding` | `EdgeInsets?` | No | `null` | Padding around the chart |
| `showDividers` | `bool` | No | `true` | Whether to show divider lines from center to segment boundaries |

## Examples

### 3 Segments with Custom Gaps

```dart
CylindricalPieChart(
  numberOfSegments: 3,
  segmentColors: [Colors.red, Colors.blue, Colors.green],
  innerRadius: 100.0,
  outerRadius: 140.0,
  gapAngleDegrees: 15.0, // 15 degree gaps
)
```

### Custom Segment Values (Percentages)

```dart
CylindricalPieChart(
  numberOfSegments: 3,
  segmentColors: [Colors.purple, Colors.pink, Colors.orange],
  segmentValues: [50.0, 30.0, 20.0], // 50%, 30%, 20% (normalized automatically)
  innerRadius: 100.0,
  outerRadius: 140.0,
)
```

### Custom Segment Angles

```dart
CylindricalPieChart(
  numberOfSegments: 3,
  segmentColors: [Colors.purple, Colors.pink, Colors.orange],
  segmentAngles: [
    3.1416,  // π radians = 180° (half circle)
    1.5708,  // π/2 radians = 90°
    1.5708,  // π/2 radians = 90°
  ],
  innerRadius: 100.0,
  outerRadius: 140.0,
)
```

### Customize Dotted Circle

```dart
CylindricalPieChart(
  numberOfSegments: 3,
  segmentColors: [Colors.red, Colors.blue, Colors.green],
  innerRadius: 100.0,
  outerRadius: 140.0,
  dottedCircleRadius: 95.0,
  dottedCircleColor: Colors.blue.shade200, // Custom color
  showDottedCircle: true, // Show/hide dotted circle
  showDividers: true, // Show/hide divider lines
)
```

## License

This project is licensed under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you encounter any issues or have questions, please file an issue on the [GitHub repository](https://github.com/yourusername/cylindrical_pie_chart/issues).

