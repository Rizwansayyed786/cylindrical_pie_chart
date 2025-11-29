import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A customizable pie chart widget with cylindrical tubes arranged in a circular format.
/// 
/// Creates a hollow circular ring (tube) with customizable inner and outer radius.
/// The inner area is completely transparent/hollow.
class CylindricalPieChart extends StatelessWidget {
  /// Number of segments in the pie chart (3, 4, 5, etc.)
  final int numberOfSegments;
  
  /// List of colors for each segment. If fewer colors than segments, colors will repeat.
  final List<Color> segmentColors;
  
  /// Optional list of angles (in radians) for each segment. 
  /// If provided, must have same length as numberOfSegments.
  /// If null, segments will be equally distributed.
  final List<double>? segmentAngles;
  
  /// Inner radius of the circular ring (defines the hollow center)
  final double innerRadius;
  
  /// Outer radius of the circular ring
  final double outerRadius;
  
  /// Radius of the dotted inner circle. If null, defaults to innerRadius - 5
  final double? dottedCircleRadius;
  
  /// Gap angle between segments in radians. 
  /// If gapAngleDegrees is provided, this will be ignored.
  /// Defaults to 0.1 (about 5.7 degrees)
  final double? gapAngle;
  
  /// Gap angle between segments in degrees. 
  /// If provided, this takes precedence over gapAngle.
  /// Defaults to null (uses gapAngle instead)
  final double? gapAngleDegrees;
  
  /// Optional child widget to display in the center of the chart
  final Widget? centerChild;
  
  /// Optional padding around the chart
  final EdgeInsets? padding;
  
  /// Whether to show divider lines from center
  final bool showDividers;

  CylindricalPieChart({
    super.key,
    required this.numberOfSegments,
    required this.segmentColors,
    this.segmentAngles,
    required this.innerRadius,
    required this.outerRadius,
    this.dottedCircleRadius,
    this.gapAngle,
    this.gapAngleDegrees,
    this.centerChild,
    this.padding,
    this.showDividers = true,
  })  : assert(numberOfSegments > 0, 'Number of segments must be greater than 0'),
        assert(segmentColors.isNotEmpty, 'At least one color must be provided'),
        assert(innerRadius > 0, 'Inner radius must be greater than 0'),
        assert(outerRadius > innerRadius, 'Outer radius must be greater than inner radius'),
        assert(
          dottedCircleRadius == null || dottedCircleRadius > 0,
          'Dotted circle radius must be greater than 0',
        ),
        assert(
          gapAngle == null || gapAngle >= 0,
          'Gap angle must be non-negative',
        ),
        assert(
          gapAngleDegrees == null || gapAngleDegrees >= 0,
          'Gap angle in degrees must be non-negative',
        ),
        assert(
          segmentAngles == null || segmentAngles.length == numberOfSegments,
          'segmentAngles must have same length as numberOfSegments',
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: CustomPaint(
        size: Size(
          outerRadius * 2,
          outerRadius * 2,
        ),
        painter: _CylindricalPieChartPainter(
          numberOfSegments: numberOfSegments,
          segmentColors: segmentColors,
          segmentAngles: segmentAngles,
          innerRadius: innerRadius,
          outerRadius: outerRadius,
          dottedCircleRadius: dottedCircleRadius ?? (innerRadius - 5),
          gapAngle: gapAngleDegrees != null 
              ? (gapAngleDegrees! * math.pi / 180) 
              : (gapAngle ?? 0.1),
          showDividers: showDividers,
        ),
        // Center child will show through the hollow center
        child: centerChild != null
            ? Center(
                child: SizedBox(
                  width: innerRadius * 2,
                  height: innerRadius * 2,
                  child: centerChild,
                ),
              )
            : null,
      ),
    );
  }
}

class _CylindricalPieChartPainter extends CustomPainter {
  final int numberOfSegments;
  final List<Color> segmentColors;
  final List<double>? segmentAngles;
  final double innerRadius;
  final double outerRadius;
  final double dottedCircleRadius;
  final double gapAngle;
  final bool showDividers;

