
// const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

// ...................................................................... Qwerty
#ifdef QWERTY
  // ,-----------------------------------------------------------------------------------.
  // |   Q  |   W  |   E  |   R  |   T  | ^Alt | ^GUI |   Y  |   U  |   I  |   O  |   P  |
  // |------+------+------+------+------+-------------+------+------+------+------+------|
  // |   A  |   S  |   D  |   F  |   G  | ↑Alt | ↑GUI |   H  |   J  |   K  |   L  |   ;  |
  // |------+------+------+------+------+------|------+------+------+------+------+------|
  // |   Z  |   X  |   C  |   V  |   B  | Caps |^Shift|   N  |   M  |   ,  |   .  |   "  |
  // |------+------+------+------+------+------+------+------+------+------+------+------|
  // | Ctrl |  GUI |  Alt |  Esc | Space|  Tab | Bksp |  Ent | Left | Down |  Up  | Right|
  // `-----------------------------------------------------------------------------------'

  [_BASE] = LAYOUT_planck_grid(
    KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P   , KC_BSPC,
    GUI_ESC, KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT, 
    KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  TD_QUOT, KC_ENT,
    OS_CTL,  OS_GUI,  OS_ALT,  LT_ESC,  LT_TAB,  TD_SPC,  LT_BSPC, TD_ENT,  LT_LEFT, AT_DOWN, GT_UP,   CT_RGHT
  ),

  [_SHIFT] = LAYOUT_planck_grid(
    KC_TAB,  S(KC_Q), S(KC_W), S(KC_E), S(KC_R), S(KC_T),  S(KC_Y), S(KC_U), S(KC_I), S(KC_O), S(KC_P), KC_BSPC,
    GUI_ESC, S(KC_A), S(KC_S), S(KC_D), S(KC_F), S(KC_G),  S(KC_H), S(KC_J), S(KC_K), S(KC_L), KC_SCLN, KC_QUOT,
    KC_LSFT, S(KC_Z), S(KC_X), S(KC_C), S(KC_V), S(KC_B),  S(KC_N), S(KC_M), KC_COMM, KC_DOT,  TD_QUOT, KC_ENT,
    OS_CTL,  OS_GUI,  OS_ALT,  LT_ESC,  LT_TAB,  TD_SPC,   LT_BSPC, TD_ENT,  LT_LEFT, AT_DOWN, GT_UP,   CT_RGHT
  ),

  // ,-----------------------------------------------------------------------------------.
  // |   Q  |   W  |   E  |   R  |   T  | ^Alt | ^GUI |   Y  |   U  |   I  |   O  |   P  |
  // |------+------+------+------+------+-------------+------+------+------+------+------|
  // |   A  |   S  |   D  |   F  |   G  | ↑Alt | ↑GUI |   H  |   J  |   K  |   L  |   :  |
  // |------+------+------+------+------+------|------+------+------+------+------+------|
  // |   Z  |   X  |   C  |   V  |   B  | Caps |^Shift|   N  |   M  |   /  |   ?  |   "  |
  // |------+------+------+------+------+------+------+------+------+------+------+------|
  // | Ctrl |  GUI |  Alt |  Esc |  f() |  Tab |  Del |   -  | Left | Down |  Up  | Right|
  // `-----------------------------------------------------------------------------------'
  
  [_LSHIFT] = LAYOUT_planck_grid(
    KC_TAB,  S(KC_Q), S(KC_W), S(KC_E), S(KC_R), S(KC_T), S(KC_Y), S(KC_U), S(KC_I), S(KC_O), S(KC_P), KC_BSPC,
    GUI_ESC, S(KC_A), S(KC_S), S(KC_D), S(KC_F), S(KC_G), S(KC_H), S(KC_J), S(KC_K), S(KC_L), TD_COLN, KC_QUOT,
    KC_LSFT, S(KC_Z), S(KC_X), S(KC_C), S(KC_V), S(KC_B), S(KC_N), S(KC_M), KC_SLSH, KC_QUES, TD_DQOT, KC_ENT,
    OS_CTL,  OS_GUI,  OS_ALT,  LT_ESC,  LT_TAB,  ___fn__, KC_DEL,  KC_MINS, SL_LEFT, S_DOWN,  S_UP,    S_RGHT
  ),

  // ,-----------------------------------------------------------------------------------.
  // |   Q  |   W  |   E  |   R  |   T  | ^Alt | ^GUI |   Y  |   U  |   I  |   O  |   P  |
  // |------+------+------+------+------+-------------+------+------+------+------+------|
  // |   A  |   S  |   D  |   F  |   G  | ↑Alt | ↑GUI |   H  |   J  |   K  |   L  |   :  |
  // |------+------+------+------+------+------|------+------+------+------+------+------|
  // |   Z  |   X  |   C  |   V  |   B  | Caps |^Shift|   N  |   M  |   ~  |   `  |   "  |
  // |------+------+------+------+------+------+------+------+------+------+------+------|
  // | Ctrl |  GUI |  Alt | Caps |   _  | ↑Tab | Bksp |  f() | Left | Down |  Up  | Right|
  // `-----------------------------------------------------------------------------------'

  [_RSHIFT] = LAYOUT_planck_grid(
    KC_TAB,  S(KC_Q), S(KC_W), S(KC_E), S(KC_R), S(KC_T), S(KC_Y), S(KC_U), S(KC_I), S(KC_O), S(KC_P), KC_BSPC,
    GUI_ESC, S(KC_A), S(KC_S), S(KC_D), S(KC_F), S(KC_G), S(KC_H), S(KC_J), S(KC_K), S(KC_L), TD_COLN, KC_QUOT,
    KC_LSFT, S(KC_Z), S(KC_X), S(KC_C), S(KC_V), S(KC_B), S(KC_N), S(KC_M), TD_TILD, TD_GRV,  TD_DQOT, KC_ENT,
    OS_CTL,  OS_GUI,  OS_ALT,  KC_CAPS, SL_TAB,  KC_UNDS, LT_BSPC, ___fn__, SL_LEFT, S_DOWN,  S_UP,    S_RGHT
  ),
#endif

