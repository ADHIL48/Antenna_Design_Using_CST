'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 20 fmax = 30
'# created = '[VERSION]2016.7|25.0.2|20161111[/VERSION]


'@ use template: Planar Coupler & Divider.cfg

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "NanoH"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "PikoF"
End With
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mue "1.0"
     .Rho "1.204"
     .ThermalType "Normal"
     .ThermalConductivity "0.026"
     .HeatCapacity "1.005"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "electric"
     .Zmax "electric"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' optimize mesh settings for planar structures
With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "StepsPerWaveNear", "20"
     .Set "StepsPerBoxNear", "10"
     .Set "StepsPerWaveFar", "20"
     .Set "StepsPerBoxFar", "10"
     .Set "RatioLimitGeometry", "20"
End With
' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy"
'----------------------------------------------------------------------------
'set the frequency range
Solver.FrequencyRange "20", "30"
Dim sDefineAt As String
sDefineAt = "20;24;25;30"
Dim sDefineAtName As String
sDefineAtName = "20;24;25;30"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")
Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)
Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)
' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .Frequency zz_val
    .Create
End With
' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .Frequency zz_val
    .Create
End With
' Define Power flow Monitors
With Monitor
    .Reset
    .Name "power ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerflow"
    .Frequency zz_val
    .Create
End With
' Define Power loss Monitors
With Monitor
    .Reset
    .Name "loss ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerloss"
    .Frequency zz_val
    .Create
End With
Next
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")

'@ define material: Rogers RO4350B (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material
     .Reset
     .Name "Rogers RO4350B (lossy)"
     .Folder ""
.FrqType "all" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm"
.Epsilon "3.48" 
.Mue "1.0" 
.Kappa "0.0" 
.TanD "0.0037" 
.TanDFreq "10.0" 
.TanDGiven "True" 
.TanDModel "ConstTanD" 
.KappaM "0.0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstKappa" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "General 1st" 
.DispersiveFittingSchemeMue "General 1st" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.Rho "0.0" 
.ThermalType "Normal" 
.ThermalConductivity "0.62" 
.SetActiveMaterial "all" 
.Colour "0.94", "0.82", "0.76" 
.Wireframe "False" 
.Transparency "0" 
.Create
End With

'@ new component: substrate

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Component.New "substrate"

'@ define brick: substrate:solid1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "substrate" 
     .Material "Rogers RO4350B (lossy)" 
     .Xrange "-x/2", "x/2" 
     .Yrange "-y/2-dia/2", "y/2+dia/2" 
     .Zrange "-diaThick", "0" 
     .Create
End With

'@ define material: Copper (annealed)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material
     .Reset
     .Name "Copper (annealed)"
     .Folder ""
.FrqType "static" 
.Type "Normal" 
.SetMaterialUnit "Hz", "mm" 
.Epsilon "1" 
.Mue "1.0" 
.Kappa "5.8e+007" 
.TanD "0.0" 
.TanDFreq "0.0" 
.TanDGiven "False" 
.TanDModel "ConstTanD" 
.KappaM "0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstTanD" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "Nth Order" 
.DispersiveFittingSchemeMue "Nth Order" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.FrqType "all" 
.Type "Lossy metal" 
.SetMaterialUnit "GHz", "mm" 
.Mue "1.0" 
.Kappa "5.8e+007" 
.Rho "8930.0" 
.ThermalType "Normal" 
.ThermalConductivity "401.0" 
.HeatCapacity "0.39" 
.MetabolicRate "0" 
.BloodFlow "0" 
.VoxelConvection "0" 
.MechanicsType "Isotropic" 
.YoungsModulus "120" 
.PoissonsRatio "0.33" 
.ThermalExpansionRate "17" 
.Colour "1", "1", "0" 
.Wireframe "False" 
.Reflection "False" 
.Allowoutline "True" 
.Transparentoutline "False" 
.Transparency "0" 
.Create
End With

'@ new component: metal

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Component.New "metal"

'@ define brick: metal:solid3

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Xrange "-x/2", "x/2" 
     .Yrange "-y/2-dia/2", "y/2+dia/2" 
     .Zrange "-diaThick-metalThick", "-diaThick" 
     .Create
