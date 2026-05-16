class MouseCommand {
  static Map<String, dynamic> move(int dx, int dy) {
    return {
      "type": "move",
      "dx": dx,
      "dy": dy,
    };
  }

  static Map<String, dynamic> leftClick() {
    return {"type": "left_click"};
  }

  static Map<String, dynamic> rightClick() {
    return {"type": "right_click"};
  }

  static Map<String, dynamic> mouseDown() {
    return {"type": "mouse_down"};
  }

  static Map<String, dynamic> mouseUp() {
    return {"type": "mouse_up"};
  }

  static Map<String, dynamic> scroll(int amount) {
    return {
      "type": "scroll",
      "amount": amount,
    };
  }
}