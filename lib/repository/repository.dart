import 'dart:async';

abstract class Repository <T>{
  Future<List<T>> getAll();
  Future<Null> add(T t);
  Future<Null> update(T t);
  Future<Null> delete(T t);
}