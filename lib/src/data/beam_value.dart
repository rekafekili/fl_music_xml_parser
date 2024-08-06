// ref: https://www.w3.org/2021/06/musicxml40/musicxml-reference/data-types/beam-value/

enum BeamValue {
  none(value: 'none'),
  backwardHook(value: 'backward hook'),
  begin(value: 'begin'),
  continue_(value: 'continue'),
  end(value: 'end'),
  forwardHook(value: 'forward hook');

  const BeamValue({required this.value});

  final String value;

  static BeamValue fromString(String value) {
    return BeamValue.values.firstWhere((e) => e.value == value);
  }
}
