#pragma description QOA audio
#pragma pattern_limit 10000000000

#pragma MIME audio/qoa
#pragma endian big

import std.mem;

namespace qoa {

struct header_t {
    char magic[4];
    u32 samples;
};

struct frame_header_t {
    u8 num_channels;
    u24 sample_rate;
    u16 fsamples;
    u16 fsize;
};

struct lms_state_t {
    s16 history[4];
    s16 weights[4];
};

bitfield qoa_slice_t {
    sf_quant : 4;
    qr00 : 3;
    qr01 : 3;
    qr02 : 3;
    qr03 : 3;
    qr04 : 3;
    qr05 : 3;
    qr06 : 3;
    qr07 : 3;
    qr08 : 3;
    qr09 : 3;
    qr10 : 3;
    qr11 : 3;
    qr12 : 3;
    qr13 : 3;
    qr14 : 3;
    qr15 : 3;
    qr16 : 3;
    qr17 : 3;
    qr18 : 3;
    qr19 : 3;
};

struct frame_t {
    frame_header_t frame_header;
    lms_state_t lms_state[frame_header.num_channels];
    qoa_slice_t slices[(frame_header.fsamples * 3.2 * frame_header.num_channels) / 64];
};

struct file_t {
    header_t header;
    frame_t frames[while(!std::mem::eof())];
};

} // namespace qoa

qoa::file_t file @ 0x0;