End With

'@ define brick: metal:solid4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Xrange "-Mw50/2", "Mw50/2" 
     .Yrange "-y/2-dia/2", "y/2+dia/2" 
     .Zrange "0", "metalThick" 
     .Create
End With

'@ pick face

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Pick.PickFaceFromId "metal:solid4", "3"

'@ define port: 1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "True" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.25", "0.25" 
     .Yrange "-6", "-6" 
     .Zrange "0", "0.035" 
     .XrangeAdd "Mw50*5", "Mw50*5" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "diaThick", "diaThick*10" 
     .SingleEnded "False" 
     .Create 
End With

'@ define boundaries

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "True"
End With

'@ define time domain solver parameters

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "True"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ pick face

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Pick.PickFaceFromId "metal:solid4", "5"

'@ define port: 2

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.26", "0.26" 
     .Yrange "6", "6" 
     .Zrange "0", "0.035" 
     .XrangeAdd "Mw50*5", "Mw50*5" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "diaThick", "diaThick*10" 
     .SingleEnded "False" 
     .Create 
End With

''@ define brick: metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid5" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Xrange "-Mw50/2", "Mw50/2" 
'     .Yrange "padding/2-0.15", "padding/2+0.15" 
'     .Zrange "0", "MetalThick" 
'     .Create
'End With
'
''@ transform: translate metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "metal:solid5" 
'     .Vector "0", "-padding", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ boolean subtract shapes: metal:solid4, metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid4", "metal:solid5"
'
''@ boolean subtract shapes: metal:solid4, metal:solid5_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid4", "metal:solid5_1"
'
''@ pick mid point
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickMidpointFromId "metal:solid4", "50"
'
''@ pick mid point
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickMidpointFromId "metal:solid4", "60"
'
''@ define lumped element: Folder1:element1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With LumpedElement
'     .Reset 
'     .SetName "element1" 
'     .Folder "Folder1" 
'     .SetType "RLCSerial" 
'     .SetR  "res" 
'     .SetL  "0" 
'     .SetC  "cap" 
'     .SetGs "0" 
'     .SetI0 "1e-14" 
'     .SetT  "300" 
'     .SetP1 "True", "0", "-1.1", "0.035" 
'     .SetP2 "True", "0", "-0.9", "0.035" 
'     .SetInvert "False" 
'     .SetMonitor "True" 
'     .SetRadius "0.0" 
'     .Wire "" 
'     .Position "end1" 
'     .Create
'End With
'
''@ clear picks
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.ClearAllPicks
'
''@ pick mid point
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickMidpointFromId "metal:solid4", "38"
'
''@ pick mid point
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickMidpointFromId "metal:solid4", "48"
'
''@ define lumped element: Folder1:element2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With LumpedElement
'     .Reset 
'     .SetName "element2" 
'     .Folder "Folder1" 
'     .SetType "RLCSerial" 
'     .SetR  "res" 
'     .SetL  "0" 
'     .SetC  "cap" 
'     .SetGs "0" 
'     .SetI0 "1e-14" 
'     .SetT  "300" 
'     .SetP1 "True", "0", "0.9", "0.035" 
'     .SetP2 "True", "0", "1.1", "0.035" 
'     .SetInvert "False" 
'     .SetMonitor "True" 
'     .SetRadius "0.0" 
'     .Wire "" 
'     .Position "end1" 
'     .Create
'End With
'
'@ define time domain solver parameters

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "1"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set parametersweep options

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
    .SetSimulationType "Transient" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:padding

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "padding", "1", "10", "11" 
End With

