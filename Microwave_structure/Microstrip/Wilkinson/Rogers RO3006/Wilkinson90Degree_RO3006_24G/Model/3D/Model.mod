'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 20 fmax = 28
'# created = '[VERSION]2015.6|24.0.2|20151030[/VERSION]


'@ use template: Antenna - Planar

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
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
End With
' optimize mesh settings for planar structures
With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
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
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy"
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
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
' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .Frequency zz_val
    .ExportFarfieldSource "False"
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

'@ define material: Rogers RO3010 (lossy)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Material
     .Reset
     .Name "Rogers RO3010 (lossy)"
     .Folder ""
.FrqType "all" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm"
.Epsilon "10.2" 
.Mue "1.0" 
.Kappa "0.0" 
.TanD "0.0022" 
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
.ThermalConductivity "0.66" 
.SetActiveMaterial "all" 
.Colour "0.94", "0.82", "0.76" 
.Wireframe "False" 
.Transparency "0" 
.Create
End With

'@ new component: substrate

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Component.New "substrate"

'@ define brick: substrate:solid1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "substrate" 
     .Material "Rogers RO3010 (lossy)" 
     .Xrange "-S_x/2", "S_x/2" 
     .Yrange "-S_y/2", "S_y/2" 
     .Zrange "-S_thick", "0" 
     .Create
End With

'@ define material: Copper (pure)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Material
     .Reset
     .Name "Copper (pure)"
     .Folder ""
.FrqType "all" 
.Type "Lossy metal" 
.MaterialUnit "Frequency", "GHz"
.MaterialUnit "Geometry", "mm"
.MaterialUnit "Time", "s"
.MaterialUnit "Temperature", "Kelvin"
.Mue "1.0" 
.Sigma "5.96e+007" 
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
.ReferenceCoordSystem "Global"
.CoordSystemType "Cartesian"
.NLAnisotropy "False"
.NLAStackingFactor "1"
.NLADirectionX "1"
.NLADirectionY "0"
.NLADirectionZ "0"
.ParticleProperty "SecondaryEmission"
.SeModel "Furman"
.SeVaughan "175", "2.25", "0", "1.0", "7.5"
.SePlot1D "True", "0", "100", "0", "1000"
.SeMaxSecondaries "10"
.SeTsParam_T1 "0.66"
.SeTsParam_T2 "0.80"
.SeTsParam_T3 "0.70"
.SeTsParam_T4 "1.00"
.SeTsParam_SEY "2.25"
.SeTsParam_Energy "175"
.SeTsParam_S "1.33"
.SeTsParam_PN "0", "1.6"
.SeTsParam_PN "1", "2.0"
.SeTsParam_PN "2", "1.8"
.SeTsParam_PN "3", "4.7"
.SeTsParam_PN "4", "1.8"
.SeTsParam_PN "5", "2.4"
.SeTsParam_PN "6", "1.8"
.SeTsParam_PN "7", "1.8"
.SeTsParam_PN "8", "2.3"
.SeTsParam_PN "9", "1.8"
.SeTsParam_EpsN "0", "3.90"
.SeTsParam_EpsN "1", "6.20"
.SeTsParam_EpsN "2", "13.00"
.SeTsParam_EpsN "3", "8.80"
.SeTsParam_EpsN "4", "6.25"
.SeTsParam_EpsN "5", "2.25"
.SeTsParam_EpsN "6", "9.20"
.SeTsParam_EpsN "7", "5.30"
.SeTsParam_EpsN "8", "17.80"
.SeTsParam_EpsN "9", "10.00"
.SeRdParam_R "1.0"
.SeRdParam_R1 "0.26"
.SeRdParam_R2 "2.0"
.SeRdParam_Q "0.4"
.SeRdParam_P1Inf "0.01"
.SeRdParam_Energy "40.0"
.SeBsParam_Sigma "1.9"
.SeBsParam_E1 "0.26"
.SeBsParam_E2 "2.0"
.SeBsParam_P1Hat "0.02"
.SeBsParam_P1Inf "0.01"
.SeBsParam_Energy "0.0"
.SeBsParam_P "0.9"
.SeBsParam_W "100.0"
.FrqType "static" 
.Type "Normal" 
.SetMaterialUnit "Hz", "mm" 
.Epsilon "1" 
.Mue "1.0" 
.Kappa "5.96e+007" 
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
.Colour "1", "1", "0" 
.Wireframe "False" 
.Reflection "False" 
.Allowoutline "True" 
.Transparentoutline "False" 
.Transparency "0" 
.Create
End With

'@ new component: ground

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Component.New "ground"

'@ define brick: ground:solid2

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "ground" 
     .Material "Copper (pure)" 
     .Xrange "-S_x/2", "S_x/2" 
     .Yrange "-S_y/2", "S_y/2" 
     .Zrange "-S_thick-M_thick", "-S_thick" 
     .Create
End With

'@ new component: top

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Component.New "top"

