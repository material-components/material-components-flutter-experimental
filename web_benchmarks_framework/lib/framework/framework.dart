// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

/// A result of running a single task.
class TaskResult {
  /// Constructs a successful result.
  TaskResult.success(this.data, {this.benchmarkScoreKeys = const <String>[]})
      : succeeded = true,
        message = 'success' {
    const JsonEncoder prettyJson = JsonEncoder.withIndent('  ');
    if (benchmarkScoreKeys != null) {
      for (final String key in benchmarkScoreKeys) {
        if (!data.containsKey(key)) {
          throw 'Invalid benchmark score key "$key". It does not exist in task '
              'result data ${prettyJson.convert(data)}';
        } else if (data[key] is! num) {
          throw 'Invalid benchmark score for key "$key". It is expected to be a num '
              'but was ${data[key].runtimeType}: ${prettyJson.convert(data[key])}';
        }
      }
    }
  }

  /// Constructs a successful result using JSON data stored in a file.
  factory TaskResult.successFromFile(File file,
      {List<String> benchmarkScoreKeys}) {
    return TaskResult.success(
      json.decode(file.readAsStringSync()) as Map<String, dynamic>,
      benchmarkScoreKeys: benchmarkScoreKeys,
    );
  }

  /// Constructs an unsuccessful result.
  TaskResult.failure(this.message)
      : succeeded = false,
        data = null,
        benchmarkScoreKeys = const <String>[];

  /// Whether the task succeeded.
  final bool succeeded;

  /// Task-specific JSON data
  final Map<String, dynamic> data;

  /// Keys in [data] that store scores that will be submitted to Cocoon.
  ///
  /// Each key is also part of a benchmark's name tracked by Cocoon.
  final List<String> benchmarkScoreKeys;

  /// Whether the task failed.
  bool get failed => !succeeded;

  /// Explains the result in a human-readable format.
  final String message;

  /// Serializes this task result to JSON format.
  ///
  /// The JSON format is as follows:
  ///
  ///     {
  ///       "success": true|false,
  ///       "data": arbitrary JSON data valid only for successful results,
  ///       "benchmarkScoreKeys": [
  ///         contains keys into "data" that represent benchmarks scores, which
  ///         can be uploaded, for example. to golem, valid only for successful
  ///         results
  ///       ],
  ///       "reason": failure reason string valid only for unsuccessful results
  ///     }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{
      'success': succeeded,
    };

    if (succeeded) {
      json['data'] = data;
      json['benchmarkScoreKeys'] = benchmarkScoreKeys;
    } else {
      json['reason'] = message;
    }

    return json;
  }

  @override
  String toString() => message;
}
