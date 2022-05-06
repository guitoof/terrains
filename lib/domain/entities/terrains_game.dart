class TerrainsGame {
  final int width;
  final int height;

  TerrainsGame({
    required this.width,
    required this.height,
  });

  Map<String, dynamic> toMap() => {
        'grid': {
          'width': width,
          'height': height,
        },
      };
}
