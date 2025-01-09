# ELEC 201: An introduction to Electronics
So begins my suffering.

## Charge
Specifically, ***Electric Charge***, designated symbol $q$ in units of *coulombs (C)*

Example: The amount of a charge that has gone through an element is given by

$$ q(t) = 8t^2 + 4t -2 \text{  }C$$

Since we're working with electrons, all charges we use must be in multiples of electrons. Unless of course, you split an electron, but somehow that feels like a bad idea...

Correspondingly, the charge of one electron is approximately: 
$$q_e = 1.602\times 10^{-19} C$$
We'd need billions of electrons to even get close to the charge of a *single* coulomb. Turns out, it's actually difficult to work with electrons on an individual level since in any computer, there are way too many of them!

Hence, we now think of electrons, and subsequently charge, as a fluid, which makes the electric phenomena much easier to digest.

## Current

Once this fluid begins to move, we create a ***Current!*** We now define current as a *moving positive charge*. One might naturally ask why, if we're working with electrons, do we define current with positive charge? Because a negative charge moving in one direction is identical to a positive charge moving in the *opposite* direction. The electromagnetic fields they generate are identical.
> Of course, there are cases where the difference matters, but for the purposes of this course we won't have to worry about that.

We define **Current** as *coulombs per second*, which, since we use so often, we just redefine as a new unit, the ***Ampere (I)***

Furthermore, we can define current as:

$$ i(t) = \frac{dq}{dt} $$

Where current is the change of charge over the change of time. Hey, since we know charge through an element at a point in time is $q(t) = 8t^2 + 4t -2 \text{  }C$, then we can use the derivative to find:

$$ i(t) = 16t + 4 $$

Unsurprisingly, we can also integrate to find charge once more:

$$ q(t) = \int i(t)\space dt$$

## Voltage

In an electric field, we measure the *height* of an electron in $\frac{J}{C}$, but like everything else this got a bit long to write so we use ***Volts (V)***. 

A drop from X to Y is how much higher X is than Y, similarly, the voltage in an *element* (like a resistor) is the drop between its *terminals*.

> A quick note: When we say positive and negative terminal, we're not saying one is *positively* charged and another is *negatively* charged. Rather, one is *higher than*, and another is *lower than*. Maybe they're both positively charged, maybe it's a mix, maybe they're both negatively charged.

## Power

The formula for electric power is:

$$ p = vi$$

Where power is the drop multiplied by the current. We define this for *absorbed* power, since this power is defined by *voltage drop*. Of course, a negative absorbed power is simply power produced.

