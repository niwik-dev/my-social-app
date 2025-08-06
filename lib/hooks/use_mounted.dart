import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useMouted(VoidCallback callback){
  useEffect((){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  },[]);
}