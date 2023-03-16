#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

typedef struct {
    char chunk_id[4];
    uint32_t chunk_size;
    char format[4];
    char subchunk1_id[4];
    uint32_t subchunk1_size;
    uint16_t audio_format;
    uint16_t num_channels;
    uint32_t sample_rate;
    uint32_t byte_rate;
    uint16_t block_align;
    uint16_t bits_per_sample;
    char subchunk2_id[4];
    uint32_t subchunk2_size;
    uint8_t data;
} WAVFile;

int main() {
    // Open the WAV file
    FILE * wav_file = fopen("dont.wav", "rb");
    if (wav_file == NULL) {
        printf("Error: could not open WAV file\n");
        return 1;
    }

    // Read the WAV file header
    WAVFile header;
    fread(&header, sizeof(header), 1, wav_file);

    // Print the header information
    printf("Chunk ID: %.4s\n", header.chunk_id);
    printf("Chunk size: %d\n", header.chunk_size);
    printf("Format: %.4s\n", header.format);
    printf("Subchunk1 ID: %.4s\n", header.subchunk1_id);
    printf("Subchunk1 size: %d\n", header.subchunk1_size);
    printf("Audio format: %d\n", header.audio_format);
    printf("Number of channels: %d\n", header.num_channels);
    printf("Sample rate: %d\n", header.sample_rate);
    printf("Byte rate: %d\n", header.byte_rate);
    printf("Block align: %d\n", header.block_align);
    printf("Bits per sample: %d\n", header.bits_per_sample);
    printf("Subchunk2 ID: %.4s\n", header.subchunk2_id);
    printf("Subchunk2 size: %d\n", header.subchunk2_size);

    fclose(wav_file);

    return 0;
}