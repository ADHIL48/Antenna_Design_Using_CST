'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 0 fmax = 3
'# created = '[VERSION]2019.0|28.0.2|20180920[/VERSION]


'@ use template: Antenna - Planar_6.cfg

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
End With
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
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
With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With
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
'----------------------------------------------------------------------------

'@ define material: Copper (annealed)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "Copper (annealed)"
     .Folder ""
.FrqType "static"
.Type "Normal"
.SetMaterialUnit "Hz", "mm"
.Epsilon "1"
.Mu "1.0"
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
.DispModelMu "None"
.DispersiveFittingSchemeEps "Nth Order"
.DispersiveFittingSchemeMu "Nth Order"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.FrqType "all"
.Type "Lossy metal"
.SetMaterialUnit "GHz", "mm"
.Mu "1.0"
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

'@ new component: component1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Component.New "component1"

'@ define cylinder: component1:reflector

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "reflector" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-(h/2)*1.05", "(h/2)*1.08" 
     .Xcenter "0" 
     .Ycenter "-sp" 
     .Segments "0" 
     .Create 
End With

'@ delete shape: component1:reflector

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Delete "component1:reflector"

'@ define cylinder: component1:reflector

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "reflector" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-(h/2)*1.08", "(h/2)*1.08" 
     .Xcenter "0" 
     .Ycenter "sp" 
     .Segments "0" 
     .Create 
End With 


'@ define cylinder: component1:active

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "active" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-h/2", "h/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:dir1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "dir1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-(h/2)*0.98", "(h/2)*0.98" 
     .Xcenter "0" 
     .Ycenter "-sp" 
     .Segments "0" 
     .Create 
End With 


'@ define cylinder: component1:dir2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "dir2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "(-h/2)*0.98", "(h/2)*0.98" 
     .Xcenter "0" 
     .Ycenter "-2*sp" 
     .Segments "0" 
     .Create 
End With 


'@ define brick: component1:brick

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "brick" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-s/2", "s/2" 
     .Yrange "-s/2", "s/2" 
     .Zrange "-s/2", "s/2" 
     .Create
End With

'@ boolean subtract shapes: component1:active, component1:brick

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:active", "component1:brick"

'@ pick circle center point

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickCirclecenterFromId "component1:active", "15"

'@ pick circle center point

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickCirclecenterFromId "component1:active", "16"

'@ define discrete port: 1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "1" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .Voltage "1.0" 
     .Current "1.0" 
     .SetP1 "True", "0", "0", "3.35" 
     .SetP2 "True", "0", "0", "-3.35" 
     .InvertDirection "False" 
     .LocalCoordinates "False" 
     .Monitor "True" 
     .Radius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create 
End With

'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "0", "3"

'@ define farfield monitor: farfield (f=2.5)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.5)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.5" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-0.9", "0.9", "-60.9", "30.9", "-31.5", "31.5" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
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

'@ set PBA version

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Discretizer.PBAVersion "2018092019"

