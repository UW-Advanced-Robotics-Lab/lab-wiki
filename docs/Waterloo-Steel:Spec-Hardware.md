<toc>

# Table of Contents
[*Last generated: Fri  6 Jan 2023 22:35:57 EST*]
- [**Barrett WAM Specs:**](#Barrett-WAM-Specs)
  - [7DOF WAM:](#7DOF-WAM)
    - [Motors (*1):](#Motors-1)
    - [Power (*1):](#Power-1)
    - [Drive Inertias (*6)](#Drive-Inertias-6)
  - [Barrett Torque Sensor (*2):](#Barrett-Torque-Sensor-2)
  - [Barrett Hand (*3):](#Barrett-Hand-3)

---
</toc>

![waterloo-steel-v2-fov](resources/waterloo-steel-v2-fov.png)

---

# Barrett WAM Specs:
## 7DOF WAM:
### Motors (*1):
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

### Power (*1):
Status | Control | 4-DOF | 7-DOF
-- | -- | -- | --
Powered on, no torques | External | 18 W | 27 W
Active at home position | External | 30 W | 40 W
Active at worst-case** position, 4kg payload | External | 65 W | XXX
Active at worst-case** position, 3kg payload | External | XXX | 80 W
Active at worst-case** position, 3kg payload | Internal | XXX | 85 W
Active at worst-case** position with BH8-280, 2kg payload | Internal | XXX | 120 W
Peak | External | 600 W | 800 W

### Drive Inertias (*6)
Motor Drive Number | Total Drive Inertia at Rotor (kg-m2) |Drive Ratios | Total Reflected Inertia at Output (kg-m2) 
-- | -- | -- | --
M1 | 0.00011631 |42.00 |0.205190
M2 | 0.00011831 |28.25 |0.094428 
M3 | 0.00011831 |28.25 |0.094428 
M4 | 0.00010686 |18.00 |0.034628 
M5 | 0.00001685 |9.48  |0.001584 
M6 | 0.00001745 |9.48  |0.001641 
M7 | 0.00000142 |14.93 |0.000318


## Barrett Torque Sensor (*2):
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

## Barrett Hand (*3):
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



<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>