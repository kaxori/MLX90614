// Copyright (C) 2023 kaxori.
// Use of this source code is governed by an MIT-style license
// that can be found in the LICENSE file.

/**
Simple device driver for MLX90614.

The MLX90614 is a I2C IR temperature sensor.
*/


import serial.device as serial
import serial.registers as serial


class Mlx90614:
  static I2C_ADDRESS ::= 0x5a
  static I2C_ADDRESS_ALT ::= 0x5a

  static REGISTER_TA_ ::= 0x06      // ambient temperature
  static REGISTER_TOBJ1_ ::= 0x07   // object temperature
  //static REGISTER_TOBJ2_ ::= 0x08

  registers_ /serial.Registers ::= ?

  constructor device_/serial.Device:
    registers_ = device_.registers

  readObjectTemperature -> float:
    return readTemperature_ REGISTER_TOBJ1_ 

  readAmbientTemperature -> float:
    return readTemperature_ REGISTER_TA_


  read_register_ register -> int:
    return registers_.read_u16_le register

/*
  write_register_ register value:
    registers_.write_u16_le register value
*/

  readTemperature_ register/int -> float:
    temp /float := (read_register_ register).to_float
    temp *= 0.02
    temp -= 273.15
    return temp