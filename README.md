# SHORT-PULSE-GENERATOR

# ⚡ Short Pulse Generator (Verilog)

This Verilog module generates a **single short pulse** (1 clock cycle wide) **after every 10 active clock cycles** of a `start` signal. This is useful for creating event markers, synchronization flags, or edge-triggered control signals.

---

## 📦 Module: `short_pulse_generator`

### 🧠 Functional Description

- When `start = 1`, a 4-bit counter begins counting clock cycles.
- On the 10th clock cycle (i.e., when `count == 9`), the module generates a **single-cycle pulse** (`pulse = 1` for 1 clock).
- The pulse is held high for just **1 clock cycle**, determined by a `pulse_timer`.
- If `start` goes low anytime, the counter resets immediately.
- `rst` (active-high) resets all logic and output signals.

---

## 🔗 Port Summary

| Signal     | Direction | Description                                     |
|------------|-----------|-------------------------------------------------|
| `clk`      | Input     | System clock                                    |
| `rst`      | Input     | Active-high asynchronous reset                  |
| `start`    | Input     | Enable/trigger signal to begin counting         |
| `pulse`    | Output    | 1-clock-cycle wide pulse every 10 `start` clocks|

---

## 🧮 Behavior Summary

| Clock Edge | `start` | `count` | `pulse` |
|------------|---------|---------|---------|
| ✔️         | 1       | 0..8    | 0       |
| ✔️         | 1       | 9       | 1       |
| ✔️         | 1       | reset   | 0       |
| ✔️         | 0       | reset   | 0       |
| ✔️         | x       | x       | 0 (on `rst`) |

> ⏱️ The `pulse_timer` ensures `pulse` is high for only **one clock cycle** (short pulse).

---

## 🧪 Testbench Suggestion

```verilog
initial begin
  clk = 0;
  rst = 1;
  start = 0;
  #20 rst = 0;

  // Start for 10 cycles
  start = 1;
  #100;

  // Stop start
  start = 0;
  #20;

  // Restart again
  start = 1;
end


💡 Applications
Edge-triggered pulse generators

FSM timing triggers

Sampling clocks

Handshaking protocols



👤 Author
K Sree Sai Venkat
Digital Design & FPGA Developer