'@ define brick: top:solid3

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "top" 
     .Material "Copper (pure)" 
     .Xrange "-Wantenna/2", "Wantenna/2" 
     .Yrange "-S_y/2", "-r" 
     .Zrange "0", "M_thick" 
     .Create
End With

'@ pick face

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickFaceFromId "top:solid3", "3"

'@ define port: 1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.2", "0.2" 
     .Yrange "-5", "-5" 
     .Zrange "0", "0.035" 
     .XrangeAdd "W_50ohm*8", "W_50ohm*8" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "S_thick", "S_thick*8" 
     .SingleEnded "False" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ define frequency range

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solver.FrequencyRange "20", "28"

'@ define farfield monitor: farfield (f=28)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Monitor 
     .Delete "farfield (f=30)" 
End With 
With Monitor 
     .Reset 
     .Name "farfield (f=28)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "28" 
     .UseSubvolume "False" 
     .ExportFarfieldSource "False" 
     .SetSubvolume  "0.0",  "0.0",  "0.0",  "0.0",  "0.0",  "0.0" 
     .Create 
End With

'@ define monitor: e-field (f=28)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Monitor 
     .Delete "e-field (f=30)" 
End With 
With Monitor 
     .Reset 
     .Name "e-field (f=28)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .Frequency "28" 
     .UseSubvolume "False" 
     .SetSubvolume  "0.0",  "0.0",  "0.0",  "0.0",  "0.0",  "0.0" 
     .Create 
End With

'@ define monitor: h-field (f=28)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Monitor 
     .Delete "h-field (f=30)" 
End With 
With Monitor 
     .Reset 
     .Name "h-field (f=28)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .Frequency "28" 
     .UseSubvolume "False" 
     .SetSubvolume  "0.0",  "0.0",  "0.0",  "0.0",  "0.0",  "0.0" 
     .Create 
End With

'@ modify port: 1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.21", "0.21" 
     .Yrange "-5", "-5" 
     .Zrange "0", "0.034999999999999" 
     .XrangeAdd "W_50ohm*10", "W_50ohm*10" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "S_thick+M_thick", "S_thick*8" 
     .SingleEnded "False" 
     .Shield "none" 
     .Modify 
End With

