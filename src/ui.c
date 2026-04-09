#include "ui.h"
#include "tables.h"

void ui_clear_fb(u32 *fb, u32 color) {
    for (int i = 0; i < SCR_W * SCR_H; i++) fb[i] = color;
}

// Original 2x scale (16x16) character drawing
void ui_draw_char_1080p(u32 *fb, int x, int y, char ch, u32 color) {
    if (x < 0 || x + 15 >= SCR_W || y < 0 || y + 15 >= SCR_H) return;
    int idx = 0;
    if (ch >= 'a' && ch <= 'z') ch -= 32;
    if (ch >= 32 && ch <= 90) idx = ch - 32;
    else idx = 31; // '?' for others
    const u8 *glyph = font_data[idx];
    for (int r = 0; r < 8; r++) {
        u8 bits = glyph[r];
        for (int c = 0; c < 8; c++) {
            if (bits & (0x80 >> c)) {
                int base_x = x + c * 2;
                int base_y = y + r * 2;
                for (int dy = 0; dy < 2; dy++) {
                    u32 *row = &fb[(base_y + dy) * SCR_W + base_x];
                    row[0] = color;
                    row[1] = color;
                }
            }
        }
    }
}

void ui_draw_str_1080p(u32 *fb, int x, int y, const char *s, u32 color) {
    while (*s) {
        ui_draw_char_1080p(fb, x, y, *s, color);
        x += 16;
        s++;
    }
}

void ui_draw_text_1080p(u32 *fb, const char *s, u32 color) {
    int len = ui_str_len(s);
    int char_w = 16;
    int char_h = 16;
    int total_w = len * char_w;
    int total_h = char_h;
    int x = (SCR_W - total_w) / 2;
    int y = (SCR_H - total_h) / 2;
    ui_draw_str_1080p(fb, x, y, s, color);
}

// Draw a character with arbitrary scale factor
static void ui_draw_char_scaled(u32 *fb, int x, int y, char ch, int scale, u32 color) {
    int char_w = 8 * scale;
    int char_h = 8 * scale;
    if (x < 0 || x + char_w - 1 >= SCR_W || y < 0 || y + char_h - 1 >= SCR_H) return;

    int idx = 0;
    if (ch >= 'a' && ch <= 'z') ch -= 32;
    if (ch >= 32 && ch <= 90) idx = ch - 32;
    else idx = 31;
    const u8 *glyph = font_data[idx];

    for (int r = 0; r < 8; r++) {
        u8 bits = glyph[r];
        for (int c = 0; c < 8; c++) {
            if (bits & (0x80 >> c)) {
                int base_x = x + c * scale;
                int base_y = y + r * scale;
                for (int dy = 0; dy < scale; dy++) {
                    u32 *row = &fb[(base_y + dy) * SCR_W + base_x];
                    for (int dx = 0; dx < scale; dx++) {
                        row[dx] = color;
                    }
                }
            }
        }
    }
}

void ui_draw_text_scaled(u32 *fb, const char *s, int scale, u32 color, int y_pos) {
    int len = ui_str_len(s);
    int char_w = 8 * scale;
    int total_w = len * char_w;
    int x = (SCR_W - total_w) / 2;
    int y = y_pos;

    while (*s) {
        ui_draw_char_scaled(fb, x, y, *s, scale, color);
        x += char_w;
        s++;
    }
}

int ui_str_len(const char *s) {
    int n = 0;
    while (*s++) n++;
    return n;
}
