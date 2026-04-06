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
´´´
## VHDL Reserved Words

**abs**           operator, absolute value of right operand. No () needed.
**access**        used to define an access type, pointer
**after**         specifies a time after NOW
alias         create another name for an existing identifier
all           dereferences what precedes the .all
and           operator, logical "and" of left and right operands
architecture  a secondary design unit
array         used to define an array, vector or matrix
assert        used to have a program check on itself
attribute     used to declare attribute functions
begin         start of a  begin  end  pair
block         start of a block structure
body          designates a procedure body rather than declaration
buffer        a mode of a signal, holds a value
bus           a mode of a signal, can have multiple drivers
case          part of a case statement
component     starts the definition of a component
configuration a primary design unit
constant      declares an identifier to be read only
disconnect    signal driver condition
downto        middle of a range  31 downto 0
else          part of "if" statement, if cond then ... else ... end if;
elsif         part of "if" statement, if cond then ... elsif cond ...
end           part of many statements, may be followed by word and id
entity        a primary design unit
exit          sequential statement, used in loops
file          used to declare a file type
for           start of a for type loop statement
function      starts declaration and body of a function
generate      make copies, possibly using a parameter
generic       introduces generic part of a declaration
group         collection of types that can get an attribute
guarded       causes a wait until a signal changes from False to True
if            used in "if" statements
impure        an impure function is assumed to have side effects
in            indicates a parameter in only input, not changed
inertial      signal characteristic, holds a value
inout         indicates a parameter is used and computed in and out
is            used as a connective in various statements
label         used in attribute statement as entity specification
library       context clause, designates a simple library name
linkage       a mode for a port, used like buffer and inout
literal       used in attribute statement as entity specification
loop          sequential statement, loop ... end loop;
map           used to map actual parameters, as in  port map
mod           operator, left operand modulo right operand
nand          operator, "nand" of left and right operands
new           allocates memory and returns access pointer
next          sequential statement, used in loops
nor           operator, "nor" of left and right operands
not           operator, complement of right operand
null          sequential statement and a value
of            used in type declarations, of Real ;
on            used as a connective in various statements
open          initial file characteristic
or            operator, logical "or" of left and right operands
others        fill in missing, possibly all, data
out           indicates a parameter is computed and output
package       a design unit, also  package body
port          interface definition, also  port map
postponed     make process wait for all non postponed process to suspend
procedure     typical programming procedure
process       sequential or concurrent code to be executed
pure          a pure function may not have side effects
range         used in type definitions, range 1 to 10;
record        used to define a new record type
register      signal parameter modifier
reject        clause in delay mechanism, followed be a time
rem           operator, remainder of left operand divided by right op
report        statement and clause in assert statement, string output
return        statement in procedure or function
rol           operator, left operand rotated left by right operand
ror           operator, left operand rotated right by right operand
select        used in selected signal assignment statement
severity      used in assertion and reporting, followed by a severity
signal        declaration that an object is a signal
shared        used to declare shared objects
sla           operator, left operand shifted left arithmetic by right op
sll           operator, left operand shifted left logical by right op
sra           operator, left operand shifted right arithmetic by right
srl           operator, left operand shifted right logical by right op
subtype       declaration to restrict an existing type
then          part of  if condition then ...
to            middle of a range  1 to 10
transport     signal characteristic
type          declaration to create a new type
unaffected    used in signal waveform
units         used to define new types of units
until         used in wait statement
use           make a package available to this design unit
variable      declaration that an object is a variable
wait          sequential statement, also used in case statement
when          used for choices in case and other statements
while         kind of loop statement
with          used in selected signal assignment statement          
xnor          operator, exclusive "nor" of left and right operands
xor           operator, exclusive "or" of left and right operands

