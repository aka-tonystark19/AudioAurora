#include <stdio.h>
#include <stdint.h>
#include <math.h>

#define PI 3.14159265358979323846

typedef struct {
    char chunkID[4];
    uint32_t chunkSize;
    char format[4];
    char subchunk1ID[4];
    uint32_t subchunk1Size;
    uint16_t audioFormat;
    uint16_t numChannels;
    uint32_t sampleRate;
    uint32_t byteRate;
    uint16_t blockAlign;
    uint16_t bitsPerSample;
    char subchunk2ID[4];
    uint32_t subchunk2Size;
} WAV_HEADER;

int main()
{
    // Define WAV file parameters
    uint16_t numChannels = 1;  // mono
    uint32_t sampleRate = 2000;
    uint16_t bitsPerSample = 16;
    uint32_t duration = 1;  // seconds
    uint32_t numSamples = sampleRate * duration;
    uint32_t byteRate = sampleRate * numChannels * bitsPerSample / 8;
    uint32_t chunkSize = 36 + numSamples * numChannels * bitsPerSample / 8;
    uint32_t subchunk2Size = numSamples * numChannels * bitsPerSample / 8;

    // Create a WAV header
    WAV_HEADER header = {
        .chunkID = {'R', 'I', 'F', 'F'},
        .chunkSize = chunkSize,
        .format = {'W', 'A', 'V', 'E'},
        .subchunk1ID = {'f', 'm', 't', ' '},
        .subchunk1Size = 16,
        .audioFormat = 1,  // PCM
        .numChannels = numChannels,
        .sampleRate = sampleRate,
        .byteRate = byteRate,
        .blockAlign = numChannels * bitsPerSample / 8,
        .bitsPerSample = bitsPerSample,
        .subchunk2ID = {'d', 'a', 't', 'a'},
        .subchunk2Size = subchunk2Size
    };

    // Open a file for writing
    FILE *fp = fopen("audio.wav", "wb");
    if (!fp) {
        printf("Error: cannot open file for writing.\n");
        return 1;
    }

    // Write the header to the file
    fwrite(&header, sizeof(header), 1, fp);

    // Generate a sine wave and write it to the file
    double amplitude = (double)(1 << (bitsPerSample - 1)) - 1;  // maximum amplitude for the given bits per sample
    double frequency = 450;  // A4 note frequency
    double timeStep = 1.0 / sampleRate;
    double phase = 0;
    int count = 0;
    for (uint32_t i = 0; i < numSamples; i++) {
        int16_t sample = (int16_t)(amplitude * sin(2 * PI * frequency * phase));
        fwrite(&sample, sizeof(sample), 1, fp);
        printf("%d, ", sample);
        count++;
        phase += timeStep;
    }

    printf("/n count = %d", count);
    // Close the file
    fclose(fp);

    printf("Audio file generated.\n");

    return 0;
}