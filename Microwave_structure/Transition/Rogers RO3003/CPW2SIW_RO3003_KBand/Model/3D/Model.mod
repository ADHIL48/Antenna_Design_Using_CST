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

'@ define brick: metal:solid2

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Xrange "-x/2", "x/2" 
     .Yrange "-y/2-dia/2", "y/2+dia/2" 
     .Zrange "0", "metalThick" 
     .Create
End With

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

'@ new component: via

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Component.New "via"

'@ define cylinder: via:solid4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid4" 
     .Component "via" 
     .Material "Copper (annealed)" 
     .OuterRadius "dia/2" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-diaThick-metalThick", "metalThick" 
     .Xcenter "width/2" 
     .Ycenter "-y/2" 
     .Segments "0" 
     .Create 
End With

'@ rename block: via:solid4 to: via:v1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Rename "via:solid4", "v1"

'@ transform: translate via

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via" 
     .Vector "-width", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ rename block: via:v1_1 to: via:v2

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Rename "via:v1_1", "v2"

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
     .Repetitions "30" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid1", "3"
'
''@ define extrude: via:solid4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid4" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid2", "3"
'
''@ define extrude: via:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid5" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid3", "3"
'
''@ define extrude: via:solid6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid6" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ paste structure data: 1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With SAT 
'     .Reset 
'     .FileName "*1.cby" 
'     .SubProjectScaleFactor "0.001" 
'     .ImportToActiveCoordinateSystem "True" 
'     .ScaleToUnit "True" 
'     .Curves "False" 
'     .Read 
'End With
'
''@ boolean subtract shapes: via:v1, via:solid6_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v1", "via:solid6_1"
'
''@ boolean subtract shapes: via:v1, via:solid5_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v1", "via:solid5_1"
'
''@ boolean subtract shapes: via:v1, via:solid4_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v1", "via:solid4_1"
'
''@ boolean subtract shapes: via:v2, via:solid4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v2", "via:solid4"
'
''@ boolean subtract shapes: via:v2, via:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v2", "via:solid5"
'
''@ boolean subtract shapes: via:v2, via:solid6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v2", "via:solid6"
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid1", "3"
'
''@ define port: 1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Port 
'     .Reset 
'     .PortNumber "1" 
'     .Label "" 
'     .NumberOfModes "1" 
'     .AdjustPolarization "False" 
'     .PolarizationAngle "0.0" 
'     .ReferencePlaneDistance "0" 
'     .TextSize "50" 
'     .TextMaxLimit "0" 
'     .Coordinates "Picks" 
'     .Orientation "positive" 
'     .PortOnBound "True" 
'     .ClipPickedPortToBound "False" 
'     .Xrange "-10", "10" 
'     .Yrange "-9", "-9" 
'     .Zrange "-0.508", "0" 
'     .XrangeAdd "0.0", "0.0" 
'     .YrangeAdd "0.0", "0.0" 
'     .ZrangeAdd "0.0", "0.0" 
'     .SingleEnded "False" 
'     .Create 
'End With
'
''@ define time domain solver parameters
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Mesh.SetCreator "High Frequency" 
'With Solver 
'     .Method "Hexahedral"
'     .CalculationType "TD-S"
'     .StimulationPort "All"
'     .StimulationMode "All"
'     .SteadyStateLimit "-30.0"
'     .MeshAdaption "False"
'     .AutoNormImpedance "False"
'     .NormingImpedance "50"
'     .CalculateModesOnly "True"
'     .SParaSymmetry "False"
'     .StoreTDResultsInCache  "False"
'     .FullDeembedding "False"
'     .SuperimposePLWExcitation "False"
'     .UseSensitivityAnalysis "False"
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid1", "5"
'
''@ define extrude: via:solid4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid4" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid2", "5"
'
''@ define extrude: via:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid5" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid3", "5"
'
''@ define extrude: via:solid6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid6" 
'     .Component "via" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ paste structure data: 2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With SAT 
'     .Reset 
'     .FileName "*2.cby" 
'     .SubProjectScaleFactor "0.001" 
'     .ImportToActiveCoordinateSystem "True" 
'     .ScaleToUnit "True" 
'     .Curves "False" 
'     .Read 
'End With
'
''@ boolean subtract shapes: via:v1_30, via:solid4_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v1_30", "via:solid4_1"
'
''@ boolean subtract shapes: via:v1_30, via:solid5_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v1_30", "via:solid5_1"
'
''@ boolean subtract shapes: via:v1_30, via:solid6_1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v1_30", "via:solid6_1"
'
''@ boolean subtract shapes: via:v2_30, via:solid4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v2_30", "via:solid4"
'
''@ boolean subtract shapes: via:v2_30, via:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v2_30", "via:solid5"
'
''@ boolean subtract shapes: via:v2_30, via:solid6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Solid.Subtract "via:v2_30", "via:solid6"
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid1", "5"
'
''@ define port: 2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Port 
'     .Reset 
'     .PortNumber "2" 
'     .Label "" 
'     .NumberOfModes "1" 
'     .AdjustPolarization "False" 
'     .PolarizationAngle "0.0" 
'     .ReferencePlaneDistance "0" 
'     .TextSize "50" 
'     .TextMaxLimit "0" 
'     .Coordinates "Picks" 
'     .Orientation "positive" 
'     .PortOnBound "True" 
'     .ClipPickedPortToBound "False" 
'     .Xrange "-10", "10" 
'     .Yrange "9", "9" 
'     .Zrange "-0.508", "0" 
'     .XrangeAdd "0.0", "0.0" 
'     .YrangeAdd "0.0", "0.0" 
'     .ZrangeAdd "0.0", "0.0" 
'     .SingleEnded "False" 
'     .Create 
'End With
'
''@ define time domain solver parameters
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Mesh.SetCreator "High Frequency" 
'With Solver 
'     .Method "Hexahedral"
'     .CalculationType "TD-S"
'     .StimulationPort "All"
'     .StimulationMode "All"
'     .SteadyStateLimit "-30.0"
'     .MeshAdaption "False"
'     .AutoNormImpedance "False"
'     .NormingImpedance "50"
'     .CalculateModesOnly "False"
'     .SParaSymmetry "False"
'     .StoreTDResultsInCache  "False"
'     .FullDeembedding "True"
'     .SuperimposePLWExcitation "False"
'     .UseSensitivityAnalysis "False"
'End With
'
''@ delete port: port1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Port.Delete "1"
'
''@ delete port: port2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Port.Delete "2"
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "via:v1_30", "18"
'
''@ define extrude: metal:solid4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid4" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "via:v2_30", "18"
'
''@ define extrude: metal:solid5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid5" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid2", "5"
'
''@ define extrude: metal:solid6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid6" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid3", "5"
'
''@ define extrude: metal:solid7
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid7" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid1", "5"
'
''@ define extrude: substrate:solid8
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid8" 
'     .Component "substrate" 
'     .Material "Rogers RO4350B (lossy)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid8", "5"
'
''@ define port: 1
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Port 
'     .Reset 
'     .PortNumber "1" 
'     .Label "" 
'     .NumberOfModes "1" 
'     .AdjustPolarization "False" 
'     .PolarizationAngle "0.0" 
'     .ReferencePlaneDistance "0" 
'     .TextSize "50" 
'     .TextMaxLimit "0" 
'     .Coordinates "Picks" 
'     .Orientation "positive" 
'     .PortOnBound "True" 
'     .ClipPickedPortToBound "False" 
'     .Xrange "-10", "10" 
'     .Yrange "9.2", "9.2" 
'     .Zrange "-0.508", "0" 
'     .XrangeAdd "0.0", "0.0" 
'     .YrangeAdd "0.0", "0.0" 
'     .ZrangeAdd "0.0", "0.0" 
'     .SingleEnded "False" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "via:v2", "18"
'
''@ define extrude: metal:solid9
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid9" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "via:v1", "12"
'
''@ define extrude: metal:solid10
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid10" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid2", "3"
'
''@ define extrude: metal:solid11
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid11" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "metal:solid3", "3"
'
''@ define extrude: metal:solid12
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid12" 
'     .Component "metal" 
'     .Material "Copper (annealed)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid1", "3"
'
''@ define extrude: substrate:solid13
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Extrude 
'     .Reset 
'     .Name "solid13" 
'     .Component "substrate" 
'     .Material "Rogers RO4350B (lossy)" 
'     .Mode "Picks" 
'     .Height "dia/2" 
'     .Twist "0.0" 
'     .Taper "0.0" 
'     .UsePicksForHeight "False" 
'     .DeleteBaseFaceSolid "False" 
'     .ClearPickedFace "True" 
'     .Create 
'End With
'
''@ pick face
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'Pick.PickFaceFromId "substrate:solid13", "5"
'
''@ define port: 2
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Port 
'     .Reset 
'     .PortNumber "2" 
'     .Label "" 
'     .NumberOfModes "1" 
'     .AdjustPolarization "False" 
'     .PolarizationAngle "0.0" 
'     .ReferencePlaneDistance "0" 
'     .TextSize "50" 
'     .TextMaxLimit "0" 
'     .Coordinates "Picks" 
'     .Orientation "positive" 
'     .PortOnBound "True" 
'     .ClipPickedPortToBound "False" 
'     .Xrange "-10", "10" 
'     .Yrange "-9.2", "-9.2" 
'     .Zrange "-0.508", "0" 
'     .XrangeAdd "0.0", "0.0" 
'     .YrangeAdd "0.0", "0.0" 
'     .ZrangeAdd "0.0", "0.0" 
'     .SingleEnded "False" 
'     .Create 
'End With
'
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

