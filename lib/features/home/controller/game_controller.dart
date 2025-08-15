import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sludoko/core/config/constants/app_assets.dart';
import 'package:sludoko/core/widgets/utils/shared_prefs.dart';
import 'package:sludoko/service_locator.dart';

enum SudokuColor {
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
  pink,
  teal,
  lightBlue,
}

String getColorImage(SudokuColor color) => AppImages.colors[color.index];

class SudokuController extends GetxController {
  final storage = locator<SharedPrefs>();

  final RxList<List<SudokuColor?>> puzzle = RxList.generate(
    9,
    (_) => List<SudokuColor?>.filled(9, null),
  );

  final RxList<List<SudokuColor?>> solution = RxList.generate(
    9,
    (_) => List<SudokuColor?>.filled(9, null),
  );

  final RxList<List<bool>> fixed = RxList.generate(
    9,
    (_) => List<bool>.filled(9, false),
  );

  RxInt mistakes = 0.obs;
  final Rx<Point<int>?> selectedCell = Rx<Point<int>?>(null);
  Rx<SudokuColor?> selectedColor = Rx<SudokuColor?>(null);

  Timer? timer;
  final RxInt seconds = 0.obs;

  Future<void> saveGameState() async {
    List<int> puzzleList = [];
    for (var row in puzzle) {
      for (var color in row) {
        puzzleList.add(color?.index ?? -1);
      }
    }

    List<int> fixedList = [];
    for (var row in fixed) {
      for (var f in row) {
        fixedList.add(f ? 1 : 0);
      }
    }

    List<int> solutionList = [];
    for (var row in solution) {
      for (var color in row) {
        solutionList.add(color?.index ?? -1);
      }
    }

    await storage.setStringList(
      'puzzle',
      puzzleList.map((e) => e.toString()).toList(),
    );
    await storage.setStringList(
      'fixed',
      fixedList.map((e) => e.toString()).toList(),
    );
    await storage.setStringList(
      'solution',
      solutionList.map((e) => e.toString()).toList(),
    );
    await storage.setInt('mistakes', mistakes.value);
    await storage.setInt('seconds', seconds.value);

    await storage.setInt('selectedColor', selectedColor.value?.index ?? -1);
    timer?.cancel();

    Get.back();
  }

  Future<int?> loadGameState() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('puzzle')) return null;

    List<String> puzzleStr = prefs.getStringList('puzzle')!;
    List<List<SudokuColor?>> loadedPuzzle = List.generate(
      9,
      (i) => List.filled(9, null),
    );
    for (int i = 0; i < 81; i++) {
      int val = int.parse(puzzleStr[i]);
      loadedPuzzle[i ~/ 9][i % 9] = val == -1 ? null : SudokuColor.values[val];
    }

    List<String> fixedStr = prefs.getStringList('fixed')!;
    List<List<bool>> loadedFixed = List.generate(
      9,
      (i) => List.filled(9, false),
    );
    for (int i = 0; i < 81; i++) {
      loadedFixed[i ~/ 9][i % 9] = fixedStr[i] == '1';
    }

    List<String> solutionStr = prefs.getStringList('solution')!;
    List<List<SudokuColor?>> loadedSolution = List.generate(
      9,
      (i) => List.filled(9, null),
    );
    for (int i = 0; i < 81; i++) {
      int val = int.parse(solutionStr[i]);
      loadedSolution[i ~/ 9][i % 9] = val == -1
          ? null
          : SudokuColor.values[val];
    }

    puzzle.assignAll(loadedPuzzle);
    fixed.assignAll(loadedFixed);
    solution.assignAll(loadedSolution);

    mistakes.value = prefs.getInt('mistakes') ?? 0;

    int savedSeconds = prefs.getInt('seconds') ?? 0;

    int selectedColorIndex = prefs.getInt('selectedColor') ?? -1;
    selectedColor.value = selectedColorIndex == -1
        ? null
        : SudokuColor.values[selectedColorIndex];

    update();

    return savedSeconds;
  }

  void generatePuzzle(int filled) {
    for (int i = 0; i < 9; i++) {
      puzzle[i] = List<SudokuColor?>.filled(9, null);
      fixed[i] = List<bool>.filled(9, false);
    }

    _solveSudoku(0, 0);

    for (int i = 0; i < 9; i++) {
      solution[i] = [...puzzle[i]];
    }

    final rng = Random();
    int cellsToRemove = 81 - filled;

    while (cellsToRemove > 0) {
      int r = rng.nextInt(9);
      int c = rng.nextInt(9);
      if (puzzle[r][c] != null) {
        puzzle[r][c] = null;
        cellsToRemove--;
      }
    }

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        fixed[i][j] = puzzle[i][j] != null;
      }
    }
    update();
  }

  bool _solveSudoku(int row, int col) {
    if (row == 9) return true;
    if (col == 9) return _solveSudoku(row + 1, 0);
    if (puzzle[row][col] != null) return _solveSudoku(row, col + 1);

    for (var color in SudokuColor.values) {
      if (_isSafe(row, col, color)) {
        puzzle[row][col] = color;
        if (_solveSudoku(row, col + 1)) return true;
        puzzle[row][col] = null;
      }
    }
    return false;
  }

  bool _isSafe(int row, int col, SudokuColor color) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[row][i] == color || puzzle[i][col] == color) return false;
    }
    int startRow = row - row % 3, startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (puzzle[startRow + i][startCol + j] == color) return false;
      }
    }
    return true;
  }

  void restartPuzzle() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (!fixed[i][j]) {
          puzzle[i][j] = null;
        } else {
          puzzle[i][j] = solution[i][j];
        }
      }
    }
    mistakes.value = 0;
    seconds.value = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds.value++;
    });
    Get.back();
    update();
  }

  bool checkSolution() {
    for (var row in puzzle) {
      if (!row.contains(null)) {
        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 9; j++) {
            if (puzzle[i][j] != solution[i][j]) {
              return false;
            }
          }
        }
      } else {
        return false; // If any row contains null, the solution is not complete
      }
    }
    
    timer?.cancel();
    return true;
  }

  void setColor(int row, int col, SudokuColor color) {
    if (!fixed[row][col]) {
      puzzle[row][col] = color;

      if (!(color == solution[row][col])) {
        mistakes.value++;

        if (mistakes.value == 3) {
          timer?.cancel();
        }
      }
      update();
    }
  }

  void selectColor(SudokuColor color) {
    selectedColor.value = color;
  }

  void insertColor(SudokuColor color) {
    final cell = selectedCell.value;
    if (cell == null || fixed[cell.x][cell.y]) return;
    puzzle[cell.x][cell.y] = color;
    update();
  }

  void selectCell(int row, int col) {
    selectedCell.value = Point(row, col);
  }

  void clearCell() {
    final cell = selectedCell.value;
    if (cell == null || fixed[cell.x][cell.y]) return;
    puzzle[cell.x][cell.y] = null;
    update();
  }
}

enum Difficulty { easy, medium, hard }
