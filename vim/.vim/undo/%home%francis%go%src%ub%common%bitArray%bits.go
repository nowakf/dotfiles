Vim�UnDo� X�~;�3��C3����x�;���?Q3��B{                                      [P    _�                             ����                                                                                                                                                                                                                                                                                                                                                             [P    �                  ;//these functions are not particularly safe. Use carefully.   package bitArray       import "math/bits"       7func Get32(input uint32, index uint, length uint) int {   	input <<= index   	input >>= (32 - length)   	return int(input)   }       Lfunc Write32(input uint32, newValue uint8, index uint, length uint) uint32 {       	var mask uint32 = 0xFFFFFFFF       	mask <<= length       +	mask = bits.RotateLeft32(mask, int(index))       	input ^= mask       	n := uint32(newValue)   	n <<= index       	return input | n   }5��