'@ add parsweep parameter: Sequence 1:width

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "width", "3", "5.72", "6" 
End With

'@ set parsweep options

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .ResetOptions
     .SetOptionResetParameterValuesAfterRun "True" 
     .SetOptionSkipExistingCombinations "True" 
     .SetOptionMoveMesh "False" 
     .SaveOptions
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
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define boundaries

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "electric"
     .Zmax "electric"
     .Xsymmetry "magnetic"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
End With

'@ delete parsweep parameter: Sequence 1:width

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "width" 
End With

'@ add parsweep parameter: Sequence 1:p

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "p", "1.5", "2.5", "6" 
End With

'@ define brick: via:solid4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "via" 
     .Material "Copper (annealed)" 
     .Xrange "width/2-dia/2", "width/2+dia/2" 
     .Yrange "-y/2", "-y/2-dia/2" 
     .Zrange "-diaThick-metalThick", "metalThick" 
     .Create
End With

'@ transform: translate via:solid4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid4" 
     .Vector "-width", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: mirror via:solid4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid4" 
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

'@ transform: mirror via:solid4_1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid4_1" 
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

'@ pick face

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Pick.PickFaceFromId "substrate:solid1", "3"

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
     .Xrange "-10", "10" 
     .Yrange "-12.2", "-12.2" 
     .Zrange "-0.508", "0" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ pick face

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Pick.PickFaceFromId "substrate:solid1", "5"

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
     .PortOnBound "True" 
     .ClipPickedPortToBound "False" 
     .Xrange "-10", "10" 
     .Yrange "12.2", "12.2" 
     .Zrange "-0.508", "0" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ clear picks

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Pick.ClearAllPicks

