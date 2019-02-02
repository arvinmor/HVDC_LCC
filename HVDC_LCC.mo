package HVDC_LCC
  package BasicElements
    package Electrical
      package Phasor
        connector PowerPin "Connector for electrical blocks treating voltage and current as complex variables"
          Real vr "Real part of the voltage";
          Real vi "Imaginary part of the voltage";
          flow Real ir "Real part of the current";
          flow Real ii "Imaginary part of the current";
          annotation(Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}), Diagram(graphics = {Text(extent = {{-100, 160}, {100, 120}}, lineColor = {0, 0, 255}, textString = "%name"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}), Documentation);
        end PowerPin;

        model Bus
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(positivePin, negativePin) annotation(Line(points = {{-100, 0}, {96, 0}, {96, 0}, {100, 0}}, color = {0, 0, 255}));
          annotation(Diagram, Icon(graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-20, 100}, {20, -100}}), Text(extent = {{26, 106}, {92, 72}}, lineColor = {28, 108, 200}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
        end Bus;

        model Transformer2W_Ideal
          extends PartialModels.TwoPin;
          import Modelica.Constants.pi;
          import Modelica.ComplexMath.j;
          import Modelica.ComplexMath.exp;
          parameter Real turnRatio = 1 "Nominal turn-ratio of the internal transformer";
          parameter Real nTap = 1 "Tap position of the internal transformer";
          parameter Real phaseShift = 0 "Transformer phase-shift";
        protected
          parameter Real phaseShiftRadian(fixed = false);
        initial equation
          phaseShiftRadian = phaseShift / 180 * pi;
        equation
          negativePin.vr + j * negativePin.vi = (positivePin.vr + j * positivePin.vi) * exp(j * phaseShiftRadian) * turnRatio * nTap;
          positivePin.ir + j * positivePin.ii = -(negativePin.ir + j * negativePin.ii) * exp(-j * phaseShiftRadian) * turnRatio * nTap annotation();
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Line(origin = {-75, 0}, points = {{12.0732, 0.271003}, {-23, 0}}, thickness = 1), Line(origin = {74.7901, -0.389805}, points = {{23, 0}, {-9.90515, 0}}, thickness = 1), Ellipse(origin = {-20.6612, -7.02981}, lineThickness = 1, extent = {{-41.4526, 46.1626}, {34, -34}}, endAngle = 360), Ellipse(origin = {29.4201, -7.89702}, lineThickness = 1, extent = {{-41.4526, 46.1626}, {34, -34}}, endAngle = 360)}));
        end Transformer2W_Ideal;

        model VoltageSource
          import Modelica.Constants.pi;
          parameter Real Vmag = 1 "Voltage magnitude (Volt)";
          parameter Real Vang = 10 "Voltage angle (degree)";
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin pin annotation(Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.vr = Vmag * cos(Vang / 180 * pi);
          pin.vi = Vmag * sin(Vang / 180 * pi);
          annotation(Icon(graphics = {Ellipse(origin = {63, -62}, lineThickness = 1, extent = {{-163, 162}, {37, -38}}, endAngle = 360), Line(origin = {-3.28874, -0.745477}, points = {{-77.2302, -12.3127}, {-65.2302, 3.68729}, {-49.2302, 11.6873}, {-33.2302, 13.6873}, {-15.2302, 11.6873}, {-3.23019, 3.68729}, {10.7698, -10.3127}, {28.7698, -16.3127}, {52.7698, -14.3127}, {66.7698, -4.31271}, {74.7698, 11.6873}, {74.7698, 11.6873}}, thickness = 2)}, coordinateSystem(initialScale = 0.1)));
        end VoltageSource;

        model Resistor
          extends PartialModels.TwoPin;
          import Modelica.ComplexMath.j;
          parameter Real R = 1 "Resistance, ohm";
        equation
          positivePin.vr + j * positivePin.vi - (negativePin.vr + j * negativePin.vi) = R * (positivePin.ir + j * positivePin.ii);
          positivePin.ir + negativePin.ir = 0;
          positivePin.ii + negativePin.ii = 0;
          annotation(Icon(graphics = {Line(origin = {-3, 0.13}, points = {{-97, -0.129947}, {-49, -0.129947}, {-37, 19.8701}, {-17, -20.1299}, {3, 19.8701}, {23, -20.1299}, {43, 19.8701}, {55, -0.129947}, {97, -0.129947}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Resistor;

        model Reactor
          extends PartialModels.TwoPin;
          import Modelica.ComplexMath.j;
          parameter Real XL = 1 "Reactance, ohm";
        equation
          positivePin.vr + j * positivePin.vi - (negativePin.vr + j * negativePin.vi) = j * XL * (positivePin.ir + j * positivePin.ii);
          positivePin.ir + negativePin.ir = 0;
          positivePin.ii + negativePin.ii = 0;
          annotation(Icon(graphics = {Line(origin = {-2.22, -0.04}, points = {{-97.259, 0.35146}, {-45.2594, 0.35146}, {-43.2594, 10.3515}, {-37.2594, 16.3515}, {-27.2594, 18.3515}, {-17.2594, 14.3515}, {-13.2594, 10.3515}, {-9.25937, 0.35146}, {-9.2594, -9.6485}, {-15.2594, -17.6485}, {-21.2594, -19.6485}, {-25.2594, -17.6485}, {-29.2594, -9.64854}, {-29.2594, -3.64854}, {-27.2594, 6.35146}, {-23.2594, 12.3515}, {-11.2594, 18.3515}, {0.74063, 18.3515}, {12.7406, 12.3515}, {18.7406, -1.64854}, {16.7406, -13.6485}, {8.74063, -19.6485}, {0.74063, -15.6485}, {-1.25937, -3.64854}, {0.74063, 6.35146}, {6.7406, 14.3515}, {20.7406, 18.3515}, {30.7406, 16.3515}, {38.7406, 6.35146}, {42.7406, -5.64854}, {38.7406, -15.6485}, {32.7406, -19.6485}, {24.7406, -13.6485}, {22.7406, 0.35146}, {28.7406, 10.3515}, {42.7406, 18.3515}, {50.7406, 12.3515}, {54.7406, 0.35146}, {94.7406, 0.35146}, {98.7406, 0.35146}}, thickness = 1), Line(origin = {-54, 0}, points = {{0, 0}})}));
        end Reactor;

        model Capacitor
          extends PartialModels.TwoPin;
          import Modelica.ComplexMath.j;
          parameter Real XC = 1 "Capacitance, ohm";
        equation
          positivePin.vr + j * positivePin.vi - (negativePin.vr + j * negativePin.vi) = -j * (positivePin.ir + j * positivePin.ii) * XC;
          positivePin.ir + negativePin.ir = 0;
          positivePin.ii + negativePin.ii = 0;
          annotation(Icon(graphics = {Line(origin = {-6, 0}, points = {{0, 30}, {0, -30}, {0, -30}}, thickness = 1), Line(origin = {10.21, 1}, points = {{5.79289, 29}, {-0.207107, 23}, {-4.20711, 13}, {-6.20711, 5}, {-6.20711, -7}, {-2.20711, -19}, {1.79289, -25}, {5.79289, -29}}, thickness = 1), Line(origin = {-51, 0}, points = {{45, 0}, {-45, 0}}, thickness = 1), Line(origin = {49.3598, 0.23988}, points = {{45, 0}, {-45, 0}}, thickness = 1)}));
        end Capacitor;

        model Ground
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin pin annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.vr = 0;
          pin.vi = 0;
          annotation(Icon(graphics = {Line(origin = {0, -25.03}, points = {{0, 20}, {0, -16}}, thickness = 1), Line(origin = {0.24, -40.85}, rotation = 90, points = {{0, 100}, {0, -100}}, thickness = 1), Line(origin = {1.11, -60.13}, rotation = 90, points = {{0, 62}, {0, -58}}, thickness = 1), Line(origin = {0.79, -80.84}, rotation = 90, points = {{0, 20}, {0, -20}}, thickness = 1), Line(origin = {-1.17, -99.49}, rotation = 90, points = {{0, 6}, {0, -8}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Ground;

        package PartialModels
          partial model TwoPin
            PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          equation

            annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Text(extent = {{-36, 68}, {36, 32}}, lineColor = {28, 108, 200}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false)));
          end TwoPin;
        end PartialModels;
      end Phasor;

      package DC
        connector PowerPin "DC PowerPin connector"
          Real v "DC Voltage";
          flow Real i "DC Current";
          annotation(Diagram(graphics = {Text(extent = {{-100, 160}, {100, 120}}, lineColor = {0, 0, 255}, textString = "%name"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}), Documentation, Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
        end PowerPin;

        model Bus
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(positivePin, negativePin) annotation(Line(points = {{-100, 0}, {96, 0}, {96, 0}, {100, 0}}, color = {0, 0, 255}));
          annotation(Diagram, Icon(graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-20, 100}, {20, -100}}), Text(extent = {{26, 106}, {92, 72}}, lineColor = {28, 108, 200}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
        end Bus;

        model VoltageSource
          parameter Real Vmag = 1 "Voltage magnitude (Volt)";
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pin annotation(Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.v = Vmag;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {63, -62}, lineThickness = 1, extent = {{-163, 162}, {37, -38}}, endAngle = 360), Text(origin = {61.387, -7.179}, extent = {{-29.6701, 42.4142}, {24.25, -22.36}}, textString = "+"), Ellipse(origin = {-66.7432, -8.26599}, fillPattern = FillPattern.Solid, extent = {{-19.38, 19.11}, {6.37, -5.28}}, endAngle = 360), Text(origin = {-30.7572, -11.84}, extent = {{-29.67, 42.41}, {-0.411247, -16.6689}}, textString = "-"), Line(origin = {-73.3102, -19.776}, points = {{0.140379, 14.6293}, {0.140379, -13.013}}, thickness = 1), Line(origin = {-60.8983, -19.8302}, points = {{-25.8759, -13.013}, {0.140379, -13.013}}, thickness = 1), Line(origin = {-60.6815, -25.5754}, points = {{-19.6428, -13.013}, {-6.09268, -13.013}}, thickness = 1), Line(origin = {-64.2045, -31.0497}, points = {{-12.0547, -13.013}, {-6.09268, -13.013}}, thickness = 1)}));
        end VoltageSource;

        model Resistor
          extends PartialModels.TwoPin;
          parameter Real R = 1 "Resistance, ohm";
        equation
          positivePin.v - negativePin.v = R * positivePin.i;
          positivePin.i + negativePin.i = 0;
          annotation(Icon(graphics = {Line(origin = {-3, 0.13}, points = {{-97, -0.129947}, {-49, -0.129947}, {-37, 19.8701}, {-17, -20.1299}, {3, 19.8701}, {23, -20.1299}, {43, 19.8701}, {55, -0.129947}, {97, -0.129947}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Resistor;

        model Inductor
          extends PartialModels.TwoPin;
          parameter Real L = 1 "Inductance, H";
          Real i;
        initial equation
          der(i) = 0;
        equation
          i = positivePin.i;
          positivePin.v - negativePin.v = L * der(i);
          positivePin.i + negativePin.i = 0;
          annotation(Icon(graphics = {Line(origin = {-2.22, -0.04}, points = {{-97.259, 0.35146}, {-45.2594, 0.35146}, {-43.2594, 10.3515}, {-37.2594, 16.3515}, {-27.2594, 18.3515}, {-17.2594, 14.3515}, {-13.2594, 10.3515}, {-9.25937, 0.35146}, {-9.2594, -9.6485}, {-15.2594, -17.6485}, {-21.2594, -19.6485}, {-25.2594, -17.6485}, {-29.2594, -9.64854}, {-29.2594, -3.64854}, {-27.2594, 6.35146}, {-23.2594, 12.3515}, {-11.2594, 18.3515}, {0.74063, 18.3515}, {12.7406, 12.3515}, {18.7406, -1.64854}, {16.7406, -13.6485}, {8.74063, -19.6485}, {0.74063, -15.6485}, {-1.25937, -3.64854}, {0.74063, 6.35146}, {6.7406, 14.3515}, {20.7406, 18.3515}, {30.7406, 16.3515}, {38.7406, 6.35146}, {42.7406, -5.64854}, {38.7406, -15.6485}, {32.7406, -19.6485}, {24.7406, -13.6485}, {22.7406, 0.35146}, {28.7406, 10.3515}, {42.7406, 18.3515}, {50.7406, 12.3515}, {54.7406, 0.35146}, {94.7406, 0.35146}, {98.7406, 0.35146}}, thickness = 1), Line(origin = {-54, 0}, points = {{0, 0}})}));
        end Inductor;

        model Capacitor
          extends PartialModels.TwoPin;
          parameter Real C = 1 "Capacitance, F";
          Real v;
        initial equation
          der(v) = 0;
        equation
          positivePin.i + negativePin.i = 0;
          positivePin.i = C * der(v);
          positivePin.v - negativePin.v = v;
          annotation(Icon(graphics = {Line(origin = {-6, 0}, points = {{0, 30}, {0, -30}, {0, -30}}, thickness = 1), Line(origin = {10.21, 1}, points = {{5.79289, 29}, {-0.207107, 23}, {-4.20711, 13}, {-6.20711, 5}, {-6.20711, -7}, {-2.20711, -19}, {1.79289, -25}, {5.79289, -29}}, thickness = 1), Line(origin = {-51, 0}, points = {{45, 0}, {-45, 0}}, thickness = 1), Line(origin = {49.3598, 0.23988}, points = {{45, 0}, {-45, 0}}, thickness = 1)}));
        end Capacitor;

        model Ground
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pin annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.v = 0;
          annotation(Icon(graphics = {Line(origin = {0, -25.03}, points = {{0, 20}, {0, -16}}, thickness = 1), Line(origin = {0.24, -40.85}, rotation = 90, points = {{0, 100}, {0, -100}}, thickness = 1), Line(origin = {1.11, -60.13}, rotation = 90, points = {{0, 62}, {0, -58}}, thickness = 1), Line(origin = {0.79, -80.84}, rotation = 90, points = {{0, 20}, {0, -20}}, thickness = 1), Line(origin = {-1.17, -99.49}, rotation = 90, points = {{0, 6}, {0, -8}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Ground;

        package PartialModels
          partial model TwoPin
            PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Text(extent = {{-36, 68}, {36, 32}}, lineColor = {28, 108, 200}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false)));
          end TwoPin;
        end PartialModels;

        model Switch
          extends PartialModels.TwoPin;
          Modelica.Blocks.Interfaces.BooleanInput status annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        equation
          if status then
            positivePin.i + negativePin.i = 0;
            positivePin.v = negativePin.v;
          else
            positivePin.i = 0;
            negativePin.i = 0;
          end if;
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1}), graphics = {Ellipse(origin = {-52.3021, -0.271003}, fillPattern = FillPattern.Solid, extent = {{-7.86, 7.86}, {7.86, -7.86}}, endAngle = 360), Ellipse(origin = {53.0637, 1.30081}, fillPattern = FillPattern.Solid, extent = {{-7.86, 7.86}, {7.86, -7.86}}, endAngle = 360), Line(origin = {-25.08, 29.48}, points = {{-74.3793, -28.9334}, {-31.0189, -28.9334}, {78.1952, 7.10999}}, thickness = 1), Line(origin = {127.982, 29.6968}, points = {{-74.3793, -28.9334}, {-31.0189, -28.9334}}, thickness = 1), Line(origin = {-51.084, 45.9303}, points = {{50.813, -13.1436}, {51.084, -129.404}}, thickness = 1, arrow = {Arrow.Filled, Arrow.None})}));
        end Switch;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end DC;

      package AC2DC
        model Converter "Converter model including commutation impedance"
          import Modelica.ComplexMath.conj;
          import Modelica.ComplexMath.real;
          import Modelica.ComplexMath.imag;
          import Modelica.ComplexMath.j;
          import Modelica.Constants.pi;
          parameter Real Rc = 1 "Commutation Resistance, ohm";
          parameter Real Xc = 1 "Commutation Reactance, ohm";
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin pinAC annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pinDCp annotation(Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pinDCn annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput alpha "Delay angle (firing angle)" annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Complex Sac;
          Real Pac, Qac;
          Real Eac;
          Real Pdc;
          Real Vdc;
          Real Idc;
          Real phi "AC power factor";
          Real delta "Extintion angle";
          Real u "Commutation anlge (overlapping angle)";
        equation
          Vdc = pinDCp.v - pinDCn.v;
          Idc = pinDCp.i;
          Eac = sqrt(pinAC.vr ^ 2 + pinAC.vi ^ 2);
          pinDCp.i + pinDCn.i = 0;
          Sac = (pinAC.vr + j * pinAC.vi) * conj(pinAC.ir + j * pinAC.ii);
          Pac = real(Sac);
          Qac = imag(Sac);
          Pdc = Vdc * Idc;
          Pac = Pdc + 2 * Idc ^ 2 * Rc;
          Qac = real(Sac) * tan(phi);
          delta = alpha + u;
          tan(phi) = (2 * u + sin(2 * alpha) - sin(2 * delta)) / (cos(2 * alpha) - cos(2 * delta));
          cos(delta) = cos(alpha) - sqrt(2) * Idc * Xc / Eac;
          Vdc = 3 * sqrt(2) / pi * Eac * cos(alpha) - 3 * Xc / pi * Idc - 2 * Rc * Idc;
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {0.94, 1.26}, lineThickness = 1, points = {{-1.75498, 51.5836}, {64.6407, -51.1265}, {-64.6276, -51.1265}, {-1.75498, 51.5836}}), Line(origin = {0.75, 51.96}, points = {{-62.5348, 1.15271}, {63.4814, 1.42372}}, thickness = 1), Line(origin = {21.5088, 70.876}, points = {{-22.4264, 23.6459}, {-22.4264, -18.6305}}, thickness = 1), Line(origin = {21.4546, -73.8937}, points = {{-22.4264, 23.6459}, {-22.4264, -18.6305}}, thickness = 1), Line(origin = {-76.9736, -21.3733}, rotation = -90, points = {{-22.4264, 44.2421}, {-22.4264, -18.6305}}, thickness = 1), Line(origin = {51.6985, -22.5115}, rotation = -90, points = {{-22.4264, 44.2421}, {-22.4264, -18.6305}}, thickness = 1)}));
        end Converter;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end AC2DC;
    end Electrical;

    package Control
    end Control;
  end BasicElements;
  annotation(uses(Modelica(version = "3.2.2")));
end HVDC_LCC;