#include <stdio.h>

int factorial(int n) {
	int accum = 1;

	for (int i = 2; i <= n; i++) {
		accum *= i;
	}

	return accum;
}

// First version, not optimized
// approx 27.8 ms
// int main(void) {
// 	for (int i = 1; i < 1000000; i++) {
// 		int sum = 0;
//
// 		for (int j = i; j != 0; j /= 10) {
// 			const int digit = j % 10;
//
// 			sum += factorial(digit);
// 		}
//
// 		if (i == sum)
// 			printf("%d é um factorião\n", i);
// 	}
//
// 	return 0;
// }

// Second version, LUT for digit factorials
// approx 5.5 ms
int main(void) {
	const int lut[10] = {
		factorial(0),
		factorial(1),
		factorial(2),
		factorial(3),
		factorial(4),
		factorial(5),
		factorial(6),
		factorial(7),
		factorial(8),
		factorial(9),
	};

	for (int i = 1; i < 1000000; i++) {
		int sum = 0;

		for (int j = i; j != 0; j /= 10) {
			const int digit = j % 10;

			sum += lut[digit];
		}

		if (i == sum)
			printf("%d é um factorião\n", i);
	}

	return 0;
}