'@ switch working plane

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Plot.DrawWorkplane "false"

'@ define material colour: Rogers RO4350B (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material 
     .Name "Rogers RO4350B (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "14" 
     .ChangeColour 
End With

'@ define material colour: Copper (annealed)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
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

'@ define material colour: Rogers RO4350B (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material 
     .Name "Rogers RO4350B (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ switch working plane

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Plot.DrawWorkplane "true"

'@ delete shapes

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Delete "via:v1_16" 
Solid.Delete "via:v1_17" 
Solid.Delete "via:v1_18" 
Solid.Delete "via:v1_19" 
Solid.Delete "via:v1_20" 
Solid.Delete "via:v1_21" 
Solid.Delete "via:v1_22" 
Solid.Delete "via:v1_23" 
Solid.Delete "via:v1_24" 
Solid.Delete "via:v1_25" 
Solid.Delete "via:v1_26" 
Solid.Delete "via:v1_27" 
Solid.Delete "via:v1_28" 
Solid.Delete "via:v1_29" 
Solid.Delete "via:v1_30"

'@ delete shapes

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Delete "via:v2_16" 
Solid.Delete "via:v2_17" 
Solid.Delete "via:v2_18" 
Solid.Delete "via:v2_19" 
Solid.Delete "via:v2_20" 
Solid.Delete "via:v2_21" 
Solid.Delete "via:v2_22" 
Solid.Delete "via:v2_23" 
Solid.Delete "via:v2_24" 
Solid.Delete "via:v2_25" 
Solid.Delete "via:v2_26" 
Solid.Delete "via:v2_27" 
Solid.Delete "via:v2_28" 
Solid.Delete "via:v2_29" 
Solid.Delete "via:v2_30"

