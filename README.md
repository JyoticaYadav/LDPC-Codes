# LDPC-Codes
Simulation of bit error rate performance of a regular (3,6) LDPC code over an additive white Gaussian noise (AWGN) channel.

A MATLAB to decode a regular LDPC code transmitted over an additive white gaussian channel is attached above. Decoding is done
using Sum Product Algorithm (SPA). The entire code is divided into small chunks (functions) where the calling function named 
"code" works as a baseline. 
The parity check matrix required for the procedure was given in the form of a table which has been stored in an excel sheet and
is called during the operation by the calling function.
The result of the code is in the form of a graph plotted between end to end probabilty of error and received signal to noise ratio.
