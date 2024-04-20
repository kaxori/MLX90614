// Copyright (C) 2023 kaxori.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import gpio
import i2c
import ..src.mlx90614 show *

main:
  print "\n\n\n\ntest MLX90614 "
  bus := i2c.Bus --sda=(gpio.Pin 21) --scl=(gpio.Pin 22) --frequency=100_000
  device := bus.device Mlx90614.I2C_ADDRESS
  mlx90614 := Mlx90614 device

  while true:
    obj-temp := 0.0
    amb-temp := 0.0
    try: 
      e := catch:
        obj-temp = mlx90614.readObjectTemperature
        amb-temp = mlx90614.readAmbientTemperature
       
      if not e:
        print "Tobj: $(%3.1f obj-temp) - Tamb: $(%3.1f amb-temp) Tdiff => $(%3.1f obj-temp - amb-temp)"
      else:
        print "- no data"
    finally:
      sleep --ms=2000