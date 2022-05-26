## Learning pine script

See also:

* FREE Pine Script Basics Course: http://www.pinescriptbasics.com/​
* Pine Script Mastery Course: http://www.pinescriptmastery.com/​
* My Indicators: https://zenandtheartoftrading.com/ind...​
* Pine Scripters Network (Forum): https://www.pinescripters.net


## Generic tips

* when writing a function, press Ctrl+Space to see the list of functions.
* Hover over a function to see a popup box with the conditions that the function uses.
* Ctrl-Click on the function to see the Pine script reference manual.

### Lesson 1: Ultra basics

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
// If overlay is not used, the script will plot the graph below in a separate window
study("Lesson 1", overlay=true)
plot(close)
```

### Lesson 2: Drawing an indicator

In this script two lines are plotted. One with highest values over 50 days and oen with lowest values over 50 days.

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
// If overlay is not used, the script will plot the graph below in a separate window
study("Lesson 2", overlay=true)

// Use Ctrl + space to list inbuild functions

// highest is a function, variable 1 is the high value, second variable is the 'over how many last candles'
highestHigh = highest(high, 50)
// Same goes for lowestLow value
lowestLow = lowest(low, 50)

// Which value in the script to plot
plot(highestHigh)
plot(lowestLow)
```

Now adding some controls to make it more flexible for a user. Like a adjustable RSI lookback parameter:

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
// If overlay is not used, the script will plot the graph below in a separate window
study("Lesson 2", overlay=true)

// Use Ctrl + space to list inbuild functions

// Lookback variable for the user to manually control the days to look back for high/low candles
// This variable makes use of the 'input function to get values from the user' It contains four variables.
lookback = input(title="Lookback period", type=input.integer, defval=50, minval=1 )

// highest is a function, variable 1 is the high value, second variable is the 'over how many last candles'
highestHigh = highest(high, lookback)
// Same goes for lowestLow value
lowestLow = lowest(low, lookback)

// Which value in the script to plot
plot(highestHigh)
plot(lowestLow)
```

The lines also can have customizations like:

```
// Which value in the script to plot
// And adding some customizations to the default plot function like color, transparancy and linewidth
plot(highestHigh, color=color.red, transp=0, linewidth=2)
plot(lowestLow, color=color.green, transp=0, linewidth=2)
```

### Lesson 3: Getting basic user input

Using boolean variable

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
study("Lesson 3")

// Using different types of user input
// boolean (true/false)
booleanInput = input(title="Boolean", type=input.bool, defval=true)

// define variable data
data = -1
// Using a conditional operator (if  -  then statement)
if booleanInput
    // if there is no statement after 'if' then default value is assumed to be 'true'
    // the next line will not be executed unless the boolean value is true
    // if true, then set data to 1
    data := 1  // This is a shadowing variable and has to be set witn :=

// plot the data variable
plot(data)
```

If-then statements can also be made by a conditional operator:

```
//@version=4
study("Lesson 3")

// Using different types of user input
// boolean (true/false)
booleanInput = input(title="Boolean", type=input.bool, defval=true)

// Using a conditional operator to plot data
// If boolean set to true ? then `1` else : 0
plot(booleanInput ? 1 : 0, color=color.red )
```

Additionally plot an integer, float and us a text box.

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
study("Lesson 3")

// Using different types of user input
// boolean (true/false)
booleanInput = input(title="Boolean", type=input.bool, defval=true)
// Integer input
integerInput = input(title="Integer", type=input.integer, defval=2)
// Float input
floatInput = input(title="Float", type=input.float, defval=3.3)
// String input, we make use of an array here as well as an additional option. This will create a dropdown list in the settings menu.
// This text will appear in the values field of the indicator in the screen
stringInput1 = input(title="String1", type=input.string, defval="Stringtext1", options=["Stringtext1","Sometext"])
// For free text input, just don't use the array
stringInput2 = input(title="String2", type=input.string, defval="Stringtext2")


