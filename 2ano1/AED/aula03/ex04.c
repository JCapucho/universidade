#include <stdio.h>
#include <stdlib.h>

int ipow(int base, int exp) {
	int accum = 1;

	for (int i = 1; i <= exp; i++) {
		accum *= base;
	}

	return accum;
}

// First version, not general
// int main(void) {
// 	for (int i = 100; i < 1000; i++) {
// 		int sum = 0;
//
// 		for (int j = i; j != 0; j /= 10) {
// 			const int digit = j % 10;
//
// 			sum += ipow(digit, 3);
// 		}
//
// 		if (i == sum)
// 			printf("%d é um número de Armstrong\n", i);
// 	}
//
// 	return 0;
// }

int num_digits(int a) {
	int accum = 0;

	for (int j = a; j != 0; j /= 10) {
		accum++;
	}

	return accum;
}

// Second version, general
int main(int argv, char* argc[]) {
	int max = 1000;

	if (argv > 1) {
		max = atoi(argc[1]);
	}

	for (int i = 1; i < max; i++) {
		const int n = num_digits(i);
		int sum = 0;

		for (int j = i; j != 0; j /= 10) {
			const int digit = j % 10;

			sum += ipow(digit, n);
		}

		if (i == sum)
			printf("%d é um número de Armstrong\n", i);
	}

	return 0;
}