'@ delete shapes

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Delete "via:solid4_1_1" 
Solid.Delete "via:solid4_2"

'@ delete shapes

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Delete "via:v1_11" 
Solid.Delete "via:v1_12" 
Solid.Delete "via:v1_13" 
Solid.Delete "via:v1_14" 
Solid.Delete "via:v1_15"

'@ delete shapes

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Delete "via:v2_11" 
Solid.Delete "via:v2_12" 
Solid.Delete "via:v2_13" 
Solid.Delete "via:v2_14" 
Solid.Delete "via:v2_15"

'@ define curve line: curve1:line1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "-0" 
     .Y1 "dia/2+0.2+transL" 
     .X2 "0" 
     .Y2 "y/2+dia/2" 
     .Create
End With

'@ define curve polygon: curve1:polygon1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "transW/2", "dia/2+0.2" 
     .LineTo "Mw50/2", "dia/2+0.2+transL" 
     .LineTo "-Mw50/2", "dia/2+0.2+transL" 
     .LineTo "-transW/2", "dia/2+0.2" 
     .LineTo "transW/2", "dia/2+0.2" 
     .Create 
End With

'@ define tracefromcurve: metal:solid5

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid5" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Curve "curve1:line1" 
     .Thickness "MetalThick" 
     .Width "Mw50" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .GapType "2" 
     .Create 
End With

'@ define extrudeprofile: metal:solid6

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "solid6" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Thickness "MetalThick" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ delete port: port2

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Port.Delete "2"

'@ pick face

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Pick.PickFaceFromId "metal:solid5", "2"

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
     .PortOnBound "True" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.26", "0.26" 
     .Yrange "6.15", "6.15" 
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

'@ delete parsweep parameter: Sequence 1:p

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "p" 
End With

'@ add parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transL", "1", "4", "10" 
End With

'@ add parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transW", "0.52", "4", "6" 
End With

'@ delete parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
End With

'@ delete parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transW" 
End With

'@ add parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transL", "2", "2.6", "4" 
End With

'@ add parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transW", "1", "1.4", "4" 
End With

'@ edit parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
     .AddParameter_Linear "Sequence 1", "transL", "1", "2.4", "10" 
End With

'@ edit parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transW" 
     .AddParameter_Linear "Sequence 1", "transW", "0.6", "1", "5" 
End With

'@ edit parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
     .AddParameter_Linear "Sequence 1", "transL", "0.5", "2.4", "10" 
End With

'@ define curve line: curve1:line1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "0" 
     .Y1 "dia/2+0.2+transL" 
     .X2 "0.0" 
     .Y2 "y/2+dia/2" 
     .Create
End With

'@ define tracefromcurve: metal:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid7" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Curve "curve1:line1" 
     .Thickness "MetalThick" 
     .Width "mw50+0.4" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .GapType "2" 
     .Create 
End With

'@ boolean subtract shapes: metal:solid2, metal:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Subtract "metal:solid2", "metal:solid7"

'@ define curve polygon: curve1:polygon1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "width/2-dia/2-0.2", "dia/2+0.2" 
     .LineTo "mw50/2+0.2", "dia/2+0.2+transL" 
     .RLine "-mw50-0.4", "0" 
     .LineTo "-width/2+dia/2+0.2", "dia/2+0.2" 
     .RLine "width-dia-0.4", "0" 
     .Create 
End With

'@ define extrudeprofile: metal:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "solid7" 
     .Component "metal" 
     .Material "Copper (annealed)" 
     .Thickness "metalThick" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ boolean subtract shapes: metal:solid2, metal:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Solid.Subtract "metal:solid2", "metal:solid7"

'@ define cylinder: via:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid7" 
     .Component "via" 
     .Material "Copper (annealed)" 
     .OuterRadius "dia/2" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-diaThick", "metalThick" 
     .Xcenter "mw50/2+0.2+0.2+dia/2" 
     .Ycenter "y/2" 
     .Segments "0" 
     .Create 
