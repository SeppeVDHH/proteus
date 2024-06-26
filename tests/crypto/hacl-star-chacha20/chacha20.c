#include "Hacl_Chacha20.h"

#include <stdio.h>
#include <stdint.h>

#define MESSAGE_LEN 72
#define MACBYTES   16
#define NONCEBYTES 12
#define KEYBYTES   32
#define CIPHERTEXT_LEN (MESSAGE_LEN)

__attribute__((section(".secret"))) static uint8_t message[MESSAGE_LEN] = {
  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
  0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
  0x16, 0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23,
  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
  0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
  0x16, 0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23,
  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
  0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
  0x16, 0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23
};

__attribute__((section(".public"))) static uint8_t nonce[NONCEBYTES] = {
      0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
      0x06, 0x07, 0x08, 0x09, 0x10, 0x11
};

__attribute__((section(".secret"))) static uint8_t key[KEYBYTES] = {
      0x85, 0xd6, 0xbe, 0x78, 0x57, 0x55, 0x6d, 0x33,
      0x7f, 0x44, 0x52, 0xfe, 0x42, 0xd5, 0x06, 0xa8,
      0x01, 0x03, 0x80, 0x8a, 0xfb, 0x0d, 0xb2, 0xfd,
      0x4a, 0xbf, 0xf6, 0xaf, 0x41, 0x49, 0xf5, 0x1b
};

__attribute__((section(".secret"))) static uint8_t ciphertext[CIPHERTEXT_LEN];
__attribute__((section(".declassify"))) static volatile uint8_t declassified[CIPHERTEXT_LEN];

int main() {
  Hacl_Chacha20_chacha20_encrypt((uint32_t)MESSAGE_LEN, ciphertext, message,
                                 key, nonce, (uint32_t)0U);

  for (size_t i = 0; i < CIPHERTEXT_LEN; ++i) {
    declassified[i] = ciphertext[i];
  }

  for (size_t i = 0; i < CIPHERTEXT_LEN; ++i) {
    printf("%02x", declassified[i]);
  }
  printf("\n");
  // e5ec977d11d43aebe63af666bb5f4c3d2ae84bc2170803de67f1e76fd9130c83e0d443ffab602770576a3fd61c2d7ff3cd2c9bee595c82f6426d3e05d0232d4eb5f275c2927f4097
}
