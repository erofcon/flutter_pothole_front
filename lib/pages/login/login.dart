import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/login_request.dart';
import 'package:flutter_pothole_front/services/api_service.dart';
import 'package:flutter_pothole_front/utils/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String? username;
  String? password;
  bool isAuthError = false;
  bool isSendingRequest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
          height: 550.0,
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _loginField(),
                _passwordField(),
                _keepUser(),
                _submitButton(),
                isAuthError
                    ? const Padding(
                        padding: EdgeInsets.only(top: defaultPadding),
                        child: Text(
                          'error auth',
                          style: TextStyle(color: Colors.red),
                        ))
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: "Login"),
      onChanged: (value) {
        username = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please send login";
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: "Password"),
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please send password";
        }
        return null;
      },
    );
  }

  Widget _keepUser() {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (checked) => setState(() => isChecked = !isChecked),
            value: isChecked,
          ),
          const Text('keep me')
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isSendingRequest = true;
          });
          LoginRequest model =
              LoginRequest(username: username!, password: password!);

          APIService.login(model).then((value){
            if (value) {
              Modular.to.navigate('/info_page');
              // Modular.to.popAndPushNamed('/info_page');
            } else {
              setState(() {
                isSendingRequest = false;
                isAuthError = true;
              });
            }
          });
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.teal),
        elevation: MaterialStateProperty.all(10),
      ),
      child: isSendingRequest
          ? const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : const Icon(Icons.arrow_forward),
    );
  }
}

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   bool isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final FormBloc formBloc = FormProvider.of(context);
//
//     return Scaffold(
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
//           height: 550.0,
//           child: Form(
//             child: Column(
//               children: <Widget>[
//                 _loginField(formBloc),
//                 _passwordField(formBloc),
//                  const SizedBox(
//                   height: defaultPadding * 0.2,
//                 ),
//                 Container(
//                   width: 300,
//                   height: 35,
//                   child: Helper().errorMessage(formBloc),
//                 ),
//                 _keepUser(),
//                 _button(formBloc),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _loginField(FormBloc formBloc) {
//     return StreamBuilder<String>(
//         stream: formBloc.login,
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           return TextField(
//             keyboardType: TextInputType.name,
//             decoration: InputDecoration(
//                 labelText: 'Login',
//                 errorText:
//                     snapshot.hasError ? snapshot.error.toString() : null),
//             onChanged: formBloc.changeLogin,
//           );
//         });
//   }
//
//   Widget _passwordField(FormBloc formBloc) {
//     return StreamBuilder<String>(
//         stream: formBloc.password,
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           return TextField(
//             maxLength: 20,
//             keyboardType: TextInputType.name,
//             obscureText: true,
//             decoration: InputDecoration(
//                 labelText: 'Password',
//                 errorText:
//                     snapshot.hasError ? snapshot.error.toString() : null),
//             onChanged: formBloc.changePassword,
//           );
//         });
//   }
//
//
//   Widget _keepUser() {
//     return Row(
//       children: <Widget>[
//         Checkbox(
//           onChanged: (checked) => setState(() => isChecked = !isChecked),
//           value: isChecked,
//         ),
//         const Text('keep me')
//       ],
//     );
//   }
//
//   Widget _button(FormBloc formBloc) {
//     return StreamBuilder<bool>(
//         stream: formBloc.submitValidForm,
//         builder: (context, AsyncSnapshot<bool> snapshot) {
//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (snapshot.hasError) {
//                   setState((){});
//                   return;
//                 } else {
//                   return formBloc.singIn(context);
//                 }
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.teal),
//                 elevation: MaterialStateProperty.all(10),
//               ),
//               child: const Icon(Icons.arrow_forward),
//             ),
//           );
//         });
//   }
// }
