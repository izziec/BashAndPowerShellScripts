#!/bin/bash
unalias -a

#ls, ps, sed, cut, paste, sort, tr, grep, awk, cat, uniq, head

# Prompt the user to enter 2 numbers
echo Enter 2 numbers:
read num1 num2

# If either entry is blank or not a number (either integer or floating-point), print a message, and loop until two valid numbers are entered.
numformat='^-?[0-9]+([.][0-9]+)?$'
while ! [[ $num1 =~ $numformat || $num2 =~ $numformat ]];
do
	echo One or more entries not a number. Please enter 2 numbers:
	read num1 num2
done
# Once valid inputs are received, print out the inputs and their sum as follows. You can use bc to determine the sum.
add=`echo "$num1 + $num2" | bc`
echo $num1 + $num2 = $add