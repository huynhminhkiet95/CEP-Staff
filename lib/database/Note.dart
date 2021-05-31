class Note {
    int id;
    String contents;

    Note({
        this.id,
        this.contents,
    });

    // Create a Note from JSON data
    factory Note.fromJson(Map<String, dynamic> json) => new Note(
        id: json["id"],
        contents: json["contents"],
    );

    // Convert our Note to JSON to make it easier when we store it in the database
    Map<String, dynamic> toJson() => {
        "id": id,
        "contents": contents,
    };
}