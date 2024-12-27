import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/model/team.dart';



class TeamProvider  extends ChangeNotifier{
  Team _team = Team(
    id: '',
    name: '',
    password: '',
    managerId: '',
    members: List.empty(),
  );

  Team get team => _team;

  void setTeam(String team) {
    _team = Team.fromJson(team);
    notifyListeners();
  }

  void setTeamFromModel(Team team) {
    _team = team;
    notifyListeners();
  }
}