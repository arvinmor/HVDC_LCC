package HVDC_LCC_Test
  package BasicElements
    package Electrical
      package Phasor
        model testResistance
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource Vs(Vang = 0) annotation(Placement(visible = true, transformation(origin = {-114, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {-55, 1}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(Placement(visible = true, transformation(origin = {75, -51}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {13, 1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
        equation
          connect(resistor2.negativePin, ground1.pin) annotation(Line(points = {{38, 1}, {76, 1}, {76, -51}, {75, -51}}, color = {0, 0, 255}));
          connect(resistor1.negativePin, resistor2.positivePin) annotation(Line(points = {{-32, 1}, {-12, 1}, {-12, 1}, {-12, 1}}, color = {0, 0, 255}));
          connect(resistor1.positivePin, Vs.pin) annotation(Line(points = {{-78, 1}, {-96, 1}, {-96, 0}, {-96.36, 0}}, color = {0, 0, 255}));
        end testResistance;

        model testInductance
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource Vs(Vang = 0) annotation(Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(Placement(visible = true, transformation(origin = {96, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor1 annotation(Placement(visible = true, transformation(origin = {7, 1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor2 annotation(Placement(visible = true, transformation(origin = {61, 1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        equation
          connect(reactor2.negativePin, ground1.pin) annotation(Line(points = {{82, 1}, {96, 1}, {96, -44}, {96, -44}}, color = {0, 0, 255}));
          connect(reactor1.negativePin, reactor2.positivePin) annotation(Line(points = {{28, 1}, {40, 1}, {40, 1}, {40, 1}}, color = {0, 0, 255}));
          connect(Vs.pin, reactor1.positivePin) annotation(Line(points = {{-40.36, 0}, {-16, 0}, {-16, 1}, {-14, 1}}, color = {0, 0, 255}));
        end testInductance;

        model testBus
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {-35, 1}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus1 annotation(Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource Vs(Vang = 0) annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus2 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {43, 1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Bus bus3 annotation(Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(Placement(visible = true, transformation(origin = {105, -51}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        equation
          connect(bus3.negativePin, ground1.pin) annotation(Line(points = {{92, -0.2}, {106.043, -0.2}, {106.043, -51.0832}, {106.043, -51.0832}}, color = {0, 0, 255}));
          connect(bus3.positivePin, resistor2.negativePin) annotation(Line(points = {{88, -0.2}, {69.0992, -0.2}, {69.0992, -0.22805}, {69.0992, -0.22805}}, color = {0, 0, 255}));
          connect(bus2.negativePin, resistor2.positivePin) annotation(Line(points = {{2, -0.2}, {17.3318, -0.2}, {17.3318, 0}, {17.3318, 0}}, color = {0, 0, 255}));
          connect(bus2.positivePin, resistor1.negativePin) annotation(Line(points = {{-2, -0.2}, {-11.4025, -0.2}, {-11.4025, 1}, {-12, 1}}, color = {0, 0, 255}));
          connect(bus1.negativePin, resistor1.positivePin) annotation(Line(points = {{-68, -0.2}, {-57.9247, -0.2}, {-57.9247, -0.4561}, {-57.9247, -0.4561}}, color = {0, 0, 255}));
          connect(Vs.pin, bus1.positivePin) annotation(Line(points = {{-82.36, 0}, {-72.748, 0}, {-72.748, -0.22805}, {-72.748, -0.22805}}, color = {0, 0, 255}));
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})));
        end testBus;

        model testCapacitance
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(Placement(visible = true, transformation(origin = {80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltagesource1(Vang = 0) annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-17.5, -17.5}, {17.5, 17.5}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Capacitor capacitor1(XC = 2) annotation(Placement(visible = true, transformation(origin = {10, 20}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
        equation
          connect(capacitor1.negativePin, ground1.pin) annotation(Line(points = {{35, 20}, {79.6748, 20}, {79.6748, -19.5122}, {79.6748, -19.5122}}, color = {0, 0, 255}));
          connect(voltagesource1.pin, capacitor1.positivePin) annotation(Line(points = {{-42.85, 20}, {-15.1762, 20}, {-15.1762, 19.2412}, {-15.1762, 19.2412}}, color = {0, 0, 255}));
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})));
        end testCapacitance;

        model testTransformer2W
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltagesource1 annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Transformer2W_Ideal transformer2w_ideal1 annotation(Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor1(XL = 0) annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(Placement(visible = true, transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltagesource2 annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor2(XL = 0) annotation(Placement(visible = true, transformation(origin = {20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground2 annotation(Placement(visible = true, transformation(origin = {50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(reactor2.negativePin, ground2.pin) annotation(Line(points = {{30, -40}, {49.8645, -40}, {49.8645, -70.7317}, {49.8645, -70.7317}}, color = {0, 0, 255}));
          connect(resistor2.negativePin, reactor2.positivePin) annotation(Line(points = {{-10, -40}, {9.21409, -40}, {9.21409, -39.5664}, {9.21409, -39.5664}}, color = {0, 0, 255}));
          connect(voltagesource2.pin, resistor2.positivePin) annotation(Line(points = {{-70.2, -40}, {-29.8103, -40}, {-29.8103, -40.9214}, {-29.8103, -40.9214}}, color = {0, 0, 255}));
          connect(reactor1.negativePin, ground1.pin) annotation(Line(points = {{30, 0}, {49.8645, 0}, {49.8645, -20.3252}, {49.8645, -20.3252}}, color = {0, 0, 255}));
          connect(resistor1.negativePin, reactor1.positivePin) annotation(Line(points = {{-10, 0}, {10.8401, 0}, {10.8401, 0.271003}, {10.8401, 0.271003}}, color = {0, 0, 255}));
          connect(transformer2w_ideal1.secondaryPin, resistor1.positivePin) annotation(Line(points = {{-40.2, 0.2}, {-29.8103, 0.2}, {-29.8103, 0.542005}, {-29.8103, 0.542005}}, color = {0, 0, 255}));
          connect(voltagesource1.pin, transformer2w_ideal1.primaryPin) annotation(Line(points = {{-70.2, 0}, {-59.0786, 0}, {-59.0786, 0}, {-59.0786, 0}}, color = {0, 0, 255}));
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})));
        end testTransformer2W;
      end Phasor;
    end Electrical;

    package Control
      package Tests
      end Tests;
    end Control;
  end BasicElements;
  annotation(uses(Modelica(version = "3.2.2")));
end HVDC_LCC_Test;