''@ define curve arc: curve1:arc1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Arc
'     .Reset 
'     .Name "arc1" 
'     .Curve "curve1" 
'     .Orientation "Clockwise" 
'     .XCenter "stub" 
'     .YCenter "0" 
'     .X1 "stub+radius" 
'     .Y1 "0.0" 
'     .X2 "0.0" 
'     .Y2 "0.0" 
'     .Angle "90" 
'     .UseAngle "True" 
'     .Segments "0" 
'     .Create
'End With
'
''@ define curve line: curve1:line2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line2" 
'     .Curve "curve1" 
'     .X1 "stub" 
'     .Y1 "0.0" 
'     .X2 "radius+stub" 
'     .Y2 "0.0" 
'     .Create
'End With
'
''@ define curve line: curve1:line3
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line3" 
'     .Curve "curve1" 
'     .X1 "stub" 
'     .Y1 "0.0" 
'     .X2 "stub" 
'     .Y2 "-radius" 
'     .Create
'End With
'
''@ transform curve: rotate curve1:arc1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "curve1:arc1" 
'     .Origin "Free" 
'     .Center "stub", "0", "0" 
'     .Angle "0", "0", "45" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Transform "Curve", "Rotate" 
'End With
'
''@ transform curve: rotate curve1:line2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "curve1:line2" 
'     .Origin "Free" 
'     .Center "stub", "0", "0" 
'     .Angle "0", "0", "45" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Transform "Curve", "Rotate" 
'End With
'
''@ transform curve: rotate curve1:line3
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "curve1:line3" 
'     .Origin "Free" 
'     .Center "stub", "0", "0" 
'     .Angle "0", "0", "45" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Transform "Curve", "Rotate" 
'End With
'
''@ define extrudeprofile: metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With ExtrudeCurve
'     .Reset 
'     .Name "solid5" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Thickness "-metalThick" 
'     .Twistangle "0.0" 
'     .Taperangle "0.0" 
'     .Curve "curve1:line2" 
'     .Create
'End With
'
''@ define curve line: curve1:line1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line1" 
'     .Curve "curve1" 
'     .X1 "0.0" 
'     .Y1 "0.0" 
'     .X2 "stub" 
'     .Y2 "0.0" 
'     .Create
'End With
'
''@ define tracefromcurve: metal:solid6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With TraceFromCurve 
'     .Reset 
'     .Name "solid6" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Curve "curve1:line1" 
'     .Thickness "metalThick" 
'     .Width "0.2" 
'     .RoundStart "False" 
'     .RoundEnd "False" 
'     .GapType "2" 
'     .Create 
'End With
'
''@ transform: translate metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "metal:solid5" 
'     .Vector "0", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: rotate metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "metal:solid5" 
'     .Origin "Free" 
'     .Center "stub", "0", "0" 
'     .Angle "0", "0", "-45" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Transform "Shape", "Rotate" 
'End With
'
''@ define curve line: curve1:line1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line1" 
'     .Curve "curve1" 
'     .X1 "stub" 
'     .Y1 "0.0" 
'     .X2 "stub" 
'     .Y2 "length" 
'     .Create
'End With
'
''@ define tracefromcurve: metal:solid7
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With TraceFromCurve 
'     .Reset 
'     .Name "solid7" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Curve "curve1:line1" 
'     .Thickness "metalThick" 
'     .Width "0.2" 
'     .RoundStart "False" 
'     .RoundEnd "False" 
'     .GapType "2" 
'     .Create 
'End With
'
''@ define cylinder: metal:solid8
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Cylinder 
'     .Reset 
'     .Name "solid8" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .OuterRadius "0.35/2" 
'     .InnerRadius "0.0" 
'     .Axis "z" 
'     .Zrange "-diaThick", "metalThick" 
'     .Xcenter "stub" 
'     .Ycenter "length" 
'     .Segments "0" 
'     .Create 
'End With
'
''@ define cylinder: metal:solid9
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Cylinder 
'     .Reset 
'     .Name "solid9" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .OuterRadius "0.35/2+0.2" 
'     .InnerRadius "0.0" 
'     .Axis "z" 
'     .Zrange "0", "metalThick" 
'     .Xcenter "stub" 
'     .Ycenter "length" 
'     .Segments "0" 
'     .Create 
'End With
'
''@ define brick: metal:solid10
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid10" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Xrange "stub-0.5", "stub+1.5" 
'     .Yrange "length-0.5", "length+1.5" 
'     .Zrange "-diaThick-metalThick", "-diaThick" 
'     .Create
'End With
'
''@ define brick: metal:solid11
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid11" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Xrange "stub-0.7", "stub+1.7" 
'     .Yrange "length-0.7", "length+1.7" 
'     .Zrange "-diaThick-metalThick", "-diaThick" 
'     .Create
'End With
'
''@ boolean subtract shapes: metal:solid3, metal:solid11
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid3", "metal:solid11"
'
'@ define curve line: curve1:line1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "0.0" 
     .Y1 "-y/2-dia/2" 
     .X2 "0.0" 
     .Y2 "y/2+dia/2" 
     .Create
