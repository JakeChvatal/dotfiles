/* Copyright 2015-2017 Jack Humbert
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "muse.h"


enum planck_layers {
  _QWERTY,
  _COLEMAK,
  _LOWER,
  _RAISE,
  _MOUSE,
  _ADJUST,
_SYMBOL,
_EXTEND
};

enum planck_keycodes {
  QWERTY = SAFE_RANGE,
  COLEMAK,
  MOUSE,
 // EXT_PLV
};

// keycodes for layers
#define LOWER MO(_LOWER)
#define RAISE MO(_RAISE)
#define MOUSE TG(_MOUSE) 

// custom keycodes
#define GUI_ESC LGUI_T(KC_ESC)
#define LOW_SPC MT(LOWER, KC_SPC)
#define UP_BSPC MT(RAISE, KC_BSPC)

// esc/fn
// i/regex
// tab/num
// enter/edit
// spc/sym
// bksp/mouse

// whether the keyboard is currently using colemak
bool colemak = false;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case QWERTY:
      if (record->event.pressed) {
        set_single_persistent_default_layer(_QWERTY);
      }
      return false;
      break;
    case COLEMAK:
      if (record->event.pressed) {
          if(colemak) {
            set_single_persistent_default_layer(_QWERTY);
            colemak = false;
          } else {
            set_single_persistent_default_layer(_COLEMAK);
            colemak = true;
          }
      }
      return false;
      break;
  }
  return true;
}

void encoder_update(bool clockwise) {
    if (clockwise) {
      #ifdef MOUSEKEY_ENABLE
        tap_code(KC_MS_WH_DOWN);
      #else
        tap_code(KC_PGDN);
      #endif
    } else {
      #ifdef MOUSEKEY_ENABLE
        tap_code(KC_MS_WH_UP);
      #else
        tap_code(KC_PGUP);
      #endif
    }
}

void dip_switch_update_user(uint8_t index, bool active) {
    switch (index) {
        case 0: {
            if (active) {
                layer_on(_ADJUST);
            } else {
                layer_off(_ADJUST);
            }
            break;
        }
    }
}

void matrix_scan_user(void) {
}

/* other layouts
 *https://configure.ergodox-ez.com/ergodox-ez/layouts/BNpaO/latest/4 beakl 15
  https://ieants.cc/code/keyboard/beakl/
https://www.keyboard-design.com/layouts/ergo/60/seelpy-1-ergolinear.html seelpy ergolinear
https://keyboard-design.com/best-keyboard-layouts.html top layouts
*/
