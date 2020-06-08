
// const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

// ......................................................... Number Keypad Layer
#ifdef SHIFT_SYMBOLS
  // .-----------------------------------------------------------------------------------.
  // |      |   F  |   E  |   D  |      |      |      |   /  |   7  |   8  |   9  |   *  |
  // |-----------------------------------------------------------------------------------|
  // | Ctrl |   C  |   B  |   A  |      |      |      |   .  |   4  |   5  |   6  |   -  |
  // |-----------------------------------------------------------------------------------|
  // |      |   #  |   G  |   \  |      |      |      |   ,  |   1  |   2  |   3  |   +  |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |  f() |      |      |      |   0  |   =  |      |      |      |
  // |      |      |      |  f() |      |      |      |   =  |   0  |      |      |      |
  // '-----------------------------------------------------------------------------------'

// ___x___, ___x___, 
// ___x___, ___x___, 
// ___x___, ___x___, 

  [_NUMBER] = LAYOUT_planck_grid(
    ___x___, _______, KC_F,    MT_E,    KC_D,    _______, KC_SLSH, KC_7,    KC_8,    KC_9,    KC_ASTR, ___x___, 
    ___x___, OS_CTL,  GT_C,    AT_B,    ST_A,    _______, TD_DOT,  KC_4,    KC_5,    KC_6,    KC_MINS, ___x___, 
    ___x___, _______, KC_HASH, SM_G,    KC_BSLS, _______, TD_COMM, KC_1,    KC_2,    KC_3,    KC_PLUS, ___x___, 
#ifdef THUMB_0
    ___x___, ___x___, ___x___, ___fn__, ___x___, ___x___, ___x___, KC_0,    LT_EQL,  ___x___, ___x___, ___x___
#else
    ___x___, ___x___, ___x___, ___fn__, ___x___, ___x___, ___x___, KC_EQL,  LT_0,    ___x___, ___x___, ___x___
#endif
  ),
#else
  // .-----------------------------------------------------------------------------------.
  // |      |   F  |   E  |   D  |      |      |      |   /  |   7  |   8  |   9  |   *  |
  // |-----------------------------------------------------------------------------------|
  // | Ctrl |   C  |   B  |   A  |      |      |      |   .  |   4  |   5  |   6  |   -  |
  // |-----------------------------------------------------------------------------------|
  // |      |   #  |   X  |   G  |      |      |      |   ,  |   1  |   2  |   3  |   +  |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |  f() |      |      |      |   0  |   =  |      |      |      |
  // |      |      |      |  f() |      |      |      |   =  |   0  |      |      |      |
  // '-----------------------------------------------------------------------------------'

  [_NUMBER] = LAYOUT_planck_grid(
    _______, _______, KC_F,    MT_E,    KC_D,    _______,  KC_SLSH, KC_7,    KC_8,    KC_9,    KC_ASTR, _______,
    _______, OS_CTL,  GT_C,    AT_B,    LT_A,    _______,  KC_DOT,  KC_4,    KC_5,    KC_6,    KC_MINS, _______,
    _______, _______, KC_HASH, MT_X,    S(KC_G), _______,  TD_COMM, KC_1,    KC_2,    KC_3,    KC_PLUS, _______,
#ifdef THUMB_0                                                                                         
    ___x___, ___x___, ___x___, ___x___, ___fn__, ___x___,  KC_0,    LT_EQL,  ___x___, ___x___, ___x___  ___x___,
#else                                                                                                  
    ___x___, ___x___, ___x___, ___x___, ___fn__, ___x___,  KC_EQL,  LT_0,    ___x___, ___x___, ___x___  ___x___,
#endif
  ),

  // .-----------------------------------------------------------------------------------.
  // |      |      |      |      |      |      |      |   {  |   &  |   ?  |   :  |   }  |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |  f() |      |      |      |   (  |   $  |   %  |   ^  |   )  |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |      |      |      |      |   [  |   <  |   ~  |   >  |   ]  |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |  f() |      |      |      |   \  |   |  |      |      |      |
  // '-----------------------------------------------------------------------------------'

  [_NUMSYM] = LAYOUT_planck_grid(
    _______, _______, _______, _______, ___x___, _______, TD_LCBR, KC_AMPR, KC_QUES, KC_COLN, KC_RCBR, _______,
    _______, ___x___, ___x___, ___x___, ___fn__, _______, TD_LPRN, KC_DLR,  KC_PERC, KC_CIRC, KC_RPRN, _______,
    _______, _______, _______, _______, ___x___, _______, TD_LBRC, KC_LT,   KC_TILD, KC_GT,   KC_RBRC, _______,
    ___x___, ___x___, ___x___, ___fn__, ___x___, ___x___, ___x___, KC_BSLS, KC_PIPE, ___x___, ___x___, ___x___
  ),
#endif

// ............ .................................................. Function Keys

  // .-----------------------------------------------------------------------------------.
  // |      |      |      |      |      |      |      |      |  F7  |  F8  |  F9  |  F12 |
  // |-----------------------------------------------------------------------------------|
  // | Ctrl |  GUI |  Alt | Shift|      |      |      |      |  F4  |  F5  |  F6  |  F11 |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |      |      |      |      |      |  F1  |  F2  |  F3  |  F10 |
  // |-----------------------------------------------------------------------------------|
  // |      |      |      |      |      |  f() |      |   +  |      |      |      |      |
  // |      |      |      |      |  f() |      |      |   +  |      |      |      |      | see _PLOVER
  // '-----------------------------------------------------------------------------------'

  [_FNCKEY] = LAYOUT_planck_grid(
    ___x___, _______, _______, _______, _______, _______, _______, KC_F7,   KC_F8,   KC_F9,   KC_F12 , ___x___, 
    ___x___, OS_CTL,  OS_GUI,  OS_ALT,  OS_SFT,  _______, _______, KC_F4,   KC_F5,   KC_F6,   KC_F11 , ___x___, 
    _______, _______, _______, _______, _______, KC_F1,   KC_F2,   KC_F3,   KC_F10 , _______, _______, ___x___, 
    _______, _______, _______, _______, ___fn__, ___fn__, _______, KC_PLUS, _______, _______, _______, _______
  ),

