package HVDC_LCC_Test
  package BasicElements
    package Electrical
  package Phasor
        model testResistance
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource Vs(Vang = 0) annotation(
            Placement(visible = true, transformation(origin = {-114, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor1 annotation(
            Placement(visible = true, transformation(origin = {-55, 1}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(
            Placement(visible = true, transformation(origin = {75, -51}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Resistor resistor2 annotation(
            Placement(visible = true, transformation(origin = {13, 1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
        equation
          connect(resistor2.negativePin, ground1.pin) annotation(
            Line(points = {{38, 2}, {76, 2}, {76, -50}, {76, -50}}, color = {0, 0, 255}));
          connect(resistor1.negativePin, resistor2.positivePin) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 2}, {-12, 2}}, color = {0, 0, 255}));
          connect(resistor1.positivePin, Vs.pin) annotation(
            Line(points = {{-78, 0}, {-96, 0}, {-96, 0}, {-96, 0}}, color = {0, 0, 255}));
        end testResistance;

        model testInductance
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource Vs(Vang = 0) annotation(
            Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Ground ground1 annotation(
            Placement(visible = true, transformation(origin = {96, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor1 annotation(
            Placement(visible = true, transformation(origin = {7, 1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.Reactor reactor2 annotation(
            Placement(visible = true, transformation(origin = {61, 1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        equation
          connect(reactor2.negativePin, ground1.pin) annotation(
            Line(points = {{82, 2}, {96, 2}, {96, -44}, {96, -44}}, color = {0, 0, 255}));
          connect(reactor1.negativePin, reactor2.positivePin) annotation(
            Line(points = {{28, 2}, {40, 2}, {40, 2}, {40, 2}}, color = {0, 0, 255}));
          connect(Vs.pin, reactor1.positivePin) annotation(
            Line(points = {{-40, 0}, {-16, 0}, {-16, 2}, {-14, 2}}, color = {0, 0, 255}));
        end testInductance;
      end Phasor;
    end Electrical;

    package Control
      package Tests
      end Tests;
    end Control;
  end BasicElements;
  annotation(
    uses(Modelica(version = "3.2.2")));
end HVDC_LCC_Test;