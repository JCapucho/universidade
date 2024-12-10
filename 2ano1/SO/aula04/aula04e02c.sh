#!/usr/bin/env bash
ret() {
	test_return() { return "$1"; }

	for i in {-1000..0}; do
		test_return "$i"
		if [ "$?" -eq "$i" ]; then
			echo "Lower bound: $i"
			break
		fi
	done

	for i in {0..1000}; do
		test_return "$i"
		if [ "$?" -ne "$i" ]; then
			echo "Upper bound: $(($i - 1))"
			break
		fi
	done
}

ret
