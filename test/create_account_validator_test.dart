import 'package:my_app/pages/create_account.dart';
import 'package:test/test.dart';

void main(){

  test('empty first name returns error string', () {
    var result = FirstNameValidator.validate('');
    expect(result, 'Please enter your first name');
  });

  test('non-empty first name returns null', () {
    var result = FirstNameValidator.validate('test');
    expect(result, null);
  });

  test('empty last name returns error string', () {
    var result = LastNameValidator.validate('');
    expect(result, 'Please enter your last name');
  });

  test('non-empty last name returns null', () {
    var result = LastNameValidator.validate('test');
    expect(result, null);
  });

  test('empty username returns error string', () {
    var result = CreateUsernameValidator.validate('');
    expect(result, 'Username needs at least 3 characters');
  });

  test('one character username returns error string', () {
    var result = CreateUsernameValidator.validate('');
    expect(result, 'Username needs at least 3 characters');
  });

  test('two character username returns error string', () {
    var result = CreateUsernameValidator.validate('');
    expect(result, 'Username needs at least 3 characters');
  });

  test('three character username returns null', () {
    var result = CreateUsernameValidator.validate('tst');
    expect(result, null);
  });

  test('ten character username returns null', () {
    var result = CreateUsernameValidator.validate('testing123');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = CreatePasswordValidator.validate('');
    expect(result, 'Enter a password');
  });

  test('less than eight character password returns error string', () {
    var result = CreatePasswordValidator.validate('test123');
    expect(result, 'Minimum 8 characters, one letter and one number');
  });

  test('eight character password with only letters returns error string', () {
    var result = CreatePasswordValidator.validate('password');
    expect(result, 'Minimum 8 characters, one letter and one number');
  });

  test('greater than eight character password with only letters returns error string', () {
    var result = CreatePasswordValidator.validate('passwordpassword');
    expect(result, 'Minimum 8 characters, one letter and one number');
  });

  test('eight character password with only numbers returns error string', () {
    var result = CreatePasswordValidator.validate('12345678');
    expect(result, 'Minimum 8 characters, one letter and one number');
  });

  test('greater than eight character password with only numbers returns error string', () {
    var result = CreatePasswordValidator.validate('123456789101112');
    expect(result, 'Minimum 8 characters, one letter and one number');
  });

  test('eight character password with letters and numbers returns null', () {
    var result = CreatePasswordValidator.validate('passwrd1');
    expect(result, null);
  });

  test('greater eight character password with letters and numbers returns null', () {
    var result = CreatePasswordValidator.validate('password12345');
    expect(result, null);
  });



}