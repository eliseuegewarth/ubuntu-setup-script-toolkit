def ram_speed(freq_in_mhz, first_word, data_rate=2, system_arq=64, interfaces=1):
	M = 1000000
	byte = 8 # number of bits
	return ((freq_in_mhz * data_rate * system_arq * interfaces / byte) / first_word)

def main():
	ram1 = ram_speed(2133, 5)
	ram2 = ram_speed(2400, 4)

if __name__ == '__main__':
	main()