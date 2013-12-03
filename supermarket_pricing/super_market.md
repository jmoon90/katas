##Goal

The goal of this kata is to practice a looser style of experimental modelling. Look for as many different ways of handling the issues as possible. Consider the various tradeoffs of each. What techniques use best for exploring these models? For recording them? How can you validate a model is reasonable?

##My Process

There are many decision to be made. Each decision I make leads me to a different road. This supermarket pricing kata has issues I need to consider.

* does fractional money exist?
* when (if ever) does rounding take place?
* how do you keep an audit trail of pricing decisions (and do you need to)?
* are costs and prices the same class of thing?
* if a shelf of 100 cans is priced using "buy two, get one free", how do you value the stock?

In groceries there are instances where fractional money do exist. When I code, I would need to count that aspect of money into play. The value we pay and receive maybe only up to the 2nd decimal, but when adding individual items that have prices up to the 3rd decimal, for instance buying some fruit or vegetable, I need to add those up and round them to the 2nd place.
That gives a good entry into the next problem of rounding. It should only take place for items beyond the 2nd decimal.
I think the decision of keeping an audit trail of pricing decision depends. I can either assume that the rounding will level out as more and more of the item is sold. If we were to keep track it would have to be done in each transaction.
Costs and Price would be in the same class IndividualItem. Each item will have a cost, price, and quantity instance methods.
In cases of "buy two, get one free" items, I would value stock two ways. The is individually, because there are people who do not buy 2 and just busy 1. On top of that I would value items that was bought with the deal. I think it is important to value them individually and with the discount.


