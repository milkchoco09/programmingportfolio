//Max Oyewole | Started 9/15/2026 | Calculator Project
Button[] numButtons = new Button[10]; //numbers
Button[] opButtons = new Button[12]; //operators
float l, r, result;
boolean left, newEntry;
String op, displayVal;
void setup() {
  size(520, 640);
  background(180);
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = " ";
  left = true;
  newEntry = true;
  displayVal = "0.0";
  numButtons[0] = new Button(200, 520, "0", color(150), color(120));
  numButtons[1] = new Button(200, 440, "1", color(150), color(120));
  numButtons[2] = new Button(320, 440, "2", color(150), color(120));
  numButtons[3] = new Button(440, 440, "3", color(150), color(120));
  numButtons[4] = new Button(200, 360, "4", color(150), color(120));
  numButtons[5] = new Button(320, 360, "5", color(150), color(120));
  numButtons[6] = new Button(440, 360, "6", color(150), color(120));
  numButtons[7] = new Button(200, 280, "7", color(150), color(120));
  numButtons[8] = new Button(320, 280, "8", color(150), color(120));
  numButtons[9] = new Button(440, 280, "9", color(150), color(120));
  opButtons[0] = new Button(320, 520, ".", color(150), color(120));
  opButtons[1] = new Button(80, 520, "+", color(150), color(120));
  opButtons[2] = new Button(80, 440, "-", color(150), color(120));
  opButtons[3] = new Button(80, 360, "x", color(150), color(120));
  opButtons[4] = new Button(80, 280, "÷", color(150), color(120));
  opButtons[5] = new Button(440, 520, "±", color(150), color(120));
  opButtons[6] = new Button(80, 600, "Clear", color(150, 50, 0), color(120, 40, 0));
  opButtons[7] = new Button(440, 600, "Enter", color(50, 150, 0), color(40, 120, 0));
  opButtons[8] = new Button(80, 200, "^", color(150), color(120));
  opButtons[9] = new Button(200, 200, "ln", color(150), color(120));
  opButtons[10] = new Button(320, 200, "sin", color(150), color(120));
  opButtons[11] = new Button(440, 200, "cos", color(150), color(120));
}

void draw() {
  background(180);
  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].display();
  }
  for (int i = 0; i < opButtons.length; i++) {
    opButtons[i].display();
  }
  calcDisplay();
}

void calcDisplay() {
  fill(255);
  rectMode(CORNER);
  textAlign(RIGHT, CENTER);
  textSize(40);
  rect(40, 40, 440, 80);
  fill(0);
  text(displayVal, 480, 75);
}

void mouseReleased() {

  //Update display with button clicked by user
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover()) {
      handleEvent(numButtons[i].label.charAt(0), true);
    }
  }
  // Loop through opButtons
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover()) {
      handleEvent(opButtons[i].label.charAt(0), false);
    }
  }
  //variable values
  println("L:" + l);
  println("R:" + r);
  println("Result:" + result);
  println("Left:" + left);
  println("Operator:" + op);
  println("DisplayVal:" + displayVal);
  println("NewEntry:" + newEntry);
}

void performCalc() {
  //defining operator function
  if (op == "+") {
    result = l + r;
    displayVal = str(result);
  } else if (op == "-") {
    result = l - r;
    displayVal = str(result);
  } else if (op == "x") {
    result = l * r;
    displayVal = str(result);
  } else if (op == "÷") {
    if (r == 0) {
      displayVal = "ERROR: DIVISION BY ZERO";
      newEntry = true;
    } else {
      result = l / r;
      displayVal = str(result);
    }
  } else if (op == "^") {
    if (l == 0 && r < 0) {
      displayVal = "ERROR: DIVISION BY ZERO";
      newEntry = true;
    } else if (l < 0 && r*pow(10, 30)/pow(2, 30) % 2 == 0) {
      displayVal = "ERROR: NONREAL ROOT";
      newEntry = true;
    } else {
      result = pow(l, r);
      displayVal = str(result);
    }
  }
  if (result == 0.0) {
    newEntry = true;
  }
  left = true;
  l = result;
}

void keyPressed() {
  println("keyCode:" + keyCode);
  if (keyCode == 48 || keyCode == 96) {
    handleEvent('0', true);
  } else if (keyCode == 49 || keyCode == 97) {
    handleEvent('1', true);
  } else if (keyCode == 50 || keyCode == 98) {
    handleEvent('2', true);
  } else if (keyCode == 51 || keyCode == 99) {
    handleEvent('3', true);
  } else if (keyCode == 52 || keyCode == 100) {
    handleEvent('4', true);
  } else if (keyCode == 53 || keyCode == 101) {
    handleEvent('5', true);
  } else if (keyCode == 54 || keyCode == 102) {
    handleEvent('6', true);
  } else if (keyCode == 55 || keyCode == 103) {
    handleEvent('7', true);
  } else if (keyCode == 56 || keyCode == 104) {
    handleEvent('8', true);
  } else if (keyCode == 57 || keyCode == 105) {
    handleEvent('9', true);
  } else if (keyCode == 46 || keyCode == 110) {
    handleEvent('.', false);
  }
}

void handleEvent(char label, boolean isNum) {
  if (isNum) {
    // Number stuff
    String digit = str(label);

    if (newEntry) {
      displayVal = digit;
      newEntry = false;
    } else {
      displayVal += digit;
    }
    if (left) {
      l = float(displayVal);
    } else {
      r = float(displayVal);
    }
  } else {
    //Operator stuff
    String clicked = str(label);

    if (clicked.equals("Enter")) {
      //Perform calculation
      performCalc();
    } else if (clicked.equals("+") || clicked.equals("-") ||
      clicked.equals("x") || clicked.equals("÷") || clicked.equals("^")) {
      op = clicked;
      left = false;
      newEntry = true;
      displayVal = op;
    } else if (clicked.equals("±")) {
      if (left) {
        l *= -1;
        displayVal = str(l);
      } else {
        r *= -1;
        displayVal = str(r);
      }
    } else if (clicked.equals("Clear")) {
      l = 0.0;
      r = 0.0;
      result = 0.0;
      op = " ";
      left = true;
      newEntry = true;
      displayVal = "0.0";
    } else if (clicked.equals(".")) {
      if (!displayVal.contains(".")) {
        if (left) {
          displayVal += ".";
          l = float(displayVal);
        } else {
          displayVal += ".";
          r = float(displayVal);
        }
      }
    } else if (clicked.equals("cos")) {
      if (left) {
        result = cos(l);
        l = cos(l);
        displayVal = str(result);
      } else {
        result = cos(r);
        r = cos(r);
        displayVal = str(result);
      }
    } else if (clicked.equals("sin")) {
      if (left) {
        result = sin(l);
        l = sin(l);
        displayVal = str(result);
      } else {
        result = sin(r);
        r = sin(r);
        displayVal = str(result);
      }
    } else if (clicked.equals("ln")) {
      if (left) {
        if (l <= 0) {
          displayVal = "ERROR: UNDEFINED";
          newEntry = true;
        } else {
          result = log(l);
          l = log(l);
          displayVal = str(result);
        }
      } else {
        if (r <= 0) {
          displayVal = "ERROR: UNDEFINED";
          newEntry = true;
        } else {
          result = log(r);
          r = log(r);
          displayVal = str(result);
        }
      }
    }
  }
}