End With

'@ define brick: metal:solid11

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid11" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Xrange "-x/2", "x/2" 
     .Yrange "-y/2-dia/2", "y/2+dia/2" 
     .Zrange "0", "MetalThick" 
     .Create
End With

'@ define tracefromcurve: metal:solid12

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid12" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Curve "curve1:line1" 
     .Thickness "metalThick" 
     .Width "mw50+0.4" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .GapType "2" 
     .Create 
End With

'@ boolean subtract shapes: metal:solid11, metal:solid12

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Subtract "metal:solid11", "metal:solid12"

'@ define curve line: curve1:line1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "0.0" 
     .Y1 "0.0" 
     .X2 "stub+0.2" 
     .Y2 "0.0" 
     .Create
End With

''@ define tracefromcurve: metal:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With TraceFromCurve 
'     .Reset 
'     .Name "solid12" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Curve "curve1:line1" 
'     .Thickness "metalThick" 
'     .Width "0.6" 
'     .RoundStart "False" 
'     .RoundEnd "False" 
'     .GapType "2" 
'     .Create 
'End With
'
''@ boolean subtract shapes: metal:solid11, metal:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid11", "metal:solid12"
'
''@ define curve line: curve1:line1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line1" 
'     .Curve "curve1" 
'     .X1 "stub" 
'     .Y1 "0" 
'     .X2 "stub" 
'     .Y2 "-radius-0.2" 
'     .Create
'End With
'
''@ define curve line: curve1:line2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line2" 
'     .Curve "curve1" 
'     .X1 "stub" 
'     .Y1 "0" 
'     .X2 "stub+radius+0.2" 
'     .Y2 "0" 
'     .Create
'End With
'
''@ define curve arc: curve1:arc1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Arc
'     .Reset 
'     .Name "arc1" 
'     .Curve "curve1" 
'     .Orientation "Clockwise" 
'     .XCenter "stub" 
'     .YCenter "0" 
'     .X1 "stub+radius+0.2" 
'     .Y1 "0" 
'     .X2 "0.0" 
'     .Y2 "0.0" 
'     .Angle "90" 
'     .UseAngle "True" 
'     .Segments "0" 
'     .Create
'End With
'
''@ define extrudeprofile: metal:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With ExtrudeCurve
'     .Reset 
'     .Name "solid12" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Thickness "-metalThick" 
'     .Twistangle "0.0" 
'     .Taperangle "0.0" 
'     .Curve "curve1:line2" 
'     .Create
'End With
'
''@ boolean subtract shapes: metal:solid11, metal:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid11", "metal:solid12"
'
'@ new component: via

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Component.New "via"

'@ define cylinder: via:solid12

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid12" 
     .Component "via" 
     .Material "Copper (annealed)" 
     .OuterRadius "dia/2" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-diaThick-metalThick", "metalThick" 
     .Xcenter "mw50/2+0.2+0.1+dia/2" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ transform: translate via

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via" 
     .Vector "0", "pitch", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "10" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate via:solid12

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12" 
     .Vector "0", "-pitch", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "10" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

