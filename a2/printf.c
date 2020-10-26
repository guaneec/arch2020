#include <stdarg.h>
#include "printf.h"

/* Adapted from https://github.com/ParkerMactavish/NCKU_CA_109/blob/master/HW1/formatPrinter_test.c */

int _start()
{
    char *pChr = "StringInArg";
    char chr = 'c';
    unsigned int testHex0 = 0x102345,
                 testHex1 = 0x6789AB,
                 testHex2 = 0xCDEF,
                 testOct = 012345670,
                 testBin = 0b00111011000101001111010100001111;
    self_printf("%s\nnormalString\nCharInArg: %c\nPercentSign: %%\nNot supporting: %e%e%r%d\nHex0: %x    %X\nHex1: %x    %X\nHex2: %x    %X\nOct: %o\nBin: %b", pChr, chr, testHex0, testHex0, testHex1, testHex1, testHex2, testHex2, testOct, testBin);
    return 0;
}
