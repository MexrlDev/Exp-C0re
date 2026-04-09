#ifndef UI_H
#define UI_H

#include "core.h"

// Clear a 1920x1080 framebuffer (32-bit RGBA)
void ui_clear_fb(u32 *fb, u32 color);

// Draw a single character at (x,y) using a 16x16 scaled font (2x)
void ui_draw_char_1080p(u32 *fb, int x, int y, char ch, u32 color);

// Draw a null-terminated string at 1080p (2x scale)
void ui_draw_str_1080p(u32 *fb, int x, int y, const char *s, u32 color);

// Draw a string centered (2x scale)
void ui_draw_text_1080p(u32 *fb, const char *s, u32 color);

// Draw a string centered with arbitrary scale factor (scale 2,3,4...)
// y_pos specifies the vertical position (top of text)
void ui_draw_text_scaled(u32 *fb, const char *s, int scale, u32 color, int y_pos);

// String length
int ui_str_len(const char *s);

#endif
