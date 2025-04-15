library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/conf/routing/app_router.dart';
import 'package:sarf/feature/auth/bloc/bloc.dart';
import 'package:sarf/feature/auth/login/login_lib.dart';
import 'package:sarf/utility/extensions/extensions_lib.dart';
import 'package:sarf/utility/helpers/helpers_lib.dart';
import 'package:sarf/utility/widgets/shared_widgets.dart';

part 'ui/view.dart';
part 'ui/widgets/_register_form_container.dart';
part 'ui/widgets/_register_submit_button.dart';