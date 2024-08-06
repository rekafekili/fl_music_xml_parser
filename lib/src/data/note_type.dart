// ref: https://www.w3.org/2021/06/musicxml40/musicxml-reference/data-types/note-type-value/

enum NoteType {
  none(value: ""),
  maxima(value: "maxima"),
  long(value: "long"),
  breve(value: "breve"),
  whole(value: "whole"),
  half(value: "half"),
  quarter(value: "quarter"),
  eighth(value: "eighth"),
  sixteenth(value: "16th"),
  thirtySecond(value: "32nd"),
  sixtyFourth(value: "64th"),
  hundredTwentyEighth(value: "128th"),
  twoHundredFiftySixth(value: "256th"),
  fiveHundredTwelfth(value: "512th"),
  oneThousandTwentyFourth(value: "1024th");

  const NoteType({required this.value});

  final String value;

  static NoteType fromString(String value) {
    return NoteType.values.firstWhere((e) => e.value == value);
  }
}
