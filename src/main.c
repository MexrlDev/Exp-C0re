// Yes. this one is the one that shows the text + black bg + the buttons pressed text
#include "core.h"
#include "hijack.h"
#include "ui.h"
#include "tables.h"

// pad button masks (got it from the NES emu lol)
#define PAD_A     0x01
#define PAD_B     0x02
#define PAD_SEL   0x04
#define PAD_START 0x08
#define PAD_UP    0x10
#define PAD_DOWN  0x20
#define PAD_LEFT  0x40
#define PAD_RIGHT 0x80
#define PAD_MENU  0xFE   // L1
#define PAD_EXIT  0xFF   // R1

static u8 ds_to_nes(u32 ds4_buttons) {
    u8 r = 0;
    if (ds4_buttons & 0x00004000) r |= PAD_A;      // CROSS
    if (ds4_buttons & 0x00008000) r |= PAD_B;      // SQUARE
    if (ds4_buttons & 0x00001000) r |= PAD_SEL;    // TRIANGLE
    if (ds4_buttons & 0x00002000) r |= PAD_START;  // CIRCLE
    if (ds4_buttons & 0x00000008) r |= PAD_START;  // OPTIONS (also start)
    if (ds4_buttons & 0x00000010) r |= PAD_UP;
    if (ds4_buttons & 0x00000040) r |= PAD_DOWN;
    if (ds4_buttons & 0x00000080) r |= PAD_LEFT;
    if (ds4_buttons & 0x00000020) r |= PAD_RIGHT;
    if (ds4_buttons & 0x00000400) r = PAD_MENU;    // L1
    if (ds4_buttons & 0x00000800) r = PAD_EXIT;    // R1
    return r;
}

__attribute__((section(".text._start")))
void _start(u64 eboot_base, u64 dlsym_addr, struct ext_args *ext) {
    void *G = (void *)(eboot_base + GADGET_OFFSET);
    void *D = (void *)dlsym_addr;

    // Initialize video context and hijack display
    struct video_ctx v;
    if (video_hijack(&v, G, D, eboot_base, ext) != 0) {
        ext->status = -1;
        ext->step = 1;
        return;
    }

    // Clear both framebuffers immediately
    ui_clear_fb((u32*)v.fbs[0], 0xFF000000);
    ui_clear_fb((u32*)v.fbs[1], 0xFF000000);

    // Load pad library
    void *load_mod = SYM(G, D, LIBKERNEL_HANDLE, "sceKernelLoadStartModule");
    s32 pad_mod = (s32)NC(G, load_mod, (u64)"libScePad.sprx", 0,0,0,0,0);
    void *pad_init = SYM(G, D, pad_mod, "scePadInit");
    void *pad_geth = SYM(G, D, pad_mod, "scePadGetHandle");
    void *pad_read = SYM(G, D, pad_mod, "scePadRead");

    s32 pad_h = -1;
    if (pad_init) NC(G, pad_init, 0,0,0,0,0,0);
    if (pad_geth) pad_h = (s32)NC(G, pad_geth, (u64)ext->dbg[3], 0,0,0,0,0); // userId stored in ext->dbg[3]

    void *usleep = SYM(G, D, LIBKERNEL_HANDLE, "sceKernelUsleep");

    int active = 0;
    u32 frame = 0;

    while (1) {
        // Read pad
        u8 pad_state = 0;
        if (pad_h >= 0 && pad_read) {
            u8 pad_buf[128] = {0};
            s32 n = (s32)NC(G, pad_read, (u64)pad_h, (u64)pad_buf, 1, 0, 0, 0);
            if (n > 0 && (u32)n < 0x80000000) {
                u32 raw = *(u32*)pad_buf;
                if (!(raw & 0x80000000))
                    pad_state = ds_to_nes(raw & 0x001FFFFF);
            }
        }

        // Exit on R1
        if (pad_state == PAD_EXIT)
            break;

        // Get current framebuffer
        u32 *fb = (u32*)v.fbs[active];

        // Clear to black
        ui_clear_fb(fb, 0xFF000000);

        // Draw centered large text with scale factor 4
        ui_draw_text_scaled(fb, "Hello World From", 4, 0xFFFFFFFF, 400);
        ui_draw_text_scaled(fb, "Star Wars Racer Revenge!", 4, 0xFFFFAA00, 500);

        // Show pad state for debugging
        if (pad_state) {
            char buf[32];
            int p = 0;
            const char *hex = "0123456789ABCDEF";
            buf[p++] = 'P';
            buf[p++] = 'a';
            buf[p++] = 'd';
            buf[p++] = ':';
            buf[p++] = ' ';
            buf[p++] = hex[(pad_state >> 4) & 0xF];
            buf[p++] = hex[pad_state & 0xF];
            buf[p] = 0;
            ui_draw_str_1080p(fb, 50, 1000, buf, 0xFF00FF00);
        }

        // Flip
        video_flip(&v, active);
        active ^= 1;
        frame++;

        // Frame pacing
        if (usleep) NC(G, usleep, 16667, 0,0,0,0,0);
    }

    // Cleanup
    video_cleanup(&v);
    ext->status = 0;
    ext->step = 99;
    ext->frame_count = frame;
}
