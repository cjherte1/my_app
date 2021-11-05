import 'package:my_app/pages/login_screen.dart';
import 'package:test/test.dart';

void main(){

  test('empty username returns error string', () {
    var result = UsernameValidator.validate('');
    expect(result, 'Please enter a username');
  });

  test('non-empty username returns null', () {
    var result = UsernameValidator.validate('test');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = PasswordValidator.validate('');
    expect(result, 'Please enter a password');
  });

  test('non-empty password returns null', () {
    var result = PasswordValidator.validate('test');
    expect(result, null);
  });



}