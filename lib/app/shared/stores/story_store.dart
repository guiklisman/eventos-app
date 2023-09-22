import 'package:flutter_triple/flutter_triple.dart';

import '../../shared/repository/repository.dart';

import '../models/story_model.dart';

class StoryStore extends NotifierStore<Exception, List<StoryModel>> {
  final Repository _repository;
  StoryStore(this._repository) : super([]);

  Future<List<StoryModel>> getStoryAtivos() async {
    setLoading(true);
    List<StoryModel> story = [];
    final response = await _repository.getStoryAtivos();
    response.fold(setError, (r) {
      story.addAll(r);
      update(r);
    });
    setLoading(false);

    return story;
  }
}