''@ define cylinder: via:solid13
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Cylinder 
'     .Reset 
'     .Name "solid13" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .OuterRadius "dia/2" 
'     .InnerRadius "0.0" 
'     .Axis "z" 
'     .Zrange "-diaThick", "metalThick" 
'     .Xcenter "stub" 
'     .Ycenter "-radius-0.4-dia/2" 
'     .Segments "0" 
'     .Create 
'End With
'
''@ transform: rotate via:solid13
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13" 
'     .Origin "Free" 
'     .Center "stub", "0", "0" 
'     .Angle "0", "0", "15" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "6" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Rotate" 
'End With
'
''@ clear picks
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.ClearAllPicks
'
''@ transform: translate via:solid13
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13" 
'     .Vector "0", "pitch", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "2" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6" 
'     .Vector "-pitch", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "5" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_7
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_7" 
'     .Vector "-0.4-dia/2", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_8
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_8" 
'     .Vector "-0.4-dia/2", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_7
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_7" 
'     .Vector "0", "-pitch", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_6_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6_1" 
'     .Vector "0", "0.4+dia/2", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_6_2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6_2" 
'     .Vector "0", "0.4+dia/2", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_6_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6_1" 
'     .Vector "pitch", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ define brick: metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid14" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Xrange "stub-0.2", "stub" 
'     .Yrange "-radius-0.2", "0" 
'     .Zrange "0", "metalThick" 
'     .Create
'End With
'
''@ boolean subtract shapes: metal:solid11, metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid11", "metal:solid14"
'
''@ define brick: metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid14" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Xrange "stub", "stub+radius+0.2" 
'     .Yrange "0", "0.2" 
'     .Zrange "0", "metalThick" 
'     .Create
'End With
'
''@ boolean subtract shapes: metal:solid11, metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid11", "metal:solid14"
'
''@ transform: translate via:solid13_6_3
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6_3" 
'     .Vector "0", "0.1+0.2+0.2+dia/2", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_6_4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6_4" 
'     .Vector "0", "0.1+0.2+0.2+dia/2", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_6_5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_6_5" 
'     .Vector "0", "0.1+0.2+0.2+dia/2", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "False" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid12_11
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_11" 
'     .Vector "pitch", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ define curve line: curve1:line1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Line
'     .Reset 
'     .Name "line1" 
'     .Curve "curve1" 
'     .X1 "stub" 
'     .Y1 "0.0" 
'     .X2 "stub" 
'     .Y2 "length" 
'     .Create
'End With
'
''@ define tracefromcurve: metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With TraceFromCurve 
'     .Reset 
'     .Name "solid14" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Curve "curve1:line1" 
'     .Thickness "metalThick" 
'     .Width "0.6" 
'     .RoundStart "False" 
'     .RoundEnd "False" 
'     .GapType "2" 
'     .Create 
'End With
'
''@ boolean subtract shapes: metal:solid11, metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid11", "metal:solid14"
'
''@ delete shape: via:solid13_6_3
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Delete "via:solid13_6_3"
'
''@ delete shape: via:solid13_6_4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Delete "via:solid13_6_4"
'
''@ define cylinder: metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Cylinder 
'     .Reset 
'     .Name "solid14" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .OuterRadius "dia/2+0.4" 
'     .InnerRadius "0.0" 
'     .Axis "z" 
'     .Zrange "0", "metalThick" 
'     .Xcenter "stub" 
'     .Ycenter "length" 
'     .Segments "0" 
'     .Create 
'End With
'
''@ boolean subtract shapes: metal:solid11, metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "metal:solid11", "metal:solid14"
'
''@ define cylinder: metal:solid14
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Cylinder 
'     .Reset 
'     .Name "solid14" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .OuterRadius "dia/2" 
'     .InnerRadius "0.0" 
'     .Axis "z" 
'     .Zrange "-diaThick", "metalThick" 
'     .Xcenter "stub-0.2-0.3-dia/2" 
'     .Ycenter "0.2+0.1+dia/2+0.2" 
'     .Segments "0" 
'     .Create 
'End With
'
''@ define cylinder: metal:solid15
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Cylinder 
'     .Reset 
'     .Name "solid15" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .OuterRadius "dia/2" 
'     .InnerRadius "0.0" 
'     .Axis "z" 
'     .Zrange "-diaThick", "metalThick" 
'     .Xcenter "stub+0.5+dia/2" 
'     .Ycenter "0.2+0.2+dia/2" 
'     .Segments "0" 
'     .Create 
'End With
'
''@ clear picks
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.ClearAllPicks
'
'@ transform: mirror via:solid12

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_10

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_10" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_11

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_11" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_12

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_12" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_13

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_13" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_14

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_14" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_15

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_15" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_16

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_16" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_17

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_17" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_18

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_18" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_19

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_19" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_2

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_2" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_20

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_20" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_3

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_3" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_4" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_5

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_5" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_6

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_6" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_7" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_8

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_8" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid12_9

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_9" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

