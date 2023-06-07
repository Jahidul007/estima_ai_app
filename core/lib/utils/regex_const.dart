var emailRegex = RegExp(
    r"^[A-Za-z0-9]+(([\.\_\-]{0,1}[A-Za-z0-9])*)@[A-Za-z0-9]+[\.\-]{0,1}[A-Za-z0-9]+\.[A-Za-z]{2,10}$");
var passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
