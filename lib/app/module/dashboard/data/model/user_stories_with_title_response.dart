class UserStoriesWithTitle {
  String? userStory;
  String? title;

  UserStoriesWithTitle({this.userStory, this.title});

  UserStoriesWithTitle.fromJson(Map<String, dynamic> json) {
    userStory = json['userStory'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userStory'] = userStory;
    data['title'] = title;
    return data;
  }
}
