import 'package:devquiz/challenge/challenge_page.dart';
import 'package:devquiz/shared/models/quiz_model.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:devquiz/home/widgets/level_button/level_button_widget.dart';
import 'package:devquiz/home/widgets/quiz_card/quiz_card_widget.dart';

import 'home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    controller.currentFilterLevelNotifier.addListener(() {
      setState(() {});
    });
  }

  void onChangeFilter(value) {
    controller.currentFilterLevel = value;
    controller.getQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(user: controller.user!),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(width: 10),
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    LevelButtonWidget(
                        optionLevel: Level.all,
                        onTap: onChangeFilter,
                        isSelected: Level.all == controller.currentFilterLevel),
                    SizedBox(width: 10),
                    LevelButtonWidget(
                        optionLevel: Level.easy,
                        onTap: onChangeFilter,
                        isSelected:
                            Level.easy == controller.currentFilterLevel),
                    SizedBox(width: 10),
                    LevelButtonWidget(
                        optionLevel: Level.middle,
                        onTap: onChangeFilter,
                        isSelected:
                            Level.middle == controller.currentFilterLevel),
                    SizedBox(width: 10),
                    LevelButtonWidget(
                        optionLevel: Level.hard,
                        onTap: onChangeFilter,
                        isSelected:
                            Level.hard == controller.currentFilterLevel),
                    SizedBox(width: 10),
                    LevelButtonWidget(
                        optionLevel: Level.expert,
                        onTap: onChangeFilter,
                        isSelected:
                            Level.expert == controller.currentFilterLevel),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  children: controller.quizzes!
                      .map(
                        (e) => QuizCardWidget(
                          title: e.title,
                          completed:
                              '${e.questionAnswered}/${e.questions.length}',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChallengePage(
                                    title: e.title,
                                    questions: e.questions,
                                  ),
                                ));
                          },
                          percent: e.questionAnswered / e.questions.length,
                          image: e.image,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
