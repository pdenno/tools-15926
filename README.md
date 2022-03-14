# Tools-15926 - a browser-based application for test certain parts of ISO-15926

Tools-15926 implements tools to test whether given schema and data of Parts 2, 7 and 8 of [ISO 15926](https://en.wikipedia.org/wiki/ISO_15926) are logically well-formed and consistent. 
See also [15926.org](https://15926.org/home/)

![alt text](https://github.com/pdenno/tools-15926/blob/main/data/screenshot-2022-03-14-part7.png)

Implementation of this application began in 2012, at which time it was used for validation of "templates."
These templates describe a metamodel (or schema) for lifecycle data for process plants conforming to one of the ISO 15926 parts.
The software reads Part 2 EXPRESS and OWL definitions of templates. 
It uses the [Vampire](https://github.com/vprover/vampire) theorem prover for consistency checking. 
It uses the OMG's Ontology Definition Metamodel (ODM) to map these to structures presented in the browser. 

The implemenation is currently recovering from code rot.
 * It is Common Lisp code and is now compiled with [SBCL](http://www.sbcl.org/).
 * The revitalized code uses a new, apparently well-maintained, open source version of [Vampire](https://github.com/vprover/vampire).
 * Owing to the fact that it has been about 9 years since this application has been used, parts of it are currently 
   broken, (particularly parts pertaining to Parts 7 and 8). 

# Usage

[This will describe how to run the program from Docker.]


## To Do

* Explore the Part 7/8 interface. 

## Disclaimer

This software was developed by [NIST](http://nist/gov). [This disclaimer](https://www.nist.gov/el/software-disclaimer) applies.

# Contact Us

<a target="_blank" href="mailto:peter.denno@nist.gov">Peter Denno (peter.denno ( at ) nist.gov</a>
