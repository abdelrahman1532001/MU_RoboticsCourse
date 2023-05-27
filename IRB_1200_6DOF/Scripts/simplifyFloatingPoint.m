function simplifiedNumber = simplifyFloatingPoint(inputNumber, numDigits)
    % Multiply by 10^n to shift the digits
    shiftedNumber = inputNumber * 10^numDigits;

    % Round the shifted number to the nearest integer
    roundedNumber = round(shiftedNumber);

    % Divide by 10^n to shift the digits back
    simplifiedNumber = roundedNumber / 10^numDigits;
end

