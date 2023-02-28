<toc>

# Table of Contents
[*Last generated: Tue 28 Feb 2023 17:10:34 EST*]
- [**1. Barrett WAM Specs:**](#1-Barrett-WAM-Specs)
  - [1.1 7DOF WAM:](#11-7DOF-WAM)
    - [1.1.1 Motors (*1):](#111-Motors-1)
    - [1.1.2 Power (*1):](#112-Power-1)
    - [1.1.3 Drive Inertias (*6)](#113-Drive-Inertias-6)
  - [1.2 Barrett Torque Sensor (*2):](#12-Barrett-Torque-Sensor-2)
  - [1.3 Barrett Hand (*3):](#13-Barrett-Hand-3)
- [**2. Power Table**](#2-Power-Table)
  - [2.1 Battery Status](#21-Battery-Status)
    - [2.1.1 LiFePo (40152S 15Ah) [Original Robotnik]](#211-LiFePo-40152S-15Ah-Original-Robotnik)
    - [2.1.2 LiPo (18650) [Candidate]](#212-LiPo-18650-Candidate)
    - [2.1.3 Original Charger for Lithium Battery](#213-Original-Charger-for-Lithium-Battery)
  - [2.2 WAM Voltage](#22-WAM-Voltage)
    - [2.2.1 WAM Voltage Safty Module](#221-WAM-Voltage-Safty-Module)
  - [2.3 Other Components Voltage Ranges:](#23-Other-Components-Voltage-Ranges)

---
</toc>

![waterloo-steel-v2-fov](resources/waterloo-steel-v2-fov.png)

---

# 1. Barrett WAM Specs:
## 1.1 7DOF WAM:
### 1.1.1 Motors (*1):
|      | 1-4  | 5-6  | 7    | BHand | Units |
| ---- | ---- | ---- | ---- | ----- | ----- |
| Design Voltage | 48 | 48 | 48 | 19.8 | V |
| Back EMF | 0.457 | 0.236 | 0.067 | 0.0177 | V/rad/sec |
| No Load Speed | 100.218 | 192.309 | 569.022 | 1070 | rad/s|
| Max Continuous Torque | 1.490 | 0.356 | 0.091 | 0.0367 | Nm |
| Torque Constant | 0.457 | 0.236 | 0.067 | 0.0177 | Nm/A |
| Inductance | 4.068 | 3.918 | 2.035 | 1.14 | mH |
| Resistance | 3.473 | 6.213 | 5.205 | 4.95 | Ohms |
| Rotor Inertia | 9.293E-5 | 1.472E-5 | 1.349E-6 | 1.41E-7 | kg*m2 |
| Viscous Friction | 7.549E-5 | 8.899E-6 | 1.259E-6 | 0.674E-3 | Nm/rpm |

### 1.1.2 Power (*1):
Status | Control | 4-DOF | 7-DOF
-- | -- | -- | --
Powered on, no torques | External | 18 W | 27 W
Active at home position | External | 30 W | 40 W
Active at worst-case** position, 4kg payload | External | 65 W | XXX
Active at worst-case** position, 3kg payload | External | XXX | 80 W
Active at worst-case** position, 3kg payload | Internal | XXX | 85 W
Active at worst-case** position with BH8-280, 2kg payload | Internal | XXX | 120 W
Peak | External | 600 W | 800 W

### 1.1.3 Drive Inertias (*6)
Motor Drive Number | Total Drive Inertia at Rotor (kg-m2) |Drive Ratios | Total Reflected Inertia at Output (kg-m2) 
-- | -- | -- | --
M1 | 0.00011631 |42.00 |0.205190
M2 | 0.00011831 |28.25 |0.094428 
M3 | 0.00011831 |28.25 |0.094428 
M4 | 0.00010686 |18.00 |0.034628 
M5 | 0.00001685 |9.48  |0.001584 
M6 | 0.00001745 |9.48  |0.001641 
M7 | 0.00000142 |14.93 |0.000318


## 1.2 Barrett Torque Sensor (*2):
| Property | Value |
| --- | --- |
| Total Mass | 136 g |
| Dimensions | Diameter | 90 mm |
| | Height | 12 mm |
| Sensing Range | Fx, Fy : ‡ 80 N |
| | Fz     : ‡ 135 N |
| | Tx, Ty : ‡ 2.75 N-m |
| | Tz     : ‡ 2.75 N-m |
| Sensing Resolution | Fx, Fy : 50 mN |
| | Fz     : 80 mN |
| | Tx, Ty : 1.5 mN-m |
| | Tz     : 1.5 mN-m |
| Single-Axis Overload | Fx, Fy : 3000 N |
| | Fz     : 3600 N |
| | Tx, Ty : 60 N-m |
| | Tz     : 100 N-m |
| Power | 48 V  1.7 W |
| Characteristics | Output: 12 bits |
| | Noise: 2 bits (without filtering) |
| | Rate: 2.5 kHz max |
| | Hysteresis: <5% |

## 1.3 Barrett Hand (*3):
| Property | Value |
| --- | --- |
| Kinematics | Total fingers: 3 |
| | Fingers which spread: 2 |
| | Joints per finger: 2 |
| | Motors per finger: 1 |
| | Axes of palm spread motion: 2 |
| | Motors for palm spread motion: 1 |
| | Total hand axes: 8 |
| | Total hand motors: 4 |
| Range of Motion | Finger base joint: 140° |
| | Fingertip: 45° |
| | Finger spread: 180° |
| Speed | Finger fully open to fully closed:1.0 sec |
| | Full 180° finger spread: 0.5 sec |
| Sensing Resolution | 12-bit absolute sensing at each motor with array of Hall sensors |
| Force | Weight Hand: 980 grams |
| | Payload 6.0 kg |
| | Finger Forces (at tip) Active: 15 N |
| | Passive: 20 N |
| Properties | - Rare-Earth brushless-DC servo motors |
| | - Worm drives integrated with proprietary |
| | cable drive and breakaway clutch |
| | DC Operation 20-80 VDC |
| | 5/12/250 W idle/typ/max |
| | AC Operation single-phase, 85-260 VAC, 50/60 Hz |
| | 10/20/300 W idle/typ/max |
| | Single Cable to Hand 5mx5mm flexible cable |
| | Dimensions: See Diagram (base is only 25mm tall) |
| Video: | [https://www.youtube.com/watch?v=aDvykgDyEg8](https://www.youtube.com/watch?v=aDvykgDyEg8) |

---
*1. [ref: motor power](https://support.barrett.com/wiki/WAM/Specifications%3AMotorsMaterialsPower)

*2. [ref: TS sensor](https://web.barrett.com/files/Low-Profile_Force-Torque_Sensor_FT-02-2011.pdf)

*3. [ref: BHand Spec](https://support.barrett.com/wiki/Hand/280/KinematicsJointRangesConversionFactors)

*4. Spec: [WAM_UsersGuide_AE-00.pdf](http://www.me.unm.edu/~starr/research/WAM_UsersGuide_AE-00.pdf)

*5. Review Paper Ref: [328784157_Light_Weight_Robot_Arms-An_overview#pf3](https://www.researchgate.net/publication/328784157_Light_Weight_Robot_Arms-An_overview#pf3)

*6. [WAM Inertial Spec](https://web.barrett.com/support/WAM_Documentation/WAM_InertialSpecifications_AC-02.pdf)



# 2. Power Table

## 2.1 Battery Status

### 2.1.1 LiFePo (40152S 15Ah) [Original Robotnik]

- [Ref of Chart](https://footprinthero.com/lifepo4-battery-voltage-charts)

  - ![48VLiFePo 14S](resources/battery/48VLiFePo_14S.jpg)

- [datasheet](https://www.servovision.com/Battery/Life/Life/headway%2040152S%20specifications%2015Ah.pdf) https://www.lifepo4-battery.com/Products/Cylindrical-battery-cell/Headway-40152S-15Ah.html 

  -  Lifecycle: 2000Cycles.

- | Cell      | Max Current | Const Voltage | Capacity | Temperature | Nominal Voltage | Discharge <br />(fast cont/max pulse) | Cutoff | BMS Cutoff |
  | --------- | ----------- | ------------- | -------- | ----------- | --------------- | ------------------------------------- | ------ | ---------- |
  | 1         | 2C（30A)    | 3.6~3.7 V     | 15 Ah    | -20~60 C    | 3.2 V           | 45A /150A                             | 2.0 V  | -          |
  | 16 series | 2C（30A)    | 57.6 V        | 15 Ah    | -20~60 C    | 51.2 V          | 45A /150A                             | 32 V   | ?? 48V?    |

### 2.1.2 LiPo (18650) [Candidate]

- [Ref of Discharging Chart](https://goldenmotor.com/SMF/index.php?topic=7116.0)

  - ![52VLipo 16S](resources/battery/52VLipo_16S.jpg)

- Ours:

  ![52V_battery_rosbag](resources/battery/52V_battery_rosbag.png)

- [Ref of Charging Stage Chart 18650 DigiKey](https://www.digikey.com/en/maker/blogs/charging-lithium-ion-batteries)

  - > The [18650 ](http://www.powerstream.com/p/LG-ICR18650HE2-REV0.pdf)is popular cylindrical lithium cell, with a capacity of 2500 mAh. The datasheet recommends a 1250 mA constant current charge, then 4.2 V constant voltage charge, and charge termination when the current drops to **50 mA**. The datasheet specifies a fast charge, which is 4000 mA constant current, then 4.2 V constant voltage, then cut off at 100 mA, which is a C/25 charge termination.

  - ![image of Charging Lithium Batteries](resources/battery/image-of-charging-lithium-batteries.jpg)

- | Cell       | Const Current | Const Voltage | Capacity | Temperature                             | Nominal Voltage | Discharge Continuous<br />(std/fast/max) | Cutoff | BMS Cutoff |
  | ---------- | ------------- | ------------- | -------- | --------------------------------------- | --------------- | ---------------------------------------- | ------ | ---------- |
  | 1          | 1~1.25 A      | 4.2 V         | 2.5 Ah   | 0~50 C Charging<br />-20~75 C Discharge | 3.6 V           | 0.5A / 10A / 20A                         | 2.5V   | -          |
  | 8 parallel | 8A            | -             | 20Ah     | -                                       | 3.6 V           | 4A / 80A / 160 A                         | -      | -          |
  | 14 series  | -             | 58.8 V        | -        | -                                       | 50.4 V          | -                                        | 35 V   | -          |
  | 52 V       | 8A            | 58.8 V        | 20Ah     | 0~50 C Charging<br />-20~75 C Discharge | 50.4 V          | 4A / 80A / 160 A                         | 35 V   | 42 V       |

- > :notebook: From the chart, the V_float = 54.4V would work during stage 3
  >
  > :notebook: From the table, the V_const_max = 58.8V > 57.6V Const Voltage Charging
  >
  > 📓 From the table, the I_const_max = 8A > 6.25A Boost Const Current

### 2.1.3 Original Charger for Lithium Battery 

- [Model: PB-360P-48](https://www.meanwell.com/productPdf.aspx?i=24#1)

- | Boost Charging V | Float Charging V | Capacity | Output Current | Over Volt Protection | Efficiency |
  | ---------------- | ---------------- | -------- | -------------- | -------------------- | ---------- |
  | 57.6 V           | 54.4 V           | 20~65 Ah | 6.25 A         | 59~64 V              | 87%        |

- ![charging_stages_charger_PB-360P-48](resources/battery/charging_stages_charger_PB-360P-48.png)

## 2.2 WAM Voltage

- The standard WAM system requires **an input voltage of 18-90VDC**
- **7-DOF ---> Q(no torque): 27W Typ(2kg payload): 45W Peak: 800W**
- Provided WAM Standalone Power Supply switches automatically to local voltage standards (100-120 & 200-240 VAC at 50-60Hz)
  - **Output: 10A of direct current at 48V.** 
- The safety module is configured with respect to 48V

### 2.2.1 WAM Voltage Safty Module

![wam_default_volt_safety](resources/battery/wam_default_volt_safety.jpg)

- From safety manual [WAM_UserManual_AH-00.pdf] at pg. 29/80 (4.5.2 Safety Board):

```bash
a. SET SAFE 4 (this is necessary; do not skip this step)
b. SET SAFE 5
c. FIND VBUS
d. SET SAFE 0
e. SET VOLTL1 36
f. SET VOLTL2 30
g. SET VOLTH1 54
h. SET VOLTH2 57
i. SET GRPA 1
j. SET GRPB 2
k. SET GRPC 3
l. SAVE
m. RESET
o. GET VOLTL2 (should be 30, else SET and SAVE it again)
p. GET VOLTH1 (should be 54, else SET and SAVE it again)
q. GET VOLTH2 (should be 57, else SET and SAVE it again)
r. GET GRPA (should be 1, else SET and SAVE it again)
s. GET GRPB (should be 2, else SET and SAVE it again)
t. GET GRPC (should be 3, else SET and SAVE it again)
```

## 2.3 Other Components Voltage Ranges:

| Item Category      | Model          | Voltage   | Rated            | Peak       | Link                                                        |
| ------------------ | -------------- | --------- | ---------------- | ---------- | ----------------------------------------------------------- |
| Solid State Relays | Crydom D1D60   |           |                  |            |                                                             |
| Motor Driver       | DZCANTE-040L80 | 10-80 VDC | I_continuous=20A | I_peak=40A | [datasheet](https://www.a-m-c.com/product/dzcante-040l080/) |
|                    |                |           |                  |            |                                                             |
|                    |                |           |                  |            |                                                             |
|                    |                |           |                  |            |                                                             |









<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>