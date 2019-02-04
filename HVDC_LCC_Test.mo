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
          connect(transformer2w_ideal1.negativePin, resistor1.positivePin) annotation(Line(points = {{-40.2, 0.2}, {-29.8103, 0.2}, {-29.8103, 0.542005}, {-29.8103, 0.542005}}, color = {0, 0, 255}));
          connect(voltagesource1.pin, transformer2w_ideal1.positivePin) annotation(Line(points = {{-70.2, 0}, {-59.0786, 0}, {-59.0786, 0}, {-59.0786, 0}}, color = {0, 0, 255}));
          annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})));
        end testTransformer2W;
      end Phasor;

      package DC
        model testResistance
          HVDC_LCC.BasicElements.Electrical.DC.VoltageSource voltagesource1 annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Ground ground1 annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(resistor2.negativePin, ground1.pin) annotation(Line(points = {{30, 0}, {40.1084, 0}, {40.1084, -19.7832}, {40.1084, -19.7832}}, color = {255, 0, 0}));
          connect(resistor2.positivePin, resistor1.negativePin) annotation(Line(points = {{10, 0}, {-10.2981, 0}, {-10.2981, 0.271003}, {-10.2981, 0.271003}}, color = {255, 0, 0}));
          connect(voltagesource1.pin, resistor1.positivePin) annotation(Line(points = {{-50.2, 0}, {-29.8103, 0}, {-29.8103, 0.542005}, {-29.8103, 0.542005}}, color = {255, 0, 0}));
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end testResistance;

        model testInductance
          HVDC_LCC.BasicElements.Electrical.DC.VoltageSource voltagesource1 annotation(Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Inductor inductor1 annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Switch switch1 annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Ground ground1 annotation(Placement(visible = true, transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.BooleanStep booleanstep1(startTime = 1, startValue = true) annotation(Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(booleanstep1.y, switch1.status) annotation(Line(points = {{-49, -20}, {-43.0894, -20}, {-43.0894, -0.542005}, {-29.8103, -0.542005}, {-29.8103, -0.542005}}, color = {255, 0, 255}));
          connect(ground1.pin, resistor2.negativePin) annotation(Line(points = {{40, -60}, {40.3794, -60}, {40.3794, 20.0542}, {10.0271, 20.0542}, {10.0271, 20.0542}}, color = {255, 0, 0}));
          connect(resistor1.negativePin, ground1.pin) annotation(Line(points = {{-20, -50}, {-20, -50.6775}, {40.3794, -50.6775}, {40.3794, -59.6206}, {40.3794, -59.6206}}, color = {255, 0, 0}));
          connect(switch1.negativePin, resistor1.positivePin) annotation(Line(points = {{-20, -10}, {-20, -30.3523}, {-20.5962, -30.3523}, {-20.5962, -30.3523}}, color = {255, 0, 0}));
          connect(switch1.positivePin, inductor1.negativePin) annotation(Line(points = {{-20, 10}, {-20, 19.7832}, {-29.8103, 19.7832}, {-29.8103, 20.5962}, {-29.8103, 20.5962}}, color = {255, 0, 0}));
          connect(inductor1.negativePin, resistor2.positivePin) annotation(Line(points = {{-30, 20}, {-10.5691, 20}, {-10.5691, 19.7832}, {-10.5691, 19.7832}}, color = {255, 0, 0}));
          connect(voltagesource1.pin, inductor1.positivePin) annotation(Line(points = {{-70.2, 20}, {-50.4065, 20}, {-50.4065, 19.7832}, {-50.4065, 19.7832}}, color = {255, 0, 0}));
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end testInductance;

        model testCapacitance
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Capacitor capacitor1 annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Switch switch1 annotation(Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor3 annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.VoltageSource voltagesource1 annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Ground ground1 annotation(Placement(visible = true, transformation(origin = {40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.BooleanStep booleanstep1(startTime = 1, startValue = true) annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(booleanstep1.y, switch1.status) annotation(Line(points = {{-29, -20}, {-19.7832, -20}, {-19.7832, 10.8401}, {-19.7832, 10.8401}}, color = {255, 0, 255}));
          connect(ground1.pin, resistor2.negativePin) annotation(Line(points = {{40, -40}, {81.3008, -40}, {81.3008, 19.7832}, {70.7317, 19.7832}, {70.7317, 19.7832}}, color = {255, 0, 0}));
          connect(ground1.pin, capacitor1.negativePin) annotation(Line(points = {{40, -40}, {40.3794, -40}, {40.3794, -10.5691}, {40.3794, -10.5691}}, color = {255, 0, 0}));
          connect(capacitor1.positivePin, resistor1.negativePin) annotation(Line(points = {{40, 10}, {40, 20.0542}, {29.8103, 20.0542}, {29.8103, 19.5122}, {29.8103, 19.5122}}, color = {255, 0, 0}));
          connect(resistor1.negativePin, resistor2.positivePin) annotation(Line(points = {{30, 20}, {50.6775, 20}, {50.6775, 19.7832}, {50.6775, 19.7832}}, color = {255, 0, 0}));
          connect(switch1.negativePin, resistor1.positivePin) annotation(Line(points = {{-10, 20}, {10.2981, 20}, {10.2981, 20.0542}, {10.2981, 20.0542}}, color = {255, 0, 0}));
          connect(resistor3.negativePin, switch1.positivePin) annotation(Line(points = {{-50, 20}, {-30.0813, 20}, {-30.0813, 19.5122}, {-30.0813, 19.5122}}, color = {255, 0, 0}));
          connect(voltagesource1.pin, resistor3.positivePin) annotation(Line(points = {{-90.2, 20}, {-71.0027, 20}, {-71.0027, 20.0542}, {-71.0027, 20.0542}}, color = {255, 0, 0}));
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end testCapacitance;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end DC;

      package AC2DC
        model testConverter
          HVDC_LCC.BasicElements.Electrical.DC.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter1(Rc = 0, Xc = 0.57) annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltagesource1(Vang = 7.08, Vmag = 0.985 * 200 * 1000) annotation(Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 68.07 / 180 * Modelica.Constants.pi) annotation(Placement(visible = true, transformation(origin = {0, -20}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.VoltageSource voltagesource2(Vmag = 9.96 * 10000) annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        equation
          connect(resistor1.negativePin, voltagesource2.pin) annotation(Line(points = {{10, 0}, {39.6807, 0}, {39.6807, -10.0342}, {39.6807, -10.0342}}, color = {255, 0, 0}));
          connect(const.y, converter1.alpha) annotation(Line(points = {{-5.5, -20}, {-29.8103, -20}, {-29.8103, -20.0542}, {-29.8103, -20.0542}}, color = {0, 0, 127}));
          connect(converter1.pinDCn, resistor1.positivePin) annotation(Line(points = {{-40, -10}, {-40.3794, -10}, {-40.3794, 0}, {-11.3821, 0}, {-11.3821, 0}}, color = {255, 0, 0}));
          connect(voltagesource1.pin, converter1.pinAC) annotation(Line(points = {{-70.2, -20}, {-50.4065, -20}, {-50.4065, -20.3252}, {-50.4065, -20.3252}}, color = {0, 0, 255}));
          connect(converter1.pinDCp, ground1.pin) annotation(Line(points = {{-40, -30}, {-39.8374, -30}, {-39.8374, -40}, {-40, -40}}, color = {255, 0, 0}));
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end testConverter;

        model testConverter2
          HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter1(Rc = 0, Xc = 0.57) annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.AC2DC.Converter converter2(Rc = 0, Xc = 0.57) annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.DC.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltagesource1(Vmag = 0.985 * 200 * 1e3, Vang = 7.08) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 72.25 / 180 * Modelica.Constants.pi) annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant constant1(k = 68.07 / 180 * Modelica.Constants.pi) annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
          HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltagesource2(Vmag = 0.9683 * 200 * 1e3, Vang = 7.29) annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        equation
          connect(voltagesource2.pin, converter2.pinAC) annotation(Line(points = {{50.2, 0}, {50.3991, 0}, {50.3991, 0}, {50, 0}}, color = {0, 0, 255}));
          connect(const.y, converter2.alpha) annotation(Line(points = {{25.5, 0}, {30.3523, 0}, {30.3523, -0.271003}, {30.3523, -0.271003}}, color = {0, 0, 127}));
          connect(converter1.alpha, constant1.y) annotation(Line(points = {{-30, 0}, {-25.4743, 0}, {-25.4743, 0}, {-25.4743, 0}}, color = {0, 0, 127}));
          connect(voltagesource1.pin, converter1.pinAC) annotation(Line(points = {{-70.2, 0}, {-49.5935, 0}, {-49.5935, 0.542005}, {-49.5935, 0.542005}}, color = {0, 0, 255}));
          connect(converter2.pinDCn, ground1.pin) annotation(Line(points = {{40, -10}, {40.3794, -10}, {40.3794, -39.8374}, {-40.3794, -39.8374}, {-40.3794, -39.8374}}, color = {255, 0, 0}));
          connect(ground1.pin, converter1.pinDCp) annotation(Line(points = {{-40, -40}, {-39.5664, -40}, {-39.5664, -11.1111}, {-39.5664, -11.1111}}, color = {255, 0, 0}));
          connect(resistor1.negativePin, converter2.pinDCp) annotation(Line(points = {{10, 20}, {40.3794, 20}, {40.3794, 9.48509}, {40.3794, 9.48509}}, color = {255, 0, 0}));
          connect(converter1.pinDCn, resistor1.positivePin) annotation(Line(points = {{-40, 10}, {-40.1084, 10}, {-40.1084, 20.0542}, {-9.48509, 20.0542}, {-9.48509, 20.0542}}, color = {255, 0, 0}));
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end testConverter2;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end AC2DC;
    end Electrical;

    package Control
      package Tests
      end Tests;
    end Control;
  end BasicElements;

  model HVDC_12pulse_bipolar_test01
    HVDC_LCC.HVDC_12pulse_bipolar hVDC_12pulse_bipolar
      annotation (Placement(transformation(extent={{-38,-16},{42,14}})));
    HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltageSource
      annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
    HVDC_LCC.BasicElements.Electrical.Phasor.VoltageSource voltageSource1
      annotation (Placement(transformation(extent={{76,8},{56,-12}})));
  equation
    connect(voltageSource.pin, hVDC_12pulse_bipolar.powerpin1) annotation (Line(
          points={{-64.2,0},{-50,0},{-50,-1},{-37.8,-1}}, color={0,0,255}));
    connect(voltageSource1.pin, hVDC_12pulse_bipolar.powerpin2) annotation (
        Line(points={{56.2,-2},{48,-2},{48,-1},{41.6,-1}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HVDC_12pulse_bipolar_test01;
  annotation(uses(Modelica(version = "3.2.2")));
end HVDC_LCC_Test;
