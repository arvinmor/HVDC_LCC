package HVDC_LCC
  package BasicElements
    package Electrical
      package Phasor
        connector PowerPin "Connector for electrical blocks treating voltage and current as complex variables"
          Real vr "Real part of the voltage";
          Real vi "Imaginary part of the voltage";
          flow Real ir "Real part of the current";
          flow Real ii "Imaginary part of the current";
          annotation(Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
                    fillPattern =                                                                                                                    FillPattern.Solid)}), Diagram(graphics={  Text(extent = {{-100, 160}, {100, 120}}, lineColor = {0, 0, 255}, textString = "%name"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
                    fillPattern =                                                                                                                                                                                                        FillPattern.Solid)}), Documentation);
        end PowerPin;

        model Bus
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(positivePin, negativePin) annotation(Line(points = {{-100, 0}, {96, 0}, {96, 0}, {100, 0}}, color = {0, 0, 255}));
          annotation(Diagram, Icon(graphics={  Rectangle(fillPattern = FillPattern.Solid, extent = {{-20, 100}, {20, -100}}), Text(extent = {{26, 106}, {92, 72}}, lineColor = {28, 108, 200}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
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
          positivePin.ir + j * positivePin.ii = -(negativePin.ir + j * negativePin.ii) * exp(-j * phaseShiftRadian) * turnRatio * nTap annotation ();
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Line(origin = {-75, 0}, points = {{12.0732, 0.271003}, {-23, 0}}, thickness = 1), Line(origin = {74.7901, -0.389805}, points = {{23, 0}, {-9.90515, 0}}, thickness = 1), Ellipse(origin = {-20.6612, -7.02981},
                    lineThickness =                                                                                                                                                                                                        1, extent = {{-41.4526, 46.1626}, {34, -34}}, endAngle = 360), Ellipse(origin = {29.4201, -7.89702},
                    lineThickness =                                                                                                                                                                                                        1, extent = {{-41.4526, 46.1626}, {34, -34}}, endAngle = 360)}));
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
          annotation(Icon(graphics={  Line(origin = {-6, 0}, points = {{0, 30}, {0, -30}, {0, -30}}, thickness = 1), Line(origin = {10.21, 1}, points = {{5.79289, 29}, {-0.207107, 23}, {-4.20711, 13}, {-6.20711, 5}, {-6.20711, -7}, {-2.20711, -19}, {1.79289, -25}, {5.79289, -29}}, thickness = 1), Line(origin = {-51, 0}, points = {{45, 0}, {-45, 0}}, thickness = 1), Line(origin = {49.3598, 0.23988}, points = {{45, 0}, {-45, 0}}, thickness = 1)}));
        end Capacitor;

        model Ground
          HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin pin annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.vr = 0;
          pin.vi = 0;
          annotation(Icon(graphics={  Line(origin = {0, -25.03}, points = {{0, 20}, {0, -16}}, thickness = 1), Line(origin = {0.24, -40.85}, rotation = 90, points = {{0, 100}, {0, -100}}, thickness = 1), Line(origin = {1.11, -60.13}, rotation = 90, points = {{0, 62}, {0, -58}}, thickness = 1), Line(origin = {0.79, -80.84}, rotation = 90, points = {{0, 20}, {0, -20}}, thickness = 1), Line(origin = {-1.17, -99.49}, rotation = 90, points = {{0, 6}, {0, -8}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Ground;

        package PartialModels
          partial model TwoPin
            PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          equation

            annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Text(extent = {{-36, 68}, {36, 32}}, lineColor = {28, 108, 200}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false)));
          end TwoPin;
        end PartialModels;

        package Filter
          model LowFreqFilter
            parameter Real XC1 = 1;
            parameter Real XC2 = 1;
            parameter Real XL = 1;
            parameter Real RS = 1;
            parameter Real RP = 1;
            HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin pin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Capacitor capacitor1(XC = XC2) annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Capacitor capacitor2(XC = XC1) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor1(XL = XL) annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor2(R = RP) annotation(Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor1(R = RS) annotation(Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          equation
            connect(resistor2.negativePin, capacitor2.negativePin) annotation(Line(points = {{-45, 40}, {15.1762, 40}, {15.1762, 0}, {15.1762, 0}}, color = {0, 0, 255}));
            connect(resistor1.positivePin, resistor2.positivePin) annotation(Line(points = {{-135, 0}, {-135.501, 0}, {-135.501, 39.5664}, {-75.8808, 39.5664}, {-75.8808, 39.5664}}, color = {0, 0, 255}));
            connect(reactor1.positivePin, resistor1.negativePin) annotation(Line(points = {{-75, 0}, {-105.691, 0}, {-105.691, 0}, {-105.691, 0}}, color = {0, 0, 255}));
            connect(capacitor2.positivePin, reactor1.negativePin) annotation(Line(points = {{-15, 0}, {-45.7995, 0}, {-45.7995, 0.271003}, {-45.7995, 0.271003}}, color = {0, 0, 255}));
            connect(capacitor1.positivePin, capacitor2.negativePin) annotation(Line(points = {{45, 0}, {15.1762, 0}, {15.1762, 0.271003}, {15.1762, 0.271003}}, color = {0, 0, 255}));
            connect(capacitor1.negativePin, pin) annotation(Line(points = {{75, 0}, {97.29, 0}, {97.29, -0.271003}, {97.29, -0.271003}}, color = {0, 0, 255}));
            annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Line(origin = {6.70301, 2.05217}, points = {{89.0148, -3.08648}, {3.37794, -3.08648}, {3.37794, 38.1059}, {16.3861, 34.8539}, {25.8712, 26.1818}, {34.5433, 13.4447}, {36.9823, -0.10545}, {36.9823, -10.9456}, {28.0392, -24.2247}, {15.3021, -34.5228}, {2.02293, -37.2328}, {-16.1343, -30.9998}, {-29.1424, -19.6176}, {-34.2914, -10.1326}, {-35.9175, 0.978561}, {-46.2156, 0.978561}}), Rectangle(origin = {6.09756, 68.6179}, extent = {{-33.7398, 10.0271}, {33.7398, -10.0271}}), Line(origin = {55.04, 33.74}, points = {{14.6036, -34.8238}, {14.6036, 34.8238}, {-14.6647, 34.8238}}), Line(origin = {-46.345, 40.648}, points = {{17.3442, 32.5203}, {-17.3442, 32.5203}, {-17.3442, -37.1273}}), Line(origin = {-39.5664, 4.74255}, points = {{0, 37.2629}, {0, -37.2629}}), Line(origin = {-49.9187, 4.95935}, points = {{0, 37.2629}, {0, -37.2629}}), Line(origin = {-75.9892, 5.98916}, points = {{0, 37.2629}, {0, -37.2629}}), Line(origin = {-86.0705, 5.93496}, points = {{0, 37.2629}, {0, -37.2629}}), Line(origin = {-62.7371, 3.25203}, points = {{13.1436, 0}, {-13.1436, 0}}), Line(origin = {-87.1816, 3.19783}, points = {{0.948509, 0}, {-13.1436, 0}}), Line(origin = {-99.9458, 7.50678}, points = {{0, 22.0867}, {0, -26.6938}}), Text(origin = {-5.01599, -65.853}, extent = {{-38.35, 14.63}, {38.35, -14.63}}, textString = "%name")}));
          end LowFreqFilter;

          model HighFreqFilter
            parameter Real XC = 1;
            parameter Real XL = 1;
            parameter Real RS = 1;
            parameter Real RP = 1;
            HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin pin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Capacitor capacitor1(XC = XC) annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor1(R = RS) annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor2(R = RP) annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
            HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor1(XL = XL) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          equation
            connect(reactor1.negativePin, capacitor1.positivePin) annotation(Line(points = {{15, 0}, {44.4444, 0}, {44.4444, 0.271003}, {44.4444, 0.271003}}, color = {0, 0, 255}));
            connect(resistor2.negativePin, capacitor1.positivePin) annotation(Line(points = {{15, 40}, {45.2575, 40}, {45.2575, -0.813008}, {45.2575, -0.813008}}, color = {0, 0, 255}));
            connect(reactor1.positivePin, resistor1.negativePin) annotation(Line(points = {{-15, 0}, {-45.691, 0}, {-45.691, 0}, {-45.691, 0}}, color = {0, 0, 255}));
            connect(resistor1.positivePin, resistor2.positivePin) annotation(Line(points = {{-75, 0}, {-75.501, 0}, {-75.501, 39.5664}, {-15.8808, 39.5664}, {-15.8808, 39.5664}}, color = {0, 0, 255}));
            connect(capacitor1.negativePin, pin) annotation(Line(points = {{75, 0}, {97.29, 0}, {97.29, -0.271003}, {97.29, -0.271003}}, color = {0, 0, 255}));
            annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Line(origin = {6.70301, 2.05217}, points = {{89.0148, -3.08648}, {3.37794, -3.08648}, {3.37794, 38.1059}, {16.3861, 34.8539}, {25.8712, 26.1818}, {34.5433, 13.4447}, {36.9823, -0.10545}, {36.9823, -10.9456}, {28.0392, -24.2247}, {15.3021, -34.5228}, {2.02293, -37.2328}, {-16.1343, -30.9998}, {-29.1424, -19.6176}, {-34.2914, -10.1326}, {-35.9175, 0.978561}, {-72.7739, 0.978561}}), Rectangle(origin = {6.09756, 68.6179}, extent = {{-33.7398, 10.0271}, {33.7398, -10.0271}}), Line(origin = {55.04, 33.74}, points = {{14.6036, -34.8238}, {14.6036, 34.8238}, {-14.6647, 34.8238}}), Line(origin = {-44.99, 37.125}, points = {{17.3442, 32.5203}, {-2.98106, 32.5203}, {-2.98106, -33.8753}}), Line(origin = {-66.5041, 5.71816}, points = {{0, 37.2629}, {0, -37.2629}}), Line(origin = {-76.5854, 5.66396}, points = {{0, 37.2629}, {0, -37.2629}}), Line(origin = {-77.6965, 2.92683}, points = {{0.948509, 0}, {-13.1436, 0}}), Line(origin = {-90.4607, 7.23578}, points = {{0, 22.0867}, {0, -26.6938}}), Text(origin = {-5.01599, -65.853}, extent = {{-38.35, 14.63}, {38.35, -14.63}}, textString = "%name")}));
          end HighFreqFilter;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end Filter;
      end Phasor;

      package DC
        connector PowerPin "DC PowerPin connector"
          Real v "DC Voltage";
          flow Real i "DC Current";
          annotation(Diagram(graphics={  Text(extent = {{-100, 160}, {100, 120}}, lineColor = {0, 0, 255}, textString = "%name"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
                    fillPattern =                                                                                                                                                                                                        FillPattern.Solid)}), Documentation, Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Rectangle(lineColor = {255, 0, 0}, fillColor = {255, 0, 0},
                    fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
        end PowerPin;

        model Bus
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(positivePin, negativePin) annotation(Line(points = {{-100, 0}, {96, 0}, {96, 0}, {100, 0}}, color = {0, 0, 255}));
          annotation(Diagram, Icon(graphics={  Rectangle(fillPattern = FillPattern.Solid, extent = {{-20, 100}, {20, -100}}), Text(extent = {{26, 106}, {92, 72}}, lineColor = {28, 108, 200}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
        end Bus;

        model VoltageSource
          parameter Real Vmag = 1 "Voltage magnitude (Volt)";
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pin annotation(Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.v = Vmag;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Ellipse(origin = {63, -62},
                    lineThickness =                                                                                                                                                                     1, extent = {{-163, 162}, {37, -38}}, endAngle = 360), Text(origin = {61.387, -7.179}, extent = {{-29.6701, 42.4142}, {24.25, -22.36}}, textString = "+"), Ellipse(origin = {-66.7432, -8.26599},
                    fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-19.38, 19.11}, {6.37, -5.28}}, endAngle = 360), Text(origin = {-30.7572, -11.84}, extent = {{-29.67, 42.41}, {-0.411247, -16.6689}}, textString = "-"), Line(origin = {-73.3102, -19.776}, points = {{0.140379, 14.6293}, {0.140379, -13.013}}, thickness = 1), Line(origin = {-60.8983, -19.8302}, points = {{-25.8759, -13.013}, {0.140379, -13.013}}, thickness = 1), Line(origin = {-60.6815, -25.5754}, points = {{-19.6428, -13.013}, {-6.09268, -13.013}}, thickness = 1), Line(origin = {-64.2045, -31.0497}, points = {{-12.0547, -13.013}, {-6.09268, -13.013}}, thickness = 1)}));
        end VoltageSource;

        model Resistor
          extends PartialModels.TwoPin;
          parameter Real R = 1 "Resistance, ohm";
        equation
          positivePin.v - negativePin.v = R * positivePin.i;
          positivePin.i + negativePin.i = 0;
          annotation(Icon(graphics={  Line(origin = {-3, 0.13}, points = {{-97, -0.129947}, {-49, -0.129947}, {-37, 19.8701}, {-17, -20.1299}, {3, 19.8701}, {23, -20.1299}, {43, 19.8701}, {55, -0.129947}, {97, -0.129947}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
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
          annotation(Icon(graphics={  Line(origin = {-2.22, -0.04}, points = {{-97.259, 0.35146}, {-45.2594, 0.35146}, {-43.2594, 10.3515}, {-37.2594, 16.3515}, {-27.2594, 18.3515}, {-17.2594, 14.3515}, {-13.2594, 10.3515}, {-9.25937, 0.35146}, {-9.2594, -9.6485}, {-15.2594, -17.6485}, {-21.2594, -19.6485}, {-25.2594, -17.6485}, {-29.2594, -9.64854}, {-29.2594, -3.64854}, {-27.2594, 6.35146}, {-23.2594, 12.3515}, {-11.2594, 18.3515}, {0.74063, 18.3515}, {12.7406, 12.3515}, {18.7406, -1.64854}, {16.7406, -13.6485}, {8.74063, -19.6485}, {0.74063, -15.6485}, {-1.25937, -3.64854}, {0.74063, 6.35146}, {6.7406, 14.3515}, {20.7406, 18.3515}, {30.7406, 16.3515}, {38.7406, 6.35146}, {42.7406, -5.64854}, {38.7406, -15.6485}, {32.7406, -19.6485}, {24.7406, -13.6485}, {22.7406, 0.35146}, {28.7406, 10.3515}, {42.7406, 18.3515}, {50.7406, 12.3515}, {54.7406, 0.35146}, {94.7406, 0.35146}, {98.7406, 0.35146}}, thickness = 1), Line(origin = {-54, 0}, points = {{0, 0}})}));
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
          annotation(Icon(graphics={  Line(origin = {-6, 0}, points = {{0, 30}, {0, -30}, {0, -30}}, thickness = 1), Line(origin = {10.21, 1}, points = {{5.79289, 29}, {-0.207107, 23}, {-4.20711, 13}, {-6.20711, 5}, {-6.20711, -7}, {-2.20711, -19}, {1.79289, -25}, {5.79289, -29}}, thickness = 1), Line(origin = {-51, 0}, points = {{45, 0}, {-45, 0}}, thickness = 1), Line(origin = {49.3598, 0.23988}, points = {{45, 0}, {-45, 0}}, thickness = 1)}));
        end Capacitor;

        model Ground
          HVDC_LCC.BasicElements.Electrical.DC.PowerPin pin annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          pin.v = 0;
          annotation(Icon(graphics={  Line(origin = {0, -25.03}, points = {{0, 20}, {0, -16}}, thickness = 1), Line(origin = {0.24, -40.85}, rotation = 90, points = {{0, 100}, {0, -100}}, thickness = 1), Line(origin = {1.11, -60.13}, rotation = 90, points = {{0, 62}, {0, -58}}, thickness = 1), Line(origin = {0.79, -80.84}, rotation = 90, points = {{0, 20}, {0, -20}}, thickness = 1), Line(origin = {-1.17, -99.49}, rotation = 90, points = {{0, 6}, {0, -8}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)));
        end Ground;

        package PartialModels
          partial model TwoPin
            PowerPin positivePin annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            PowerPin negativePin annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Text(extent = {{-36, 68}, {36, 32}}, lineColor = {28, 108, 200}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false)));
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
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1}), graphics={  Ellipse(origin = {-52.3021, -0.271003},
                    fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-7.86, 7.86}, {7.86, -7.86}}, endAngle = 360), Ellipse(origin = {53.0637, 1.30081},
                    fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-7.86, 7.86}, {7.86, -7.86}}, endAngle = 360), Line(origin = {-25.08, 29.48}, points = {{-74.3793, -28.9334}, {-31.0189, -28.9334}, {78.1952, 7.10999}}, thickness = 1), Line(origin = {127.982, 29.6968}, points = {{-74.3793, -28.9334}, {-31.0189, -28.9334}}, thickness = 1), Line(origin = {-51.084, 45.9303}, points = {{50.813, -13.1436}, {51.084, -129.404}}, thickness = 1, arrow = {Arrow.Filled, Arrow.None})}));
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
          Complex Sac;
          Real Pac, Qac;
          Real Eac;
          Real Pdc;
          Real Vdc;
          Real Idc;
          Real tan_phi "AC power factor";
          Real delta "Extintion angle";
          Real u "Commutation anlge (overlapping angle)";
          Modelica.Blocks.Interfaces.RealInput alpha "Delay angle (firing angle)" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        equation
          Vdc = pinDCn.v - pinDCp.v "definitition of Vdc";
          Idc = pinDCp.i "definition of Idc";
          Eac = sqrt(pinAC.vr ^ 2 + pinAC.vi ^ 2) "calculate AC voltage magnitude";
          pinDCp.i + pinDCn.i = 0 "internal KCL equation for the dc side of the converter";
          /* Energy conversion equations */
          Sac = (pinAC.vr + j * pinAC.vi) * conj(pinAC.ir + j * pinAC.ii);
          Pac = real(Sac);
          Qac = imag(Sac);
          Pdc = Vdc * Idc;
          Pac = Pdc + 2 * Idc ^ 2 * Rc "With Energy loss";
          //  Pac = Pdc "No Energy loss";
          Qac = Pac * tan_phi;
          /* converter average model */
          delta = alpha + u;
          tan_phi = (2 * u + sin(2 * alpha) - sin(2 * delta)) / (cos(2 * alpha) - cos(2 * delta));
          u = acos(cos(alpha) - sqrt(2) * Idc * Xc / Eac) - alpha;
          Vdc = 3 * sqrt(2) / pi * Eac * cos(alpha) - 3 * Xc / pi * Idc - 2 * Rc * Idc;
          assert(cos(alpha) - sqrt(2) * Idc * Xc / Eac <= 1, "The input to acos() inside \"u = acos(cos(alpha) - sqrt(2) * Idc * Xc / Eac) - alpha\" equation is greater than 1. This is probably caused by an inproper firing angle, alpha.", AssertionLevel.error);
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Polygon(origin = {0.94, 1.26},
                    lineThickness =                                                                                                                                                                                                        1, points = {{-1.75498, 51.5836}, {64.6407, -51.1265}, {-64.6276, -51.1265}, {-1.75498, 51.5836}}), Line(origin = {0.75, 51.96}, points = {{-62.5348, 1.15271}, {63.4814, 1.42372}}, thickness = 1), Line(origin = {21.5088, 70.876}, points = {{-22.4264, 23.6459}, {-22.4264, -18.6305}}, thickness = 1), Line(origin = {21.4546, -73.8937}, points = {{-22.4264, 23.6459}, {-22.4264, -18.6305}}, thickness = 1), Line(origin = {-76.9736, -21.3733}, rotation = -90, points = {{-22.4264, 44.2421}, {-22.4264, -18.6305}}, thickness = 1), Line(origin = {51.6985, -22.5115}, rotation = -90, points = {{-22.4264, 44.2421}, {-22.4264, -18.6305}}, thickness = 1)}));
        end Converter;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end AC2DC;
    end Electrical;

    package Control
    end Control;
  end BasicElements;

  model HVDC_12pulse_bipolar
    HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus2 annotation(Placement(visible = true, transformation(origin = {-290, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus1 annotation(Placement(visible = true, transformation(origin = {-290, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus3 annotation(Placement(visible = true, transformation(origin = {-290, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus4 annotation(Placement(visible = true, transformation(origin = {-290, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Filter.LowFreqFilter lowfreqfilter1 annotation(Placement(visible = true, transformation(origin = {-360, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Filter.HighFreqFilter highfreqfilter1 annotation(Placement(visible = true, transformation(origin = {-360, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Capacitor capacitor1 annotation(Placement(visible = true, transformation(origin = {-360, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-390, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.PowerPin powerpin1 annotation(Placement(visible = true, transformation(origin = {-380, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-380, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Transformer2W_Ideal transformer2w_ideal1 annotation(Placement(visible = true, transformation(origin = {-260, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Transformer2W_Ideal transformer2w_ideal2 annotation(Placement(visible = true, transformation(origin = {-260, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Transformer2W_Ideal transformer2w_ideal3 annotation(Placement(visible = true, transformation(origin = {-260, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.Phasor.Transformer2W_Ideal transformer2w_ideal4 annotation(Placement(visible = true, transformation(origin = {-260, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter1 annotation(Placement(visible = true, transformation(origin = {-220, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter2 annotation(Placement(visible = true, transformation(origin = {-220, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter3 annotation(Placement(visible = true, transformation(origin = {-220, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter4 annotation(Placement(visible = true, transformation(origin = {-220, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BasicElements.Electrical.DC.Inductor inductor
      annotation (Placement(transformation(extent={{-172,83},{-152,103}})));
    BasicElements.Electrical.DC.Bus bus
      annotation (Placement(transformation(extent={{-198,83},{-178,103}})));
    BasicElements.Electrical.DC.Bus bus5
      annotation (Placement(transformation(extent={{-142,83},{-122,103}})));
    BasicElements.Electrical.DC.Resistor resistor
      annotation (Placement(transformation(extent={{-108,83},{-88,103}})));
    BasicElements.Electrical.DC.Inductor inductor1
      annotation (Placement(transformation(extent={{-68,83},{-48,103}})));
    BasicElements.Electrical.DC.Capacitor capacitor annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-38,71})));
    BasicElements.Electrical.DC.Ground ground
      annotation (Placement(transformation(extent={{-47,38},{-27,58}})));
    BasicElements.Electrical.DC.Resistor resistor1
      annotation (Placement(transformation(extent={{15,83},{35,103}})));
    BasicElements.Electrical.DC.Inductor inductor2
      annotation (Placement(transformation(extent={{-22,83},{-2,103}})));
    BasicElements.Electrical.DC.Bus bus6
      annotation (Placement(transformation(extent={{42,83},{62,103}})));
    BasicElements.Electrical.DC.Inductor inductor3
      annotation (Placement(transformation(extent={{63,83},{83,103}})));
    BasicElements.Electrical.DC.Bus bus7
      annotation (Placement(transformation(extent={{91,83},{111,103}})));
    BasicElements.Electrical.Phasor.Bus          bus8 annotation(Placement(visible = true, transformation(origin={214,30},     extent={{10,-10},
              {-10,10}},                                                                                                                                        rotation = 0)));
    BasicElements.Electrical.Phasor.Bus          bus9 annotation(Placement(visible = true, transformation(origin={214,70},     extent={{10,-10},
              {-10,10}},                                                                                                                                        rotation = 0)));
    BasicElements.Electrical.Phasor.Bus          bus10
                                                      annotation(Placement(visible = true, transformation(origin={214,-10},     extent={{10,-10},
              {-10,10}},                                                                                                                                         rotation = 0)));
    BasicElements.Electrical.Phasor.Bus          bus11
                                                      annotation(Placement(visible = true, transformation(origin={214,-60},     extent={{10,-10},
              {-10,10}},                                                                                                                                         rotation = 0)));
    BasicElements.Electrical.Phasor.Filter.LowFreqFilter          lowfreqfilter2 annotation(Placement(visible = true, transformation(origin={251,70},     extent={{10,-10},
              {-10,10}},                                                                                                                                                                   rotation = 0)));
    BasicElements.Electrical.Phasor.Filter.HighFreqFilter          highfreqfilter2 annotation(Placement(visible = true, transformation(origin={251,30},     extent={{10,-10},
              {-10,10}},                                                                                                                                                                     rotation = 0)));
    BasicElements.Electrical.Phasor.Capacitor          capacitor2 annotation(Placement(visible = true, transformation(origin={250,-10},     extent={{10,-10},
              {-10,10}},                                                                                                                                                     rotation = 0)));
    BasicElements.Electrical.Phasor.Ground          ground2 annotation(Placement(visible = true, transformation(origin={286,-25},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BasicElements.Electrical.Phasor.Transformer2W_Ideal          transformer2w_ideal5 annotation(Placement(visible = true, transformation(origin={175,70},     extent={{10,10},
              {-10,-10}},                                                                                                                                                                       rotation = 0)));
    BasicElements.Electrical.Phasor.Transformer2W_Ideal          transformer2w_ideal6 annotation(Placement(visible = true, transformation(origin={176,30},     extent={{10,10},
              {-10,-10}},                                                                                                                                                                       rotation = 0)));
    BasicElements.Electrical.Phasor.Transformer2W_Ideal          transformer2w_ideal7 annotation(Placement(visible = true, transformation(origin={176,-11},     extent={{10,10},
              {-10,-10}},                                                                                                                                                                        rotation = 0)));
    BasicElements.Electrical.Phasor.Transformer2W_Ideal          transformer2w_ideal8 annotation(Placement(visible = true, transformation(origin={175,-60},     extent={{10,10},
              {-10,-10}},                                                                                                                                                                        rotation = 0)));
    BasicElements.Electrical.AC2DC.Converter          converter5 annotation(Placement(visible = true, transformation(origin={138,70},     extent={{10,10},
              {-10,-10}},                                                                                                                                                  rotation = 0)));
    BasicElements.Electrical.AC2DC.Converter          converter6 annotation(Placement(visible = true, transformation(origin={138,30},     extent={{10,10},
              {-10,-10}},                                                                                                                                                  rotation = 0)));
    BasicElements.Electrical.AC2DC.Converter          converter7 annotation(Placement(visible = true, transformation(origin={138,-10},     extent={{10,10},
              {-10,-10}},                                                                                                                                                   rotation = 0)));
    BasicElements.Electrical.AC2DC.Converter          converter8 annotation(Placement(visible = true, transformation(origin={138,-60},     extent={{10,10},
              {-10,-10}},                                                                                                                                                   rotation = 0)));
    BasicElements.Electrical.Phasor.PowerPin          powerpin2 annotation(Placement(visible = true, transformation(origin={284,-63},     extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-380, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BasicElements.Electrical.DC.Inductor inductor4
      annotation (Placement(transformation(extent={{-172,-124},{-152,-104}})));
    BasicElements.Electrical.DC.Bus bus12
      annotation (Placement(transformation(extent={{-198,-124},{-178,-104}})));
    BasicElements.Electrical.DC.Bus bus13
      annotation (Placement(transformation(extent={{-142,-124},{-122,-104}})));
    BasicElements.Electrical.DC.Resistor resistor2
      annotation (Placement(transformation(extent={{-108,-124},{-88,-104}})));
    BasicElements.Electrical.DC.Inductor inductor5
      annotation (Placement(transformation(extent={{-68,-124},{-48,-104}})));
    BasicElements.Electrical.DC.Capacitor capacitor3 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-38,-136})));
    BasicElements.Electrical.DC.Ground ground3
      annotation (Placement(transformation(extent={{-47,-169},{-27,-149}})));
    BasicElements.Electrical.DC.Resistor resistor3
      annotation (Placement(transformation(extent={{15,-124},{35,-104}})));
    BasicElements.Electrical.DC.Inductor inductor6
      annotation (Placement(transformation(extent={{-22,-124},{-2,-104}})));
    BasicElements.Electrical.DC.Bus bus14
      annotation (Placement(transformation(extent={{42,-124},{62,-104}})));
    BasicElements.Electrical.DC.Inductor inductor7
      annotation (Placement(transformation(extent={{63,-124},{83,-104}})));
    BasicElements.Electrical.DC.Bus bus15
      annotation (Placement(transformation(extent={{91,-124},{111,-104}})));
    BasicElements.Electrical.DC.Ground ground4
      annotation (Placement(transformation(extent={{-190,-9},{-170,11}})));
    BasicElements.Electrical.DC.Ground ground5
      annotation (Placement(transformation(extent={{91,-9},{111,11}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{59,35},{79,55}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{69,-52},{89,-32}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{-161,39},{-181,59}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{-160,-56},{-180,-36}})));
  equation
    connect(converter1.pinDCp, converter2.pinDCn) annotation(Line(points={{-220,60},
            {-220.464,60},{-220.464,40},{-220,40}},                                                                                                color = {255, 0, 0}));
    connect(converter3.pinDCn, converter2.pinDCp) annotation(Line(points={{-220,
            5.55112e-16},{-220.198,5.55112e-16},{-220.198,20},{-220,20}},                                                                                            color = {255, 0, 0}));
    connect(converter4.pinDCn, converter3.pinDCp) annotation(Line(points={{-220,
            -50},{-219.933,-50},{-219.933,-20},{-220,-20}},                                                                                            color = {255, 0, 0}));
    connect(transformer2w_ideal1.negativePin, converter1.pinAC) annotation(Line(points={{-250,70},
            {-230.026,70},{-230.026,70},{-230,70}},                                                                                                            color = {0, 0, 255}));
    connect(transformer2w_ideal2.negativePin, converter2.pinAC) annotation(Line(points={{-250,30},
            {-229.76,30},{-229.76,30},{-230,30}},                                                                                                             color = {0, 0, 255}));
    connect(transformer2w_ideal3.negativePin, converter3.pinAC) annotation(Line(points={{-250,
            -10},{-229.495,-10},{-229.495,-10},{-230,-10}},                                                                                                        color = {0, 0, 255}));
    connect(transformer2w_ideal4.negativePin, converter4.pinAC) annotation(Line(points={{-250,
            -60},{-229.76,-60},{-229.76,-60},{-230,-60}},                                                                                                         color = {0, 0, 255}));
    connect(bus4.negativePin, transformer2w_ideal4.positivePin) annotation(Line(points={{-288,
            -60.2},{-269.869,-60.2},{-269.869,-60},{-270,-60}},                                                                                                          color = {0, 0, 255}));
    connect(bus3.negativePin, transformer2w_ideal3.positivePin) annotation(Line(points={{-288,
            -10.2},{-270.135,-10.2},{-270.135,-10},{-270,-10}},                                                                                                          color = {0, 0, 255}));
    connect(bus2.negativePin, transformer2w_ideal2.positivePin) annotation(Line(points={{-288,
            29.8},{-269.869,29.8},{-269.869,30},{-270,30}},                                                                                                          color = {0, 0, 255}));
    connect(bus1.negativePin, transformer2w_ideal1.positivePin) annotation(Line(points={{-288,
            69.8},{-269.869,69.8},{-269.869,70},{-270,70}},                                                                                                          color = {0, 0, 255}));
    connect(bus3.negativePin, bus4.negativePin) annotation(Line(points={{-288,
            -10.2},{-286.603,-10.2},{-286.603,-60.5611},{-288,-60.5611},{-288,
            -60.2}},                                                                                                                                                       color = {0, 0, 255}));
    connect(bus2.negativePin, bus3.negativePin) annotation(Line(points={{-288,
            29.8},{-287.134,29.8},{-287.134,-10.2},{-288,-10.2}},                                                                                    color = {0, 0, 255}));
    connect(bus1.negativePin, bus2.negativePin) annotation(Line(points={{-288,
            69.8},{-287.134,69.8},{-287.134,29.8},{-288,29.8}},                                                                                      color = {0, 0, 255}));
    connect(powerpin1, bus4.positivePin) annotation(Line(points={{-380,-60},{
            -292.447,-60},{-292.447,-60.2},{-292,-60.2}},                                                                                     color = {0, 0, 255}));
    connect(ground1.pin, capacitor1.positivePin) annotation(Line(points={{-390,
            -20},{-389.929,-20},{-389.929,-9.56229},{-370,-9.56229},{-370,-10}},                                                                                            color = {0, 0, 255}));
    connect(capacitor1.negativePin, bus3.positivePin) annotation(Line(points={{-350,
            -10},{-291.384,-10},{-291.384,-10.2},{-292,-10.2}},                                                                                            color = {0, 0, 255}));
    connect(highfreqfilter1.pin, bus2.positivePin) annotation(Line(points={{-350,30},
            {-292.181,30},{-292.181,29.8},{-292,29.8}},                                                                                             color = {0, 0, 255}));
    connect(lowfreqfilter1.pin, bus1.positivePin) annotation(Line(points={{-350,70},
            {-292.712,70},{-292.712,69.8},{-292,69.8}},                                                                                            color = {0, 0, 255}));
    connect(bus.negativePin, inductor.positivePin) annotation (Line(points={{
            -186,92.8},{-178.5,92.8},{-178.5,93},{-172,93}}, color={255,0,0}));
    connect(inductor.negativePin, bus5.positivePin) annotation (Line(points={{
            -152,93},{-143,93},{-143,92.8},{-134,92.8}}, color={255,0,0}));
    connect(inductor1.positivePin, resistor.negativePin)
      annotation (Line(points={{-68,93},{-88,93}}, color={255,0,0}));
    connect(resistor.positivePin, bus5.negativePin) annotation (Line(points={{
            -108,93},{-119,93},{-119,92.8},{-130,92.8}}, color={255,0,0}));
    connect(inductor1.negativePin, capacitor.positivePin)
      annotation (Line(points={{-48,93},{-38,93},{-38,81}}, color={255,0,0}));
    connect(capacitor.negativePin, ground.pin)
      annotation (Line(points={{-38,61},{-38,48},{-37,48}}, color={255,0,0}));
    connect(inductor2.negativePin, resistor1.positivePin)
      annotation (Line(points={{-2,93},{15,93}}, color={255,0,0}));
    connect(inductor2.positivePin, inductor1.negativePin)
      annotation (Line(points={{-22,93},{-48,93}}, color={255,0,0}));
    connect(resistor1.negativePin, bus6.positivePin) annotation (Line(points={{
            35,93},{43,93},{43,92.8},{50,92.8}}, color={255,0,0}));
    connect(inductor3.positivePin, bus6.negativePin) annotation (Line(points={{
            63,93},{59,93},{59,92.8},{54,92.8}}, color={255,0,0}));
    connect(inductor3.negativePin, bus7.positivePin) annotation (Line(points={{
            83,93},{91,93},{91,92.8},{99,92.8}}, color={255,0,0}));
    connect(converter1.pinDCn, bus.positivePin) annotation (Line(points={{-220,
            80},{-219,80},{-219,94},{-190,94},{-190,92.8}}, color={255,0,0}));
    connect(converter5.pinDCp, bus7.negativePin) annotation (Line(points={{138,
            80},{138,92.8},{103,92.8}}, color={255,0,0}));
    connect(converter5.pinDCn, converter6.pinDCp)
      annotation (Line(points={{138,60},{138,40},{138,40}}, color={255,0,0}));
    connect(converter6.pinDCn, converter7.pinDCp)
      annotation (Line(points={{138,20},{138,0}}, color={255,0,0}));
    connect(converter7.pinDCn, converter8.pinDCp)
      annotation (Line(points={{138,-20},{138,-50}}, color={255,0,0}));
    connect(converter5.pinAC, transformer2w_ideal5.negativePin)
      annotation (Line(points={{148,70},{165,70}}, color={0,0,255}));
    connect(transformer2w_ideal6.negativePin, converter6.pinAC)
      annotation (Line(points={{166,30},{148,30}}, color={0,0,255}));
    connect(transformer2w_ideal7.negativePin, converter7.pinAC) annotation (
        Line(points={{166,-11},{158,-11},{158,-10},{148,-10}}, color={0,0,255}));
    connect(transformer2w_ideal8.negativePin, converter8.pinAC)
      annotation (Line(points={{165,-60},{148,-60}}, color={0,0,255}));
    connect(transformer2w_ideal5.positivePin, bus9.negativePin) annotation (
        Line(points={{185,70},{199,70},{199,69.8},{212,69.8}}, color={0,0,255}));
    connect(transformer2w_ideal6.positivePin, bus8.negativePin) annotation (
        Line(points={{186,30},{199,30},{199,29.8},{212,29.8}}, color={0,0,255}));
    connect(transformer2w_ideal7.positivePin, bus10.negativePin) annotation (
        Line(points={{186,-11},{199,-11},{199,-10.2},{212,-10.2}}, color={0,0,
            255}));
    connect(transformer2w_ideal8.positivePin, bus11.negativePin) annotation (
        Line(points={{185,-60},{199,-60},{199,-60.2},{212,-60.2}}, color={0,0,
            255}));
    connect(bus12.negativePin, inductor4.positivePin) annotation (Line(points={
            {-186,-114.2},{-178.5,-114.2},{-178.5,-114},{-172,-114}}, color={
            255,0,0}));
    connect(inductor4.negativePin, bus13.positivePin) annotation (Line(points={
            {-152,-114},{-143,-114},{-143,-114.2},{-134,-114.2}}, color={255,0,
            0}));
    connect(inductor5.positivePin, resistor2.negativePin)
      annotation (Line(points={{-68,-114},{-88,-114}}, color={255,0,0}));
    connect(resistor2.positivePin, bus13.negativePin) annotation (Line(points={
            {-108,-114},{-119,-114},{-119,-114.2},{-130,-114.2}}, color={255,0,
            0}));
    connect(inductor5.negativePin, capacitor3.positivePin) annotation (Line(
          points={{-48,-114},{-38,-114},{-38,-126}}, color={255,0,0}));
    connect(capacitor3.negativePin, ground3.pin) annotation (Line(points={{-38,
            -146},{-38,-159},{-37,-159}}, color={255,0,0}));
    connect(inductor6.negativePin, resistor3.positivePin)
      annotation (Line(points={{-2,-114},{15,-114}}, color={255,0,0}));
    connect(inductor6.positivePin, inductor5.negativePin)
      annotation (Line(points={{-22,-114},{-48,-114}}, color={255,0,0}));
    connect(resistor3.negativePin, bus14.positivePin) annotation (Line(points={
            {35,-114},{43,-114},{43,-114.2},{50,-114.2}}, color={255,0,0}));
    connect(inductor7.positivePin, bus14.negativePin) annotation (Line(points={
            {63,-114},{59,-114},{59,-114.2},{54,-114.2}}, color={255,0,0}));
    connect(inductor7.negativePin, bus15.positivePin) annotation (Line(points={
            {83,-114},{91,-114},{91,-114.2},{99,-114.2}}, color={255,0,0}));
    connect(bus15.negativePin, converter8.pinDCn) annotation (Line(points={{103,
            -114.2},{138,-114.2},{138,-70}}, color={255,0,0}));
    connect(bus12.positivePin, converter4.pinDCp) annotation (Line(points={{
            -190,-114.2},{-207,-114.2},{-207,-115},{-220,-115},{-220,-70}},
          color={255,0,0}));
    connect(bus9.positivePin, lowfreqfilter2.pin) annotation (Line(points={{216,
            69.8},{229,69.8},{229,70},{241,70}}, color={0,0,255}));
    connect(bus8.positivePin, highfreqfilter2.pin) annotation (Line(points={{
            216,29.8},{229,29.8},{229,30},{241,30}}, color={0,0,255}));
    connect(bus10.positivePin, capacitor2.negativePin) annotation (Line(points=
            {{216,-10.2},{228,-10.2},{228,-10},{240,-10}}, color={0,0,255}));
    connect(capacitor2.positivePin, ground2.pin) annotation (Line(points={{260,
            -10},{286,-10},{286,-25}}, color={0,0,255}));
    connect(powerpin2, bus11.positivePin) annotation (Line(points={{284,-63},{
            216,-63},{216,-60.2}}, color={0,0,255}));
    connect(ground5.pin, converter7.pinDCp) annotation (Line(points={{101,1},{
            101,10},{138,10},{138,0}}, color={255,0,0}));
    connect(ground4.pin, converter2.pinDCp) annotation (Line(points={{-180,1},{
            -180,10},{-220,10},{-220.198,20},{-220,20}}, color={255,0,0}));
    connect(const.y, converter5.alpha) annotation (Line(points={{80,45},{90,45},
            {90,71},{128,71},{128,70}}, color={0,0,127}));
    connect(converter6.alpha, converter5.alpha) annotation (Line(points={{128,
            30},{124,30},{124,31},{90,31},{90,46},{89,46},{89,45},{90,45},{90,
            71},{128,71},{128,70}}, color={0,0,127}));
    connect(converter8.alpha, const1.y) annotation (Line(points={{128,-60},{114,
            -60},{114,-61},{99,-61},{99,-42},{90,-42}}, color={0,0,127}));
    connect(converter7.alpha, const1.y) annotation (Line(points={{128,-10},{119,
            -10},{119,-42},{90,-42}}, color={0,0,127}));
    connect(const2.y, converter1.alpha) annotation (Line(points={{-182,49},{
            -184,49},{-184,51},{-192,51},{-192,70},{-210,70}}, color={0,0,127}));
    connect(converter2.alpha, converter1.alpha) annotation (Line(points={{-210,
            30},{-204,30},{-204,29},{-192,29},{-192,70},{-210,70}}, color={0,0,
            127}));
    connect(const3.y, converter3.alpha) annotation (Line(points={{-181,-46},{
            -195,-46},{-195,-10},{-210,-10}}, color={0,0,127}));
    connect(converter4.alpha, converter3.alpha) annotation (Line(points={{-210,
            -60},{-203,-60},{-203,-61},{-194,-61},{-194,-46},{-195,-46},{-195,
            -10},{-210,-10}}, color={0,0,127}));
    annotation(Diagram(coordinateSystem(extent = {{-500, -200}, {500, 200}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-500, -200}, {500, 200}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})));
  end HVDC_12pulse_bipolar;
  annotation(uses(Modelica(version = "3.2.2")));
end HVDC_LCC;
