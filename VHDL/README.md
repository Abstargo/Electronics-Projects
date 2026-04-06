# VHDL Repository

Welcome to my VHDL playground!  
This repository contains VHDL designs, testbenches, and exercises.  
Below you’ll find a quick reference to the **fundamental basics** of the VHDL language and its syntax.

---

## 1. What is VHDL?

**VHDL** (VHSIC Hardware Description Language) is used to model digital hardware.  
It is **not** a programming language – it describes **parallel** hardware behaviour and structure.

---

## 2. Basic Structure of a VHDL Design

Every VHDL module consists of two mandatory parts:

### Entity
Describes the **external interface** (inputs and outputs).
```vhdl
entity my_gate is
    port (
        a, b : in  bit;   -- inputs
        y    : out bit    -- output
    );
end entity;

Architecture

Describes what the circuit does (internal behaviour or structure).
vhdl

architecture behavioral of my_gate is
begin
    y <= a and b;   -- concurrent assignment
end architecture;

3. Common Data Types
Type	Description	Example value
bit	0 or 1	'0', '1'
bit_vector	Array of bits	"1010"
std_logic	9-valued logic (U, X, 0, 1, Z, W, L, H, -)	'0', '1', 'Z'
std_logic_vector	Array of std_logic	"1010"
integer	Integer number (for simulation)	5, -3
boolean	true / false	true
unsigned / signed	Arithmetic vectors (need numeric_std)	"1010" = 10

    Important: For arithmetic, use numeric_std library and unsigned/signed.

vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

4. Operators
Logical (on bit, std_logic, vectors of same length)

and, or, nand, nor, xor, xnor, not
Relational

=, /=, <, <=, >, >=
Arithmetic (for integer, unsigned, signed)

+, -, *, /, mod, rem, abs
Shift (for vectors)

rol, ror, sll, srl, sla, sra
Concatenation

& e.g. y <= a & b; (a and b become a 2-bit vector)
5. Two Main Coding Styles
Concurrent (outside a process)

    Happens in parallel – like real hardware.

    Examples: and/or gates, conditional when...else, selected with...select.

vhdl

y <= (a and b) or (c and d);                     -- simple gate
with sel select
    y <= a when "00",
         b when "01",
         c when others;

Sequential (inside a process)

    Statements execute one after another (simulation order).

    Must have a sensitivity list or wait statements.

vhdl

process (a, b, sel)
begin
    if sel = '1' then
        y <= a;
    else
        y <= b;
    end if;
end process;

    Rule for combinational logic: the sensitivity list must contain all signals read inside the process.

6. Processes – Quick Rules
Circuit type	Sensitivity list contains	Signal updates
Combinational	All inputs read	No clock, no edge
Synchronous (clock)	Only clk (and async reset)	On rising_edge(clk) etc.
Asynchronous	clk, reset (level/edge)	On reset or clock edge

Example – D flip‑flop with synchronous reset:
vhdl

process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            q <= '0';
        else
            q <= d;
        end if;
    end if;
end process;

7. Signals vs Variables
	Signals	Variables
Scope	Entire architecture / process	Only inside a process
Assignment	<=	:=
Update	At end of process (or after wait)	Immediately
Hardware	Wires / registers	Temporary (simulation only)
8. Commonly Used Libraries
vhdl

library ieee;
use ieee.std_logic_1164.all;   -- std_logic, std_logic_vector
use ieee.numeric_std.all;      -- unsigned, signed, arithmetic
use ieee.math_real.all;        -- mathematical functions (testbenches)

9. Simple Example – 2‑to‑1 Multiplexer
vhdl

entity mux2 is
    port (
        a, b, sel : in  std_logic;
        y         : out std_logic
    );
end mux2;

architecture rtl of mux2 is
begin
    y <= a when sel = '0' else b;
end rtl;