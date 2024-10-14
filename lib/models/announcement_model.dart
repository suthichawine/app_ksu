class Announcement {
  final String id;
  final String title;
  final String date;
  final String content;

  Announcement({required this.id, required this.title, required this.date, required this.content});

  factory Announcement.fromMap(Map<String, dynamic> data, String id) {
    return Announcement(
      id: id,
      title: data['title'],
      date: data['date'],
      content: data['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'content': content,
    };
  }
}
