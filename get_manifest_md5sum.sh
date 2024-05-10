#!/bin/bash
srcfile=$1
UPDATE_DIR=.
headlen=$(printf "%u" 0x$(hexdump -v  -n 4 $srcfile -e '4/1 "%02x"'))
# echo $headlen
printf "\x1f\x8b\x08\x00\x6f\x9b\x4b\x59\x02\x03" > $UPDATE_DIR/header.bin
dd if=$srcfile bs=1 skip=4 count=$headlen >> $UPDATE_DIR/header.bin 2>/dev/null
gunzip < $UPDATE_DIR/header.bin > $UPDATE_DIR/header_info.json
dd if=$srcfile bs=$((headlen+4)) skip=1 >> $UPDATE_DIR/firmware.bin 2>/dev/null
gzip -d < firmware.bin > firmware.bin.decompressed
mkdir mount
sudo mount firmware.bin.decompressed mount
cp mount/boot/rootfs ./
cp mount/boot/vmlinuz ./
echo '#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

uint8_t ext_key[1024];
uint8_t key[17] = { 0x77, 0xb1, 0xfa, 0x93, 0x74, 0x2c, 0xb3, 0x9d,
	0x33, 0x83, 0x55, 0x3e, 0x84, 0x8a, 0x52, 0x91, 0x00 };
uint8_t hash_table[] = {
	0x00, 0x00, 0x00, 0x00, 0x64, 0x10, 0xB7, 0x1D, 0xC8, 0x20,
	0x6E, 0x3B, 0xAC, 0x30, 0xD9, 0x26, 0x90, 0x41, 0xDC, 0x76,
	0xF4, 0x51, 0x6B, 0x6B, 0x58, 0x61, 0xB2, 0x4D, 0x3C, 0x71,
	0x05, 0x50, 0x20, 0x83, 0xB8, 0xED, 0x44, 0x93, 0x0F, 0xF0,
	0xE8, 0xA3, 0xD6, 0xD6, 0x8C, 0xB3, 0x61, 0xCB, 0xB0, 0xC2,
	0x64, 0x9B, 0xD4, 0xD2, 0xD3, 0x86, 0x78, 0xE2, 0x0A, 0xA0,
	0x1C, 0xF2, 0xBD, 0xBD
};

int32_t hash(uint8_t* a1, uint32_t a2)
{
	uint64_t v2 = 0;
	uint32_t result = 0xffffffff;
	uint8_t v4;
	uint32_t v5;
	while (a2 != (uint32_t)v2) {
		v4 = a1[v2++];
		v5 = hash_table[(v4 ^ (uint8_t)result) & 0xf] ^ ((uint32_t)result >> 4);
		result = hash_table[((uint8_t)v5 ^ (v4 >> 4)) & 0xf] ^ (v5 >> 4);
	}
	return result;
}

int main()
{

	int64_t key_index = 0;
	uint32_t initrd_real_size, tmp_var, hash_var;
	int8_t initrd_size_low_byte;
	int32_t var_0 = 0, var_1 = 1;
	uint8_t* initrd_start;
	int64_t initrd_size;
	struct stat* initrd_stat;
	FILE* f;
	uint8_t* p_hash;
	int64_t iter = 0;

	f = fopen("./rootfs.raw", "rb");
	initrd_stat = (struct stat*)malloc(sizeof(struct stat));
	fstat(fileno(f), initrd_stat);
	initrd_size = initrd_stat->st_size;
	initrd_start = (uint8_t*)malloc(initrd_size);
	fread(initrd_start, sizeof(uint8_t), initrd_size, f);
	fclose(f);
	// initrd_real_size = initrd_size - 4;
	initrd_real_size = initrd_size - 4;
	initrd_size_low_byte = (int8_t)(initrd_size - 4);

	do {
		ext_key[key_index] = key[key_index & 0xf] + 19916032 * ((int32_t)key_index + 1) / 131u;
		++key_index;
	} while (key_index != 1024);

	for (iter = 0;
	     initrd_real_size > (uint32_t)iter;
	     initrd_start[iter - 1] = ((initrd_start[iter - 1] - (uint8_t)tmp_var) << ((uint8_t)tmp_var % 7u + 1)) | ((int32_t)(uint8_t)(initrd_start[iter - 1] - tmp_var) >> (8 - ((uint8_t)tmp_var % 7u + 1)))) {
		tmp_var = var_0 + iter++;
		*(uint8_t*)&tmp_var = (uint8_t)(initrd_size_low_byte + ext_key[tmp_var % 1024u] * var_1);
	}
	/*
	printf("initrd_size:%ld\n"
	       "initrd_real_size:%d\n"
	       "iter:%ld\n",
	    initrd_size, initrd_real_size, iter);
	*/
	hash_var = __builtin_bswap32(~hash(initrd_start, initrd_size - 4));
	hash_var = __builtin_bswap32(~hash((uint8_t*)&hash_var, 4));
	p_hash = (uint8_t*)(initrd_start + initrd_size - 4);
	if (*(uint32_t*)p_hash == hash_var) {
		printf("success\n");
	}
	f = fopen("./rootfs.decode", "wb");
	fwrite(initrd_start, sizeof(uint8_t), initrd_size-4, f);
	fclose(f);
	free(initrd_start);
	free(initrd_stat);
	return 0;
}' >dec.c
gcc -o dec dec.c
cp rootfs rootfs.raw
./dec
mv rootfs.decode rootfs.xz
umount mount
rm -rf mount firmware.bin firmware.bin.decompressed header.bin header_info.json rootfs.raw rootfs vmlinuz dec.c dec
xz -dk rootfs.xz
./ext2rd ./rootfs ./:root
cp root/usr/ikuai/www/static/js/manifest* ./
gzip -d manifest*
rm -rf root rootfs rootfs.xz

manifest=$(ls manifest*)
md5=$(md5sum manifest* | awk '{print $1}')
arch=$(echo $srcfile | awk -F'_' '{print $2}')
version=$(echo $srcfile | awk -F'_' '{print $3}')
echo "$version,$arch,$manifest,$md5"

rm manifest*