  _CylindricalPieChartPainter({
    required this.numberOfSegments,
    required this.segmentColors,
    this.segmentAngles,
    required this.innerRadius,
    required this.outerRadius,
    required this.dottedCircleRadius,
    required this.gapAngle,
    this.showDividers = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw segmented circular ring with gaps
    _drawSegmentedRing(
      canvas: canvas,
      center: center,
      innerRadius: innerRadius,
      outerRadius: outerRadius,
    );

    // Draw central circle with dotted outline (slightly inside inner radius)
    _drawCentralCircle(canvas: canvas, center: center, radius: dottedCircleRadius);
  }

  void _drawSegmentedRing({
    required Canvas canvas,
    required Offset center,
    required double innerRadius,
    required double outerRadius,
  }) {
    // Calculate segment angles
    final List<double> angles;
    if (segmentAngles != null) {
      angles = segmentAngles!;
    } else {
      // Calculate equal angles for each segment, accounting for gaps
      final totalGapAngle = gapAngle * numberOfSegments;
      final availableAngle = (2 * math.pi) - totalGapAngle;
      final equalAngle = availableAngle / numberOfSegments;
      angles = List.generate(numberOfSegments, (i) => equalAngle);
    }

    // Calculate start angles for each segment
    double currentAngle = -math.pi / 2; // Start from top
    final strokeWidth = outerRadius - innerRadius;
    final middleRadius = (innerRadius + outerRadius) / 2;
    
    // Calculate the angle consumed by rounded caps to ensure proper spacing
    // The rounded cap extends half the stroke width on each side
    final capAngle = math.atan(strokeWidth / (2 * middleRadius));

    // Draw each segment
    for (int i = 0; i < numberOfSegments; i++) {
      final segmentAngle = angles[i];
      // Adjust start and end angles to account for rounded caps
      // This ensures the caps don't extend into the gap
      final startAngle = currentAngle + capAngle;
      final endAngle = currentAngle + segmentAngle - capAngle;
      final color = segmentColors[i % segmentColors.length];

      // Only draw if the segment has positive length after accounting for caps
      if (endAngle > startAngle) {
        // Draw this segment as an arc
        _drawRingSegment(
          canvas: canvas,
          center: center,
          startAngle: startAngle,
          endAngle: endAngle,
          middleRadius: middleRadius,
          strokeWidth: strokeWidth,
          color: color,
        );
      }

      // Move to next segment position (add gap)
      // The gap is naturally transparent since we don't draw anything there
      currentAngle = currentAngle + segmentAngle + gapAngle;
    }
  }

  void _drawRingSegment({
    required Canvas canvas,
    required Offset center,
    required double startAngle,
    required double endAngle,
    required double middleRadius,
    required double strokeWidth,
    required Color color,
  }) {
    // Create path for the arc segment
    // The arc will be drawn with rounded caps that don't extend into gaps
    final segmentPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: middleRadius),
        startAngle,
        endAngle - startAngle,
      );

    // Create sweep gradient for cylindrical effect
    final gradient = SweepGradient(
      center: Alignment.center,
      startAngle: startAngle,
      endAngle: endAngle,
      colors: [
        color,
        color.withValues(alpha: 0.95),
        color,
        color.withValues(alpha: 0.9),
      ],
      stops: const [0.0, 0.25, 0.5, 1.0],
    );

    // Create paint with gradient and thick stroke
    // Use StrokeCap.round to make the ends of segments circular/rounded
    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(
          center.dx - middleRadius - strokeWidth / 2,
          center.dy - middleRadius - strokeWidth / 2,
          (middleRadius + strokeWidth / 2) * 2,
          (middleRadius + strokeWidth / 2) * 2,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Rounded ends for circular appearance

    // Draw the segment as a thick stroke arc with rounded ends
    // The rounded caps will be contained within the arc path, not extending into gaps
    canvas.drawPath(segmentPath, paint);
  }


  void _drawCentralCircle({
    required Canvas canvas,
    required Offset center,
    required double radius,
  }) {
    // Draw dotted circle outline
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    final circumference = 2 * math.pi * radius;
    final numberOfDashes = (circumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < numberOfDashes; i++) {
      final angle = (2 * math.pi * i) / numberOfDashes;
      final startX = center.dx + radius * math.cos(angle);
      final startY = center.dy + radius * math.sin(angle);
      final endX = center.dx + radius * math.cos(angle + (dashWidth / radius));
      final endY = center.dy + radius * math.sin(angle + (dashWidth / radius));

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CylindricalPieChartPainter oldDelegate) {
    return numberOfSegments != oldDelegate.numberOfSegments ||
        segmentColors != oldDelegate.segmentColors ||
        segmentAngles != oldDelegate.segmentAngles ||
        innerRadius != oldDelegate.innerRadius ||
        outerRadius != oldDelegate.outerRadius ||
        dottedCircleRadius != oldDelegate.dottedCircleRadius ||
        gapAngle != oldDelegate.gapAngle ||
        showDividers != oldDelegate.showDividers;
  }
}