''@ define brick: top:solid4
'
''[VERSION]2015.6|24.0.2|20151030[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid4" 
'     .Component "top" 
'     .Material "Copper (pure)" 
'     .Xrange "-width/2", "width/2" 
'     .Yrange "-length/2", "length/2" 
'     .Zrange "0", "M_thick" 
'     .Create
'End With
'
'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

''@ define brick: top:solid5
'
''[VERSION]2015.6|24.0.2|20151030[/VERSION]
'With Brick
'     .Reset 
'     .Name "solid5" 
'     .Component "top" 
'     .Material "Copper (pure)" 
'     .Xrange "-gap/2", "gap/2" 
'     .Yrange "-length/2", "-length/2+insert" 
'     .Zrange "0", "M_thick" 
'     .Create
'End With
'
''@ boolean subtract shapes: top:solid4, top:solid5
'
''[VERSION]2015.6|24.0.2|20151030[/VERSION]
'Solid.Subtract "top:solid4", "top:solid5"
'
'@ set parametersweep options

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
    .SetSimulationType "Transient" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:insert

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "insert", "0.1", "0.8", "8", "False" 
End With

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ switch bounding box

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Plot.DrawBox "False"

'@ switch working plane

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Plot.DrawWorkplane "false"

'@ switch bounding box

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Plot.DrawBox "True"

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ delete parsweep parameter: Sequence 1:insert

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "insert" 
End With

'@ add parsweep parameter: Sequence 1:width

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "width", "2.4", "2.8", "5", "False" 
End With

'@ edit parsweep parameter: Sequence 1:width

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "width" 
     .AddParameter_Samples "Sequence 1", "width", "2.6", "3", "5", "False" 
End With

'@ add parsweep parameter: Sequence 1:length

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "length", "1.4", "1.8", "5", "False" 
End With

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ define material: Rogers RO3006 (lossy)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Material
     .Reset
     .Name "Rogers RO3006 (lossy)"
     .Folder ""
.FrqType "all" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm"
.Epsilon "6.15" 
.Mue "1.0" 
.Kappa "0.0" 
.TanD "0.002" 
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
.ThermalConductivity "0.61" 
.SetActiveMaterial "all" 
.Colour "0.94", "0.82", "0.76" 
.Wireframe "False" 
.Transparency "0" 
.Create
End With

'@ change material: substrate:solid1 to: Rogers RO3006 (lossy)

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solid.ChangeMaterial "substrate:solid1", "Rogers RO3006 (lossy)"

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ delete parsweep parameter: Sequence 1:width

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "width" 
End With

'@ delete parsweep parameter: Sequence 1:length

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
End With

'@ add parsweep parameter: Sequence 1:insert

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "insert", "0.1", "1.2", "12", "False" 
End With

'@ delete parsweep parameter: Sequence 1:insert

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "insert" 
End With

'@ add parsweep parameter: Sequence 1:width

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "width", "3.1", "3.5", "5", "False" 
End With

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ define curve circle: curve1:circle1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Circle
     .Reset 
     .Name "circle1" 
     .Curve "curve1" 
     .Radius "r" 
     .Xcenter "0.0" 
     .Ycenter "0.0" 
     .Segments "0" 
     .Create
End With

'@ define tracefromcurve: top:solid4

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid4" 
     .Component "top" 
     .Material "Copper (pure)" 
     .Curve "curve1:circle1" 
     .Thickness "M_thick" 
     .Width "W_70ohm" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .GapType "2" 
     .Create 
End With

'@ define curve line: curve1:line1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "0.0" 
     .Y1 "0.0" 
     .X2 "0.0" 
     .Y2 "1" 
     .Create
End With

'@ define tracefromcurve: top:solid5

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid5" 
     .Component "top" 
     .Material "Copper (pure)" 
     .Curve "curve1:line1" 
     .Thickness "M_thick" 
     .Width "0.4" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .GapType "2" 
     .Create 
End With

'@ boolean subtract shapes: top:solid4, top:solid5

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solid.Subtract "top:solid4", "top:solid5"

'@ define curve polygon: curve1:polygon1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "0.2+W_50ohm/2", "0" 
     .RLine "0", "r+0.6" 
     .RLine "S_x/2-0.2-W_50ohm/2", "0" 
     .Create 
End With

'@ define tracefromcurve: top:solid5

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid5" 
     .Component "top" 
     .Material "Copper (pure)" 
     .Curve "curve1:polygon1" 
     .Thickness "M_thick" 
     .Width "W_50ohm" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .GapType "2" 
     .Create 
End With

'@ define cylinder: top:solid6

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid6" 
     .Component "top" 
     .Material "Copper (pure)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "M_thick" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ transform: mirror top:solid5

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Transform 
     .Reset 
     .Name "top:solid5" 
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

'@ boolean insert shapes: top:solid5, top:solid6

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solid.Insert "top:solid5", "top:solid6"

'@ boolean subtract shapes: top:solid5_1, top:solid6

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solid.Subtract "top:solid5_1", "top:solid6"

'@ pick edge

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickEdgeFromId "top:solid5", "4", "5"

'@ chamfer edges of: top:solid5

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solid.ChamferEdge "edge", "45", "False", "5"

'@ pick edge

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickEdgeFromId "top:solid5_1", "4", "5"

'@ chamfer edges of: top:solid5_1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Solid.ChamferEdge "edge", "45", "False", "12"

'@ pick face

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickFaceFromId "top:solid5", "6"

'@ define port: 2

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "5", "5" 
     .Yrange "0.9304458598726", "1.2504458598726" 
     .Zrange "0", "0.035" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "W_50ohm*8", "W_50ohm*8" 
     .ZrangeAdd "-S_thick", "S_thick*8" 
     .SingleEnded "False" 
     .Create 
End With

'@ modify port: 2

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "5", "5" 
     .Yrange "0.930446", "1.250446" 
     .Zrange "0", "0.035" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "W_50ohm*8", "W_50ohm*8" 
     .ZrangeAdd "S_thick", "S_thick*8" 
     .SingleEnded "False" 
     .Shield "none" 
     .Modify 
End With

'@ pick face

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickFaceFromId "top:solid5_1", "6"

'@ define port: 3

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Port 
     .Reset 
     .PortNumber "3" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-5", "-5" 
     .Yrange "0.9304458598726", "1.2504458598726" 
     .Zrange "0", "0.035" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "W_50ohm*8", "W_50ohm*8" 
     .ZrangeAdd "S_thick", "S_thick*8" 
     .SingleEnded "False" 
     .Create 
End With

'@ pick end point

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickEndpointFromId "top:solid4", "1"

'@ pick end point

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.PickEndpointFromId "top:solid4", "6"

'@ define lumped element: Folder1:element1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With LumpedElement
     .Reset 
     .SetName "element1" 
     .Folder "Folder1" 
     .SetType "RLCSerial" 
     .SetR  "100" 
     .SetL  "0" 
     .SetC  "0" 
     .SetGs "0" 
     .SetI0 "1e-14" 
     .SetT  "300" 
     .SetP1 "True", "0.2", "0.36983066541867", "0" 
     .SetP2 "True", "-0.2", "0.36983066541867", "0" 
     .SetInvert "False" 
     .SetMonitor "True" 
     .SetRadius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create
End With

'@ transform lumped element: translate Folder1

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
With Transform 
     .Reset 
     .Name "Folder1" 
     .Vector "0", "0.2", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "LumpedElement", "Translate" 
End With

'@ define time domain solver parameters

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
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

'@ clear picks

'[VERSION]2015.6|24.0.2|20151030[/VERSION]
Pick.ClearAllPicks 

