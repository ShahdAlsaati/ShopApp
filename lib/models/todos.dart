class Album{
  final userId;
  final id;
  final title;
  final completed;
  Album({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,

  });
  factory Album.fromJson(Map<String,dynamic>parseJson){
   return Album(id: parseJson["id"],
       userId: parseJson["userId"],
       title: parseJson["title"],
       completed: parseJson["completed"]) ;
  }

}