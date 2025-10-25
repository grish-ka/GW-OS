#ifndef DRIVERS_PORTS_H
#define DRIVERS_PORTS_H

/*
 * Reads a byte from the specified I/O port.
 */
unsigned char port_byte_in(unsigned short port);

/*
 * Writes a byte to the specified I/O port.
 */
void port_byte_out(unsigned short port, unsigned char data);

/*
 * Reads a 16-bit word from the specified I/O port.
 */
unsigned short port_word_in(unsigned short port);

/*
 * Writes a 16-bit word to the specified I/O port.
 */
void port_word_out(unsigned short port, unsigned short data);

#endif /* DRIVERS_PORTS_H */
