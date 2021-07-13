import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login/theme.dart';
import 'package:flutter_login/widgets.dart';
import 'package:password_manager/new_record.dart';
import 'package:password_manager/dummy_data/password_info_dump.dart';
import 'package:password_manager/widgets/build_data_table.dart';
import 'routes/transition_route_observer.dart';
import 'widgets/fade_in.dart';
import 'constants.dart';
import 'widgets/animated_numeric_text.dart';
import 'widgets/round_button.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/')
        // we dont want to pop the screen, just replace it completely
        .then((_) => false);
  }

  final routeObserver = TransitionRouteObserver<PageRoute?>();
  static const headerAniInterval = Interval(.1, .3, curve: Curves.easeOut);
  late Animation<double> _headerScaleAnimation;
  AnimationController? _loadingController;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );

    _headerScaleAnimation =
        Tween<double>(begin: .6, end: 1).animate(CurvedAnimation(
      parent: _loadingController!,
      curve: headerAniInterval,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute<dynamic>?);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _loadingController!.dispose();
    super.dispose();
  }

  @override
  void didPushAfterTransition() => _loadingController!.forward();

  AppBar _buildAppBar(ThemeData theme) {
    final menuBtn = IconButton(
      color: theme.accentColor,
      icon: const Icon(FontAwesomeIcons.bars),
      // TODO:Build a menu bar
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Menu Bar"),
                content: new Text("Will finish later!"),
              );
            });
      },
    );
    final signOutBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.signOutAlt),
      color: theme.accentColor,
      onPressed: () => _goToLogin(context),
    );
    final title = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Hero(
              tag: Constants.logoTag,
              child: Image.asset(
                'assets/images/ecorp.png',
                filterQuality: FilterQuality.high,
                height: 30,
              ),
            ),
          ),
          HeroText(
            Constants.appName,
            tag: Constants.titleTag,
            viewState: ViewState.shrunk,
            style: LoginThemeHelper.loginTextStyle,
          ),
          SizedBox(width: 20),
        ],
      ),
    );

    return AppBar(
      leading: FadeIn(
        controller: _loadingController,
        offset: .3,
        curve: headerAniInterval,
        fadeDirection: FadeDirection.startToEnd,
        child: menuBtn,
      ),
      actions: <Widget>[
        FadeIn(
          controller: _loadingController,
          offset: .3,
          curve: headerAniInterval,
          fadeDirection: FadeDirection.endToStart,
          child: signOutBtn,
        ),
      ],
      title: title,
      backgroundColor: theme.primaryColor.withOpacity(.1),
      elevation: 0,
      textTheme: theme.accentTextTheme,
      iconTheme: theme.accentIconTheme,
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final primaryColor =
        Colors.primaries.where((c) => c == theme.primaryColor).first;
    final accentColor =
        Colors.primaries.where((c) => c == theme.accentColor).first;
    final linearGradient = LinearGradient(colors: [
      primaryColor.shade800,
      primaryColor.shade200,
    ]).createShader(Rect.fromLTWH(0.0, 0.0, 418.0, 78.0));

    return ScaleTransition(
      scale: _headerScaleAnimation,
      child: FadeIn(
        controller: _loadingController,
        curve: headerAniInterval,
        fadeDirection: FadeDirection.bottomToTop,
        offset: .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '\$',
                  style: theme.textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: accentColor.shade400,
                  ),
                ),
                SizedBox(width: 5),
                AnimatedNumericText(
                  initialValue: 14,
                  targetValue: 3467.87,
                  curve: Interval(0, .5, curve: Curves.easeOut),
                  controller: _loadingController!,
                  style: theme.textTheme.headline3!.copyWith(
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {Widget? icon, String? label, required Interval interval}) {
    return RoundButton(
      icon: icon,
      label: label,
      loadingController: _loadingController,
      interval: Interval(
        interval.begin,
        interval.end,
        curve: ElasticOutCurve(0.42),
      ),
      onPressed: () {},
    );
  }

  Widget _buildDashboardGrid() {
    return BuildDataTable();
  }

  Widget _buildDebugButtons() {
    const textStyle = TextStyle(fontSize: 12, color: Colors.white);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.red,
            onPressed: () => _loadingController!.value == 0
                ? _loadingController!.forward()
                : _loadingController!.reverse(),
            child: Text('loading', style: textStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // void _startAddNewRecord(BuildContext ctx) {
    //   showModalBottomSheet(
    //     context: ctx,
    //     builder: (_) {
    //       return GestureDetector(
    //         onTap: () {},
    //         child: NewRecord(),
    //         behavior: HitTestBehavior.opaque,
    //       );
    //     },
    //   );
    // }
    void _startAddNewRecord(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewRecord();
        },
      );
    }

    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(theme),
          backgroundColor: Colors.grey[200],
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor.withOpacity(.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildDashboardGrid(),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.orangeAccent),
                        padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.all(30),
                        ),
                      ),
                      label: Text(
                        "Generate Password",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        final password = RandomPasswordGenerator();
                        String newPassword = password.randomPassword(
                          letters: true,
                          numbers: true,
                          uppercase: true,
                          specialChar: true,
                          passwordLength: 12,
                        );
                        print(newPassword);

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Generate Password"),
                                content: Text(newPassword),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(text: newPassword),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Copy"),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.add),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.orangeAccent),
                        padding: MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.fromLTRB(60, 30, 60, 30)),
                      ),
                      label: Text(
                        "Add Record",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () => _startAddNewRecord(context),
                      // onPressed: () {
                      //   showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return new AlertDialog(
                      //           title: new Text("Add Record"),
                      //           content: new Text("Will finish later!"),
                      //         );
                      //       });
                      // },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              //
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void reassemble() {

  }
}