// Using a conditional operator to plot data
// If boolean set to true ? then `1` else : 0
plot(booleanInput ? 1 : 0, color=color.red )
// Plot the integer
plot(integerInput, color=color.blue)
// Plot the float
plot(floatInput, color=color.green)
```

Draw a label below the last bar

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
study("Lesson 3")

// Using different types of user input
// boolean (true/false)
booleanInput = input(title="Boolean", type=input.bool, defval=true)
// Integer input
integerInput = input(title="Integer", type=input.integer, defval=2)
// Float input
floatInput = input(title="Float", type=input.float, defval=3.3)
// String input, we make use of an array here as well as an additional option. This will create a dropdown list in the settings menu.
// This text will appear in the values field of the indicator in the screen
stringInput1 = input(title="String1", type=input.string, defval="Stringtext1", options=["Stringtext1","Sometext"])
// For free text input, just don't use the array
stringInput2 = input(title="String2", type=input.string, defval="Stringtext2")


// Using a conditional operator to plot data
// If boolean set to true ? then `1` else : 0
plot(booleanInput ? 1 : 0, color=color.red )
// Plot the integer
plot(integerInput, color=color.blue)
// Plot the float
plot(floatInput, color=color.green)

// Draw a label on the indicator
if (barstate.islast)
    labelExample = label.new(bar_index, na, stringInput1, color=color.green, textcolor=color.white, style=label.style_label_up, yloc=yloc.belowbar)
```

### Lesson 4: Make use of the RSI indicator

The following script makes use of the inbuild rsi indicator and creates a signal when oversold / overbought conditions are met.

```
//@version=4
study("Lesson 4", overlay=true)
// Using in build indocators

// Get user input
// User can determine the source for the RSI indicator
rsiSource = input(title="RSI source", type=input.source, defval=close)
// Let user choose which legth to use for the RSI
rsiLength = input(title="Rsi length", type=input.integer, defval=14)
// Determine overbought / oversold levels
rsiOverbought = input(title="RSI overbought level", type=input.integer, defval=74)
rsiOversold = input(title="RSI oversold", type=input.integer, defval=26)

// Use the inbuild RSI function of tradingview
// rsi function uses two inputs, the source and the length 
rsiValue = rsi(rsiSource, rsiLength)

// Provide an alarm when rsi is overbought or oversold

// Set isRsiOverbought to true if rsiValue is greater or equal than rsiOverbought
isRsiOverbought = rsiValue >= rsiOverbought

// Same for rsiOversold
isRsiOversold = rsiValue <= rsiOversold


// Plot signals to chart with a certain shape with the plotshape function
// This function uses a boolean value(yes/no) before drwaing something to the screen, 
plotshape(isRsiOverbought, title="Overbought", location=location.abovebar, color=color.red, transp=0, style=shape.triangledown, text="Sell")
plotshape(isRsiOversold, title="Oversold", location=location.belowbar, color=color.green, transp=0, style=shape.triangleup, text="Buy")

// With plotshape the plot() is not necessary
// plot(close)
```

### Lesson 5: Adding an alert to a script

The last script is used. Notice the last few lines in the script:

```
//@version=4
study("Lesson 5"    
// Generating alerts!

rsiSource = input(title="RSI source", type=input.source, defval=close)
rsiLength = input(title="Rsi length", type=input.integer, defval=14)
rsiOverbought = input(title="RSI overbought level", type=input.integer, defval=74)
rsiOversold = input(title="RSI oversold", type=input.integer, defval=26)
rsiValue = rsi(rsiSource, rsiLength)
isRsiOverbought = rsiValue >= rsiOverbought
isRsiOversold = rsiValue <= rsiOversold

plotshape(isRsiOverbought, title="Overbought", location=location.abovebar, color=color.red, transp=0, style=shape.triangledown, text="Sell")
plotshape(isRsiOversold, title="Oversold", location=location.belowbar, color=color.green, transp=0, style=shape.triangleup, text="Buy")

// For alerts, we only add this line of code
// uses three inputs, a boolean to trigger the alert, title for the popup box, email heading and message 
alertcondition(isRsiOverbought or isRsiOversold, title="RSI signal!", message="RSI signal detected for {{exchange}}:{{ticker}}" )

// You can use special placeholders to access variable values in alert’s message. For example, you can create an alert on NASDAQ:AAPL and type in a message box: 
// {{exchange}}:{{ticker}}, price = {{close}}, volume = {{volume}}
// for more information: https://www.tradingview.com/chart/?solution=43000531021
```

### Lesson 6: Detecting engulfing candles

This lesson follows up on lesson 5.