''@ delete shape: via:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Delete "via:solid12"
'
'@ define brick: via:solid16

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid16" 
     .Component "via" 
     .Material "Copper (annealed)" 
     .Xrange "mw50/2+0.3", "mw50/2+0.3+dia" 
     .Yrange "-y/2-dia/2", "-y/2" 
     .Zrange "-diaThick-metalThick", "metalThick" 
     .Create
End With

'@ transform: mirror via:solid16

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid16" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid16

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid16" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "0", "1", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ transform: mirror via:solid16_1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid16_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "0", "1", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ delete parsweep parameter: Sequence 1:padding

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "padding" 
End With

'@ add parsweep parameter: Sequence 1:Mw50

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "Mw50", "0.2", "0.5", "11" 
End With

'@ define material: Rogers RO3003 (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material
     .Reset
     .Name "Rogers RO3003 (lossy)"
     .Folder ""
.FrqType "all" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm"
.Epsilon "3" 
.Mue "1.0" 
.Kappa "0.0" 
.TanD "0.0010" 
.TanDFreq "10.0" 
.TanDGiven "True" 
.TanDModel "ConstTanD" 
.KappaM "0.0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstKappa" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "General 1st" 
.DispersiveFittingSchemeMue "General 1st" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.Rho "0.0" 
.ThermalType "Normal" 
.ThermalConductivity "0.5" 
.SetActiveMaterial "all" 
.Colour "0.94", "0.82", "0.76" 
.Wireframe "False" 
.Transparency "0" 
.Create
End With

'@ change material: substrate:solid1 to: Rogers RO3003 (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.ChangeMaterial "substrate:solid1", "Rogers RO3003 (lossy)"

'@ define time domain solver parameters

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "1"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

''@ transform: translate via:solid12_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_1" 
'     .Vector "pitch", "0", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: translate via:solid13_8
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid13_8" 
'     .Vector "0", "pitch", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
'@ delete parsweep parameter: Sequence 1:Mw50

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Mw50" 
End With

'@ add parsweep parameter: Sequence 1:stub

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "stub", "2.3", "2.6", "4" 
End With

'@ add parsweep parameter: Sequence 1:radius

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "radius", "1.8", "2.2", "5" 
End With

''@ delete shape: via:solid13_6_5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Delete "via:solid13_6_5"
'
''@ delete shape: via:solid13_8_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Delete "via:solid13_8_1"
'
''@ transform: translate via:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12" 
'     .Vector "0", "pitch", "0" 
'     .UsePickedPoints "False" 
'     .InvertPickedPoints "False" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "9" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Translate" 
'End With
'
''@ transform: mirror via:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_1" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_2" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_3
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_3" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_4" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_5" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_6" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_7
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_7" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
''@ transform: mirror via:solid12_8
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid12_8" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "True" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
'@ transform: mirror via:solid12_9

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid12_9" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "1", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Mirror" 
End With

'@ define time domain solver parameters

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "1"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .CalculateModesOnly "True"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define material colour: Copper (annealed)

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
With Material 
     .Name "Copper (annealed)"
     .Folder ""
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "False" 
     .Transparentoutline "False" 
     .Transparency "19" 
     .ChangeColour 
End With

'@ define material colour: Rogers RO3003 (lossy)

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
With Material 
     .Name "Rogers RO3003 (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "False" 
     .Transparentoutline "False" 
     .Transparency "17" 
     .ChangeColour 
End With

'@ switch bounding box

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
Plot.DrawBox "False"

'@ switch working plane

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
Plot.DrawWorkplane "false"

'@ delete curve item: curve1:line1

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
Curve.DeleteCurveItem "curve1", "line1"

'@ define material colour: Rogers RO3003 (lossy)

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
With Material 
     .Name "Rogers RO3003 (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "False" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ define material colour: Copper (annealed)

'[VERSION]2017.1|26.0.1|20170224[/VERSION]
With Material 
     .Name "Copper (annealed)"
     .Folder ""
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With 

