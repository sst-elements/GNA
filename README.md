# GNA

Implementation of a 'Generic Neural Architecture' based on the STPU work (Hill et All, ICRC 2017, "A Spike-Timing
Neuromorphic Architecture", 10.1109/ICRC.2017.8123631)

## General simulation process

1. GNA in idle state waiting for user input. If user sends EXEC command proceed to step 1, otherwise, stay idle.
2. process any firing events currently stored in output aggregation FIFO into neuronal matrix based on connectivity
defined in specified CSE context.
3. Perform single LIF operation on neuronal matrix.
4. Collect firing events (if any) into output aggregation FIFO.
5. If more LIFs to perform or more CSEs to process, then return to step 0, otherwise, dump aggregated firing events to
host machine and return to step 0.

## TODO

- Set Neuron values as (variable precision) ints or floats
- Time delay for output consoldiation?
- Statistics (request q size)
- Switch to output, rm `printf()`s
- Make sure `maxOutMem` works
