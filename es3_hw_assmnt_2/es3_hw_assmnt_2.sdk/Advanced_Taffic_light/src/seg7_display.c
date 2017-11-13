/*File Name: seg7_display.c
Project Name: Traffic_Light
Target Device/Platform: Basys3 Board (with Microblaze processor on the Artix-7 FPGA)
Tool Version: Xilinx SDK 2015.2
Name: Tianle Zhang
Company: University of Edinburgh
Creation Date and Time: 11/11/2016; 14:07
Description:
This source file contains functions used to drive the 7 segment display.
There are three functions in this file.
The displayNumber() function receives an unsigned 16-bit integer.
It is used to assign the digit number and the value to be displayed per digit when the timer interrupt occurs.
The calculateDigits() function is used to extract the digits
(of which a maximum of four can be displayed)
from the number to be displayed.
The hwTimerISR() (which is defined in the xinterruptES3.c file) method is used to call the displayDigit() method,
which selects the segments and displays the digits on the 7-segment display.
All these functions are declared in the seg7_display.h header file.*/

#include "control.h"
#include <stdio.h>
#include "platform.h"
#include "gpio_init.h"
#include "xgpio.h"
#include "interface.h"
#include "seg7_display.h"
#include "xil_types.h"

u8 digitDisplayed = FALSE;
u8 digits[4];
u8 numOfDigits;
u8 digitToDisplay;
u8 digitNumber;
int max_time;
int i=0;

void displayNumber(u16 number, int time)
{

	max_time= time;	//it was defined in the assessment 1 for the flash mode of 7-segments, but it is not used here.
	u8 count;

	if (number < 10)
	/*if the actual value is less than 1 (i.e. number<10),
	 *one "0" before fractional part should be displayed*/
	{
		// Call the calculateDigits method to determine the digits of the number
		calculateDigits(number);
		/* Do not display leading zeros in a number,
		 * but if the entire number is a zero, it should be displayed.
		 * By displaying the number from the last digit, it is easier
		 * to avoid displaying leading zeros by using the numOfDigits variable
		 */
		count = 4;
		while (count > 3 - numOfDigits)
		{
			digitToDisplay = digits[count-1];
			digitNumber = count;
			count--;
			/* Wait for timer interrupt to occur and ISR to finish
			 * executing digit display instructions
			 */
			while (digitDisplayed == FALSE);
			digitDisplayed = FALSE;
		}

	}
	else if ((number <= 9999) && (number >=10))
		{
			// Call the calculateDigits method to determine the digits of the number
			calculateDigits(number);
			/* Do not display leading zeros in a number,
			 * but if the entire number is a zero, it should be displayed.
			 * By displaying the number from the last digit, it is easier
			 * to avoid displaying leading zeros by using the numOfDigits variable
			 */
			count = 4;
			while (count > 4 - numOfDigits)
			{
				digitToDisplay = digits[count-1];
				digitNumber = count;
				count--;
				/* Wait for timer interrupt to occur and ISR to finish
				 * executing digit display instructions
				 */
				while (digitDisplayed == FALSE);
				digitDisplayed = FALSE;
			}

		}
	/* Note that 9999 is the maximum number that can be displayed
	 * Therefore, check if the number is less than or equal to 9999
	 * and display the number otherwise, display dashes in all the four segments
	 */
	else
	{
		count = 1;
		while (count <5)
		{
			digitToDisplay = NUMBER_DASH;
			digitNumber = count;
			count++;
			/* Wait for timer interrupt to occur and ISR to finish
			 * executing digit display instructions
			 */
			while (digitDisplayed == FALSE);
			digitDisplayed = FALSE;
	}
}
}

void calculateDigits(u16 number)
{
	u8 fourthDigit;
	u8 thirdDigit;
	u8 secondDigit;
	u8 firstDigit;

	// Check if number is up to four digits

	if (number > 999 )
	{
		numOfDigits = 4;

		fourthDigit  = number % 10;
		thirdDigit = (number / 10) % 10;
		secondDigit  = (number / 100) % 10;
		firstDigit = number / 1000;
	}
	// Check if number is three-digits long
	else if (number > 99 && number < 1000)
	{
		numOfDigits = 3;

		fourthDigit  = number % 10;
		thirdDigit = (number / 10) % 10;
		secondDigit  = (number / 100) % 10;
		firstDigit = 0;
	}
	// Check if number is two-digits long
	else if (number > 9 && number < 100)
	{
		numOfDigits = 2;
		fourthDigit  = number % 10;
		thirdDigit = (number / 10) % 10;
		secondDigit  = 0;
		firstDigit = 0;
	}
	// Check if number is one-digit long
	else if (number >= 0 && number < 10)
	{
		numOfDigits = 1;

		fourthDigit  = number % 10;
		thirdDigit = 0;
		secondDigit  = 0;
		firstDigit = 0;
	}

	digits[0] = firstDigit;
	digits[1] = secondDigit;
	digits[2] = thirdDigit;
	digits[3] = fourthDigit;

	return;
}

void displayDigit()
{
	//The timsqrter ISR is used to call this function to display the digits

	if(i<max_time)
		i++;
	if(i==max_time)
	{					//delay for flash mode
		i = 0;
	if(digitNumber == 3){
	//the decimal point of the 3rd 7_segment dispalys
		switch (digitToDisplay)
			{
				case NUMBER_BLANK :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_BLANK-0x80);
					break;
				case 0 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_ZERO-0x80);
					break;
				case 1 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_ONE-0x80);
					break;
				case 2 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_TWO-0x80);
					break;
				case 3 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_THREE-0x80);
					break;
				case 4 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_FOUR-0x80);
					break;
				case 5 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_FIVE-0x80);
					break;
				case 6 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_SIX-0x80);
					break;
				case 7 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_SEVEN-0x80);
					break;
				case 8 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_EIGHT-0x80);
					break;
				case 9 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_NINE-0x80);
					break;
				case NUMBER_DASH :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_DASH);
					break;
			}
	}
	else
	{
		switch (digitToDisplay)
			{
				case NUMBER_BLANK :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_BLANK);
					break;
				case 0 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_ZERO);
					break;
				case 1 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_ONE);
					break;
				case 2 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_TWO);
					break;
				case 3 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_THREE);
					break;
				case 4 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_FOUR);
					break;
				case 5 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_FIVE);
					break;
				case 6 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_SIX);
					break;
				case 7 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_SEVEN);
					break;
				case 8 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_EIGHT);
					break;
				case 9 :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_NINE);
					break;
				case NUMBER_DASH :
					XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_DASH);
					break;

			}
	}

	// Select the appropriate digit
	if (digitNumber == 1) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_FIRST_SEG);
	}
	else if (digitNumber == 2) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_SECOND_SEG);
	}
	else if (digitNumber == 3) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_THIRD_SEG);
	}
	else if (digitNumber == 4) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_FOURTH_SEG);
	}

	digitDisplayed = TRUE;
	return;
	}
}