```
//@version=4
study("Lesson 6", overlay=true)

rsiSource = input(title="RSI source", type=input.source, defval=close)
rsiLength = input(title="Rsi length", type=input.integer, defval=14)
rsiOverbought = input(title="RSI overbought level", type=input.integer, defval=74)
rsiOversold = input(title="RSI oversold", type=input.integer, defval=26)
rsiValue = rsi(rsiSource, rsiLength)
isRsiOverbought = rsiValue >= rsiOverbought
isRsiOversold = rsiValue <= rsiOversold

// Detecting engulfing candles
// Line below creates a variable which detects that the close of the current candle is greater or
// equal than the open candle before it (open[] is an arrray and [1] is one candle before [2] is two candles before etcetera)
// AND that the previous candle closed bearish. Again [2] is the position in the array of candles ([25] is 25 candles before)
bullishEC = close >= open[1] and close[1] < open[1]
bearishEC = close <= open[1] and close[1] > open[1]
// Now create a condition to make a signal (if conditions are met, tradesignal = true)
tradeSignal = ((isRsiOversold or isRsiOversold[1]) and bullishEC) or ((isRsiOverbought or isRsiOverbought[1]) and bearishEC)

// Change the plotshapes so that they only give an alarm when the overboudht AND engulfing candles are met.
plotshape(isRsiOverbought and bearishEC, title="Overbought", location=location.abovebar, color=color.red, transp=0, style=shape.triangledown, text="Sell")
plotshape(isRsiOversold and bullishEC, title="Oversold", location=location.belowbar, color=color.green, transp=0, style=shape.triangleup, text="Buy")

//Changing the line below because we want to be alarmed under any customstance (bullish & bearish)
alertcondition(tradeSignal, title="RSI signal!", message="RSI signal detected for {{exchange}}:{{ticker}}" )
```

### Lesson 7: Using the ATR for trailing stop-loss

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
study("Lesson 7", overlay=true)

//Get inputs
atrLength = input(title="ATR length:", type=input.integer, defval=14, minval=1)
useStructure = input(title="Use structure?", type=input.bool, defval=true)
lookback = input(title="How far to look back for H/L:", type=input.integer, defval=7, minval=1)
atrStopMultiplier = input(title="ATR multiplier", type=input.float, defval=1.0, minval=0.1)

// Calculate data
// Use the standard atr function from TV
atr = atr(atrLength)

// calculate the longStop with :
// First determine if useStructure = yes, then calculate stoploss with lowest low over our lookback period, ELSE use closing price
// THEN extract atr value
longStop = (useStructure ? lowest(low, lookback) : close) - atr * atrStopMultiplier
// Do the same with short trades
shortStop = (useStructure ? highest(high, lookback) : close) + atr * atrStopMultiplier

// Draw stuff on the screen
plot(atr, color=color.blue, title="ATR", transp=100)
// Plot the longstop and shortstop on the screen with the next settings
plot(longStop, color = color.green, style=plot.style_linebr, title="Long trailing stop", transp=0)
plot(shortStop, color = color.red, style=plot.style_linebr, title="Long trailing stop", transp=0)
```

### Lesson 8: Creating and using a higher timeframe indicator

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
study("Lesson 8", overlay=true)

// Make a configuration variable and use the resolution type. Values can be D, W, M etc.
res = input(title="EMA timeframe", type=input.resolution, defval="D")
len = input(title="EMA length", type=input.integer, defval=50, minval=1)
col = input(title="Color EMA", type=input.bool, defval=true)
smooth = input(title="Smooth?", type=input.bool, defval=true)

// Calculate EMA
ema = ema(close, len)
// The security function points to the chosen asset(coin, stock etc.). syminfo.tickerid points to the current ticker selected
emaSmooth = security(syminfo.tickerid, res, ema, barmerge.gaps_on, barmerge.lookahead_off)
emaStep = security(syminfo.tickerid, res, ema, barmerge.gaps_off, barmerge.lookahead_off)

// Draw stuff
// Conditional statements in the plot function - if else statement on smooth (if smooth is set, then smaSmooth else smaStep
// Also an nested if else statement on color: if color = col, and close greater than emaStep, then color=green else red, if color is not true then black 
plot(smooth ? emaSmooth : emaStep, color=col ? close > emaStep ? color.green : color.red : color.black, linewidth=2, title="EMA (HTF)")
```

### Lesson 9: Prevent repainting of an indicator

```
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © DutchCryptoDad

//@version=4
study("Lesson 9", overlay=true)

res = input(title="Timeframe", type=input.resolution, defval="D")

// custom function
// create non-repainting security function
// Line below will repaint so it has to be improved with non repaining functionality
// rp_function(_symbol, _res, _src) => security(_symbol, _res, _src)
//
// Addind a conditional statement to src to prevent repainting
// This statement points to the values of the previous bar if the current bar is real time
rp_function(_symbol, _res, _src) => security(_symbol, _res, _src[barstate.isrealtime ? 1 : 0])


// get HTF data
htfHigh = rp_function(syminfo.tickerid, res, high)
htfLow = rp_function(syminfo.tickerid, res, low)


plot(htfHigh, color=color.red, title="Htf High")
plot(htfLow, color=color.teal, title="Htf Low")
```
