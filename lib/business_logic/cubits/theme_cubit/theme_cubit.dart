import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.system));

  Future<void> getAppTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDark") != null) {
      prefs.getBool("isDark")!
          ? emit(ThemeState(themeMode: ThemeMode.dark))
          : emit(ThemeState(themeMode: ThemeMode.light));
    } else {
      emit(ThemeState(themeMode: ThemeMode.system));
    }
  }

  Future<void> setAppTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.getBool("isDark") != null) {
        prefs.getBool("isDark")!
            ? await prefs.setBool("isDark", false)
            : await prefs.setBool("isDark", true);
        getAppTheme();
      } else {
        await prefs.setBool("isDark", false);
        getAppTheme();
      }
    } catch (e) {
      emit(ThemeState(themeMode: ThemeMode.system));
    }
  }
}
