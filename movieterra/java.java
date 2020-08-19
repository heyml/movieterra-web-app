class NewClass {
  public static void main (String args[])

  throws java.io.IOException {
    char ch; 
    int x;
    System.out.println("Отгадайте символ с клавиатуры. Введите и нажмите ENTER");

    for (x = 0;; x++) {
      ch = (char) System.in.read();

      if (ch == '.') {
        System.out.println("Вы угадали! Но с " + x + " попытки");
        break;
      } else {
        System.out.println("Вы сделали " + x + " попытки. Попробуйте еще раз");
      }
    }
  }
}
