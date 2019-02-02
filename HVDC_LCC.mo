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
          import Modelica.Constants.pi;
          import Modelica.ComplexMath.j;
          import Modelica.ComplexMath.exp;
          parameter Real turnRatio = 1 "Nominal turn-ratio of the internal transformer";
          parameter Real nTap = 1 "Tap position of the internal transformer";
          parameter Real phaseShift = 0 "Transformer phase-shift";
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin primaryPin annotation(Placement(visible = true, transformation(origin = {-98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin secondaryPin annotation(Placement(visible = true, transformation(origin = {98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        protected
          parameter Real phaseShiftRadian(fixed = false);
        initial equation
          phaseShiftRadian = phaseShift / 180 * pi;
        equation
          secondaryPin.vr + j * secondaryPin.vi = (primaryPin.vr + j * primaryPin.vi) * exp(j * phaseShiftRadian) * turnRatio * nTap;
          primaryPin.ir + j * primaryPin.ii = -(secondaryPin.ir + j * secondaryPin.ii) * exp(-j * phaseShiftRadian) * turnRatio * nTap annotation();
          annotation(Icon(graphics = {Ellipse(origin = {46, -26}, lineThickness = 1, extent = {{-84, 86}, {34, -34}}, endAngle = 360), Line(origin = {-75, 0}, points = {{-5, 0}, {-23, 0}}, thickness = 1), Line(origin = {74.7901, -0.389805}, points = {{23, 0}, {5, 0}}, thickness = 1), Text(origin = {-30, -83}, extent = {{-44, 21}, {18, -9}}, textString = "Primary"), Text(origin = {32, -69}, extent = {{-18, 9}, {52, -25}}, textString = "Secondary"), Ellipse(origin = {4, -26}, lineThickness = 1, extent = {{-84, 86}, {34, -34}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
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
          annotation(Icon(graphics = {Line(origin = {-3, 0.13}, points = {{-97, -0.129947}, {-49, -0.129947}, {-37, 19.8701}, {-17, -20.1299}, {3, 19.8701}, {23, -20.1299}, {43, 19.8701}, {55, -0.129947}, {97, -0.129947}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Resistor;

        model Reactor
          extends PartialModels.TwoPin;
          import Modelica.ComplexMath.j;
          parameter Real XL = 1 "Reactance, ohm";
        equation
          positivePin.vr + j * positivePin.vi - (negativePin.vr + j * negativePin.vi) = j * XL * (positivePin.ir + j * positivePin.ii);
          annotation(Icon(graphics = {Line(origin = {-2.22, -0.04}, points = {{-97.259, 0.35146}, {-45.2594, 0.35146}, {-43.2594, 10.3515}, {-37.2594, 16.3515}, {-27.2594, 18.3515}, {-17.2594, 14.3515}, {-13.2594, 10.3515}, {-9.25937, 0.35146}, {-9.2594, -9.6485}, {-15.2594, -17.6485}, {-21.2594, -19.6485}, {-25.2594, -17.6485}, {-29.2594, -9.64854}, {-29.2594, -3.64854}, {-27.2594, 6.35146}, {-23.2594, 12.3515}, {-11.2594, 18.3515}, {0.74063, 18.3515}, {12.7406, 12.3515}, {18.7406, -1.64854}, {16.7406, -13.6485}, {8.74063, -19.6485}, {0.74063, -15.6485}, {-1.25937, -3.64854}, {0.74063, 6.35146}, {6.7406, 14.3515}, {20.7406, 18.3515}, {30.7406, 16.3515}, {38.7406, 6.35146}, {42.7406, -5.64854}, {38.7406, -15.6485}, {32.7406, -19.6485}, {24.7406, -13.6485}, {22.7406, 0.35146}, {28.7406, 10.3515}, {42.7406, 18.3515}, {50.7406, 12.3515}, {54.7406, 0.35146}, {94.7406, 0.35146}, {98.7406, 0.35146}}, thickness = 1), Line(origin = {-54, 0}, points = {{0, 0}})}));
        end Reactor;

        model Capacitor
          extends PartialModels.TwoPin;
          import Modelica.ComplexMath.j;
          parameter Real XC = 1 "Capacitance, ohm";
        equation
          positivePin.vr + j * positivePin.vi - (negativePin.vr + j * negativePin.vi) = -j * (positivePin.ir + j * positivePin.ii) * XC;
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
            positivePin.ir + negativePin.ir = 0;
            positivePin.ii + negativePin.ii = 0;
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
          annotation(Icon(graphics = {Ellipse(origin = {63, -62}, lineThickness = 1, extent = {{-163, 162}, {37, -38}}, endAngle = 360), Line(origin = {-3.28874, -0.745477}, points = {{-77.2302, -12.3127}, {-65.2302, 3.68729}, {-49.2302, 11.6873}, {-33.2302, 13.6873}, {-15.2302, 11.6873}, {-3.23019, 3.68729}, {10.7698, -10.3127}, {28.7698, -16.3127}, {52.7698, -14.3127}, {66.7698, -4.31271}, {74.7698, 11.6873}, {74.7698, 11.6873}}, thickness = 2)}, coordinateSystem(initialScale = 0.1)));
        end VoltageSource;

        package PartialModels
          partial model TwoPin
            PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          equation
            positivePin.i + negativePin.i = 0;
            annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Text(extent = {{-36, 68}, {36, 32}}, lineColor = {28, 108, 200}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false)));
          end TwoPin;
        end PartialModels;

        model Resistor
          extends PartialModels.TwoPin;
          parameter Real R = 1 "Resistance, ohm";
        equation
          positivePin.v - negativePin.v = R * positivePin.i;
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
          annotation(Icon(graphics = {Line(origin = {-2.22, -0.04}, points = {{-97.259, 0.35146}, {-45.2594, 0.35146}, {-43.2594, 10.3515}, {-37.2594, 16.3515}, {-27.2594, 18.3515}, {-17.2594, 14.3515}, {-13.2594, 10.3515}, {-9.25937, 0.35146}, {-9.2594, -9.6485}, {-15.2594, -17.6485}, {-21.2594, -19.6485}, {-25.2594, -17.6485}, {-29.2594, -9.64854}, {-29.2594, -3.64854}, {-27.2594, 6.35146}, {-23.2594, 12.3515}, {-11.2594, 18.3515}, {0.74063, 18.3515}, {12.7406, 12.3515}, {18.7406, -1.64854}, {16.7406, -13.6485}, {8.74063, -19.6485}, {0.74063, -15.6485}, {-1.25937, -3.64854}, {0.74063, 6.35146}, {6.7406, 14.3515}, {20.7406, 18.3515}, {30.7406, 16.3515}, {38.7406, 6.35146}, {42.7406, -5.64854}, {38.7406, -15.6485}, {32.7406, -19.6485}, {24.7406, -13.6485}, {22.7406, 0.35146}, {28.7406, 10.3515}, {42.7406, 18.3515}, {50.7406, 12.3515}, {54.7406, 0.35146}, {94.7406, 0.35146}, {98.7406, 0.35146}}, thickness = 1), Line(origin = {-54, 0}, points = {{0, 0}})}));
        end Capacitor;

        model asdf
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pin annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.v = 0;
          annotation(Icon(graphics = {Line(origin = {0, -25.03}, points = {{0, 20}, {0, -16}}, thickness = 1), Line(origin = {0.24, -40.85}, rotation = 90, points = {{0, 100}, {0, -100}}, thickness = 1), Line(origin = {1.11, -60.13}, rotation = 90, points = {{0, 62}, {0, -58}}, thickness = 1), Line(origin = {0.79, -80.84}, rotation = 90, points = {{0, 20}, {0, -20}}, thickness = 1), Line(origin = {-1.17, -99.49}, rotation = 90, points = {{0, 6}, {0, -8}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end asdf;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end DC;
    end Electrical;

    package Control
    end Control;
  end BasicElements;
  annotation(uses(Modelica(version = "3.2.2")));
end HVDC_LCC;