End With

'@ define brick: via:solid8

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Brick
     .Reset 
     .Name "solid8" 
     .Component "via" 
     .Material "Copper (annealed)" 
     .Xrange "mw50/2+0.4", "mw50/2+0.4+dia" 
     .Yrange "y/2", "y/2+dia/2" 
     .Zrange "-diaThick", "metalThick" 
     .Create
End With

'@ transform: mirror via:solid8

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid8" 
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

'@ transform: mirror via:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid7" 
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

'@ transform: translate via:solid7

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid7" 
     .Vector "0", "-pitch", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "5" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate via:solid7_1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid7_1" 
     .Vector "0", "-pitch", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "3" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
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
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ transform: translate via:v1_10

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v1_10" 
     .Vector "0", "pitch", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "True" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate via:v2_10

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v2_10" 
     .Vector "0", "pitch", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate via:v1_10_1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v1_10_1" 
     .Vector "-pitch*ratio", "pitch*ratio1", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "4" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: mirror via:v1_10_1_1

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v1_10_1_1" 
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

'@ transform: mirror via:v1_10_1_2

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v1_10_1_2" 
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

'@ transform: mirror via:v1_10_1_3

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v1_10_1_3" 
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

''@ transform: mirror via:v1_10_1_4
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:v1_10_1_4" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
'@ delete parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
End With

'@ delete parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transW" 
End With

'@ add parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transL", "2.2", "2.6", "5" 
End With

'@ add parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transW", "0.8", "1.2", "5" 
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
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ delete parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
End With

'@ delete parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transW" 
End With

'@ add parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transW", "0.9", "1.3", "5" 
End With

'@ add parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transL", "2", "2.4", "5" 
End With

'@ delete parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transW" 
End With

'@ edit parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
     .AddParameter_Linear "Sequence 1", "transL", "1.5", "2.5", "5" 
End With

'@ add parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transW", "0.5", "3", "10" 
End With

'@ edit parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
     .AddParameter_Linear "Sequence 1", "transL", "1.5", "2.5", "10" 
End With

''@ transform: mirror via:solid7_1_6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid7_1_6" 
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
''@ transform: mirror via:solid7_1_7
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:solid7_1_7" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
'@ transform: mirror via:v1_10_1_4

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:v1_10_1_4" 
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

''@ transform: mirror via:v1_10_1_5
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:v1_10_1_5" 
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
''@ transform: mirror via:v1_10_1_6
'
''[VERSION]2016.7|25.0.2|20161111[/VERSION]
'With Transform 
'     .Reset 
'     .Name "via:v1_10_1_6" 
'     .Origin "Free" 
'     .Center "0", "0", "0" 
'     .PlaneNormal "1", "0", "0" 
'     .MultipleObjects "True" 
'     .GroupObjects "False" 
'     .Repetitions "1" 
'     .MultipleSelection "False" 
'     .Destination "" 
'     .Material "" 
'     .Transform "Shape", "Mirror" 
'End With
'
'@ transform: mirror via:solid7_5

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid7_5" 
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

'@ transform: mirror via:solid7_6

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Transform 
     .Reset 
     .Name "via:solid7_6" 
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

'@ delete parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transL" 
End With

'@ delete parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "transW" 
End With

'@ add parsweep parameter: Sequence 1:transW

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transW", "1.1", "1.5", "5" 
End With

'@ add parsweep parameter: Sequence 1:transL

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With ParameterSweep
     .AddParameter_Linear "Sequence 1", "transL", "1.8", "2.2", "5" 
End With

'@ define material colour: Copper (annealed)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material 
     .Name "Copper (annealed)"
     .Folder ""
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "False" 
     .Transparentoutline "False" 
     .Transparency "25" 
     .ChangeColour 
End With

'@ define material colour: Rogers RO4350B (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material 
     .Name "Rogers RO4350B (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "False" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ switch working plane

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Plot.DrawWorkplane "false"

'@ switch bounding box

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
Plot.DrawBox "False"

'@ define material colour: Copper (annealed)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
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

'@ define material colour: Rogers RO4350B (lossy)

'[VERSION]2016.7|25.0.2|20161111[/VERSION]
With Material 
     .Name "Rogers RO4350B (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With 

