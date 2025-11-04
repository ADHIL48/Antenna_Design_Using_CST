'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 1 fmax = 3


'@ use template: Antenna (Planar)

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
' Template for Antenna in Free Space
' ==================================
' (CSTxMWSxONLY)
' draw the bounding box
Plot.DrawBox True
' set units to mm, ghz
With Units 
     .Geometry "mm" 
     .Frequency "ghz" 
     .Time "ns" 
End With 
' set background material to vacuum
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
' set boundary conditions to open
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
MeshSettings.SetMeshType "HexTLM" 
With MeshSettings 
     .Set "RatioLimitGeometry", "20" 
End With 
' change mesh adaption scheme to energy 
' 		(planar structures tend to store high energy 
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy" 
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"

'@ define material: FR4

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Material 
     .Reset 
     .Name "FR4"
     .Folder ""
     .FrqType "all"
     .Type "Normal"
     .SetMaterialUnit "GHz", "mm"
     .Epsilon "4.6"
     .Mue "1"
     .ThinPanel "False"
     .Thickness "0"
     .Kappa "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .ConstTanDModelOrderEps "1"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .KappaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .ConstTanDModelOrderMue "1"
     .DispModelEps  "None"
     .DispModelMue "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMue "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMue "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Unused"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ new component: component1

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Component.New "component1"

'@ define brick: component1:solid1

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "FR4" 
     .Xrange "-(width2/2+sp+gnd_w+10)", "width2/2+sp+gnd_w+10" 
     .Yrange "0", "gap+length+10" 
     .Zrange "-1", "0" 
     .Create
End With

'@ define background

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0.0" 
     .ZmaxSpace "0.0" 
     .ApplyInAllDirections "False" 
End With 
With Material 
     .Reset 
     .FrqType "all"
     .Type "Normal"
     .SetMaterialUnit "Hz", "m"
     .Epsilon "1.0"
     .Mue "1.0"
     .ThinPanel "False"
     .Thickness "0"
     .Kappa "0.0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstKappa"
     .ConstTanDModelOrderEps "1"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .KappaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstKappa"
     .ConstTanDModelOrderMue "1"
     .DispModelEps  "None"
     .DispModelMue "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMue "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMue "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.0"
     .HeatCapacity "0.0"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Unused"
     .Colour "0.6", "0.6", "0.6" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeBackgroundMaterial
End With

'@ define frequency range

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Solver.FrequencyRange "1", "2"

'@ define brick: component1:solid2

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-width/2", "width/2" 
     .Yrange "gap", "gap+length" 
     .Zrange "0", "0.018" 
     .Create
End With

'@ define brick: component1:solid3

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-width2/2", "width2/2" 
     .Yrange "0", "gap" 
     .Zrange "0", "0.018" 
     .Create
End With

'@ define brick: component1:solid4

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "width2/2+sp", "width2/2+sp+gnd_w" 
     .Yrange "0", "gnd_h" 
     .Zrange "0", "0.018" 
     .Create
End With

'@ transform: mirror component1:solid4

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
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

'@ define cylinder: component1:solid5

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid5" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "coax_in/2" 
     .InnerRadius "0.0" 
     .Axis "y" 
     .Yrange "-10", "4" 
     .Xcenter "0" 
     .Zcenter "coax_in/2" 
     .Segments "0" 
     .Create 
End With

'@ define material: Teflon (PTFE) (loss free)

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Material
     .Reset
     .Name "Teflon (PTFE) (loss free)"
     .Folder ""
.FrqType "all" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.1" 
.Mue "1.0" 
.Kappa "0.0" 
.TanD "0.0" 
.TanDFreq "0.0" 
.TanDGiven "False" 
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
.Rho "2200.0" 
.ThermalType "Normal" 
.ThermalConductivity "0.2"
.HeatCapacity "1.0"
.SetActiveMaterial "all" 
.MechanicsType "Isotropic"
.YoungsModulus "0.5"
.PoissonsRatio "0.4"
.ThermalExpansionRate "140"
.Colour "0.75", "0.95", "0.85" 
.Wireframe "False" 
.Transparency "0" 
.Create
End With

'@ define cylinder: component1:solid6

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid6" 
     .Component "component1" 
     .Material "Teflon (PTFE) (loss free)" 
     .OuterRadius "coax_out/2" 
     .InnerRadius "0.0" 
     .Axis "y" 
     .Yrange "-10", "0" 
     .Xcenter "0" 
     .Zcenter "coax_in/2" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid7

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid7" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "coax_out/2+0.5" 
     .InnerRadius "0.0" 
     .Axis "y" 
     .Yrange "-10", "0" 
     .Xcenter "0" 
     .Zcenter "coax_in/2" 
     .Segments "0" 
     .Create 
End With

'@ boolean insert shapes: component1:solid7, component1:solid6

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solid 
     .Version 9
     .Insert "component1:solid7", "component1:solid6" 
     .Version 1
End With

'@ boolean insert shapes: component1:solid6, component1:solid5

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solid 
     .Version 9
     .Insert "component1:solid6", "component1:solid5" 
     .Version 1
End With

'@ define brick: component1:solid8

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Brick
     .Reset 
     .Name "solid8" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-3", "3" 
     .Yrange "-1", "0" 
     .Zrange "-3", "3" 
     .Create
End With

'@ transform: translate component1:solid8

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid8" 
     .Vector "0", "0", "coax_in/2" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With

'@ boolean insert shapes: component1:solid8, component1:solid5

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solid 
     .Version 9
     .Insert "component1:solid8", "component1:solid5" 
     .Version 1
End With

'@ boolean insert shapes: component1:solid8, component1:solid6

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solid 
     .Version 9
     .Insert "component1:solid8", "component1:solid6" 
     .Version 1
End With

'@ boolean insert shapes: component1:solid8, component1:solid7

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solid 
     .Version 9
     .Insert "component1:solid8", "component1:solid7" 
     .Version 1
End With

'@ define brick: component1:solid9

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Brick
     .Reset 
     .Name "solid9" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-coax_in/3", "coax_in/3" 
     .Yrange "0", "4" 
     .Zrange "0", "coax_in" 
     .Create
End With

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ transform: translate component1:solid9

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid9" 
     .Vector "2.6", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ transform: mirror component1:solid9

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid9" 
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

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ pick face

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.PickFaceFromId "component1:solid7", "4"

'@ define port: 1

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
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
     .Xrange "-2.5", "2.5" 
     .Yrange "-10", "-10" 
     .Zrange "-1.935", "3.065" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
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

'@ set pba mesh type

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Mesh.MeshType "PBA"

'@ define time domain solver parameters

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
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

'@ define farfield monitor: farfield (f=1.575)

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=1.575)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "1.575" 
     .UseSubvolume "False" 
     .SetSubvolume  "-155",  "155",  "-85",  "155",  "-77.435",  "78.565" 
     .Create 
End With

'@ define monitor: e-field (f=1.575)

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=1.575)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .Frequency "1.575" 
     .Create 
End With

'@ define monitor: h-field (f=1.575)

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=1.575)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .Frequency "1.575" 
     .Create 
End With

'@ define frequency range

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Solver.FrequencyRange "1", "2"

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "20" 
     .MinimumStepNumber "5" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "20" 
     .MinimumStepNumber "10" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "25" 
     .MinimumStepNumber "10" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ define automesh parameters

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .AutomeshStraightLines "True" 
     .AutomeshEllipticalLines "True" 
     .AutomeshRefineAtPecLines "True", "6" 
     .AutomeshRefinePecAlongAxesOnly "False" 
     .AutomeshAtEllipseBounds "True", "10" 
     .AutomeshAtWireEndPoints "True" 
     .AutomeshAtProbePoints "True" 
     .SetAutomeshRefineDielectricsType "Generalized" 
     .MergeThinPECLayerFixpoints "True" 
     .EquilibrateMesh "False" 
     .EquilibrateMeshRatio "1.19" 
     .UseCellAspectRatio "False" 
     .CellAspectRatio "50.0" 
     .UsePecEdgeModel "True" 
     .MeshType "PBA" 
     .AutoMeshLimitShapeFaces "True" 
     .AutoMeshNumberOfShapeFaces "1000" 
     .PointAccEnhancement "0" 
     .SurfaceOptimization "True" 
     .SurfaceSmoothing "3" 
     .MinimumCurvatureRefinement "100" 
     .CurvatureRefinementFactor "0.05" 
     .AnisotropicCurvatureRefinement "True" 
     .SmallFeatureSize "0.0" 
     .SurfaceTolerance "0.0" 
     .SurfaceToleranceType "Relative" 
     .NormalTolerance "22.5" 
     .AnisotropicCurvatureRefinementFSM "True" 
     .SurfaceMeshEnrichment "0" 
     .DensityTransitionsFSM "0.5" 
     .VolumeOptimization "True" 
     .VolumeSmoothing "True" 
     .VolumeMeshMethod "Delaunay" 
     .SurfaceMeshMethod "General" 
     .SurfaceMeshGeometryAccuracy "1.0e-6" 
     .DelaunayOptimizationLevel "2" 
     .DelaunayPropagationFactor "1.050000" 
     .DensityTransitions "0.5" 
     .MeshAllRegions "False" 
     .ConvertGeometryDataAfterMeshing "True" 
     .AutomeshFixpointsForBackground "True" 
     .PBAType "Fast PBA" 
     .AutomaticPBAType "False" 
     .DetectSmallSolidPEC "False" 
     .ConsiderSpaceForLowerMeshLimit "False" 
     .RatioLimitGovernsLocalRefinement "False" 
     .GapDetection "False" 
     .FPBAGapTolerance "1e-3" 
     .SetMaxParallelMesherThreads "Hex", "8"
     .SetParallelMesherMode "Hex", "Maximum"
     .AutomeshRefineThermalMaterials "False" 
     .SetThermalRefinementConductivityReference "1e-3" 
     .SetThermalRefinementHeatCapacityReference "1e-3" 
     .SetParallelMesherMode "Tet", "maximum" 
     .SetMaxParallelMesherThreads "Tet", "1" 
     .ConnectivityCheck "False"
     .SelfIntersectingCheck "True"
     .FPBAAccuracyEnhancement "enable"
     .FastPBAAccuracy "3"
End With 
With Solver 
     .UseSplitComponents "True" 
     .PBAFillLimit "99" 
     .EnableSubgridding "False" 
     .AlwaysExcludePec "False" 
End With

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "20" 
     .MinimumStepNumber "10" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ set parametersweep options

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
    .SetSimulationType "Transient" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "length", "True", "10", "30", "21" 
End With

'@ add parsweep parameter: Sequence 1:gap

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "gap", "True", "10", "25", "16" 
End With

'@ edit parsweep parameter: Sequence 1:gap

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gap" 
     .AddParameter "Sequence 1", "gap", "True", "15", "25", "11" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter "Sequence 1", "length", "True", "25", "45", "21" 
End With

'@ edit parsweep parameter: Sequence 1:gap

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gap" 
     .AddParameter "Sequence 1", "gap", "True", "5", "15", "11" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter "Sequence 1", "length", "True", "35", "55", "21" 
End With

'@ edit parsweep parameter: Sequence 1:gap

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gap" 
     .AddParameter "Sequence 1", "gap", "True", "6", "15", "11" 
End With

'@ delete parsweep parameter: Sequence 1:gap

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gap" 
End With

'@ delete parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
End With

'@ add parsweep parameter: Sequence 1:width

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "width", "True", "2", "8", "7" 
End With

'@ add parsweep parameter: Sequence 1:sp

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "sp", "True", "0.5", "1.5", "11" 
End With

'@ delete parsweep parameter: Sequence 1:sp

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "sp" 
End With

'@ edit parsweep parameter: Sequence 1:width

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "width" 
     .AddParameter "Sequence 1", "width", "True", "8", "20", "13" 
End With

'@ delete parsweep parameter: Sequence 1:width

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "width" 
End With

'@ add parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "length", "True", "40", "45", "14" 
End With

'@ delete parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
End With

'@ add parsweep parameter: Sequence 1:gnd_h

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "gnd_h", "True", "20", "25", "6" 
End With

'@ delete parsweep parameter: Sequence 1:gnd_h

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gnd_h" 
End With

'@ farfield plot options

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "1.575" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1.0" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ pick edge

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.PickEdgeFromId "component1:solid4", "1", "1"

'@ switch working plane

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Plot.DrawWorkplane "true"

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ define frequency range

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Solver.FrequencyRange "1", "3"

'@ define material: FR4

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Material 
     .Reset 
     .Name "FR4"
     .Folder ""
     .FrqType "all"
     .Type "Normal"
     .SetMaterialUnit "GHz", "mm"
     .Epsilon "4.6"
     .Mue "1"
     .ThinPanel "False"
     .Thickness "0"
     .Kappa "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .ConstTanDModelOrderEps "1"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .KappaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .ConstTanDModelOrderMue "1"
     .DispModelEps  "None"
     .DispModelMue "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMue "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMue "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Unused"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "30" 
     .MinimumStepNumber "10" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ define pml specials

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Boundary
     .DefinitionType "Default" 
     .Layer "4" 
     .AbsoluteDepth "0" 
     .FractionPMLDepth "0" 
     .BaseFrequencyPMLDepth "0" 
     .MinimumDistanceType "Fraction" 
     .MinimumDistancePerWavelength "8" 
     .MinimumDistanceReferenceFrequencyType "CenterNMonitors" 
     .FrequencyForMinimumDistance "1.575" 
End With

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "30" 
     .MinimumStepNumber "20" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ set mesh properties

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .UseRatioLimit "True" 
     .RatioLimit "20" 
     .LinesPerWavelength "20" 
     .MinimumStepNumber "10" 
     .Automesh "True" 
     .MeshType "PBA" 
     .SetCreator "High Frequency" 
End With

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ transform: translate component1:solid9

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid9" 
     .Vector "0", "0", "-2.4" 
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

'@ transform: translate component1:solid9_1

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid9_1" 
     .Vector "0", "0", "-2.4" 
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

'@ define automesh parameters

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With MeshSettings
     .SetMeshType "Hex" 
     .Set "Version", 0%
End With
With Mesh 
     .AutomeshStraightLines "True" 
     .AutomeshEllipticalLines "True" 
     .AutomeshRefineAtPecLines "True", "10" 
     .AutomeshRefinePecAlongAxesOnly "False" 
     .AutomeshAtEllipseBounds "True", "10" 
     .AutomeshAtWireEndPoints "True" 
     .AutomeshAtProbePoints "True" 
     .SetAutomeshRefineDielectricsType "Generalized" 
     .MergeThinPECLayerFixpoints "True" 
     .EquilibrateMesh "False" 
     .EquilibrateMeshRatio "1.19" 
     .UseCellAspectRatio "False" 
     .CellAspectRatio "50.0" 
     .UsePecEdgeModel "True" 
     .MeshType "PBA" 
     .AutoMeshLimitShapeFaces "True" 
     .AutoMeshNumberOfShapeFaces "1000" 
     .PointAccEnhancement "0" 
     .SurfaceOptimization "True" 
     .SurfaceSmoothing "3" 
     .MinimumCurvatureRefinement "100" 
     .CurvatureRefinementFactor "0.05" 
     .AnisotropicCurvatureRefinement "True" 
     .SmallFeatureSize "0.0" 
     .SurfaceTolerance "0.0" 
     .SurfaceToleranceType "Relative" 
     .NormalTolerance "22.5" 
     .AnisotropicCurvatureRefinementFSM "True" 
     .SurfaceMeshEnrichment "0" 
     .DensityTransitionsFSM "0.5" 
     .VolumeOptimization "True" 
     .VolumeSmoothing "True" 
     .VolumeMeshMethod "Delaunay" 
     .SurfaceMeshMethod "General" 
     .SurfaceMeshGeometryAccuracy "1.0e-6" 
     .DelaunayOptimizationLevel "2" 
     .DelaunayPropagationFactor "1.050000" 
     .DensityTransitions "0.5" 
     .MeshAllRegions "False" 
     .ConvertGeometryDataAfterMeshing "True" 
     .AutomeshFixpointsForBackground "True" 
     .PBAType "Fast PBA" 
     .AutomaticPBAType "False" 
     .DetectSmallSolidPEC "False" 
     .ConsiderSpaceForLowerMeshLimit "False" 
     .RatioLimitGovernsLocalRefinement "False" 
     .GapDetection "False" 
     .FPBAGapTolerance "1e-3" 
     .SetMaxParallelMesherThreads "Hex", "8"
     .SetParallelMesherMode "Hex", "Maximum"
     .AutomeshRefineThermalMaterials "False" 
     .SetThermalRefinementConductivityReference "1e-3" 
     .SetThermalRefinementHeatCapacityReference "1e-3" 
     .SetParallelMesherMode "Tet", "maximum" 
     .SetMaxParallelMesherThreads "Tet", "1" 
     .ConnectivityCheck "False"
     .SelfIntersectingCheck "True"
     .FPBAAccuracyEnhancement "enable"
     .FastPBAAccuracy "3"
End With 
With Solver 
     .UseSplitComponents "True" 
     .PBAFillLimit "99" 
     .EnableSubgridding "False" 
     .AlwaysExcludePec "False" 
End With

'@ define time domain solver parameters

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
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

'@ add parsweep parameter: Sequence 1:gnd_h

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "gnd_h", "True", "22", "28", "10" 
End With

'@ add parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .AddParameter "Sequence 1", "length", "True", "40", "41", "17" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter "Sequence 1", "length", "True", "39", "41", "7" 
End With

'@ edit parsweep parameter: Sequence 1:gnd_h

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gnd_h" 
     .AddParameter "Sequence 1", "gnd_h", "True", "26", "30", "8" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter "Sequence 1", "length", "True", "39", "44", "11" 
End With

'@ edit parsweep parameter: Sequence 1:gnd_h

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gnd_h" 
     .AddParameter "Sequence 1", "gnd_h", "True", "28", "32", "5" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter "Sequence 1", "length", "True", "38", "42", "5" 
End With

'@ edit parsweep parameter: Sequence 1:gnd_h

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "gnd_h" 
     .AddParameter "Sequence 1", "gnd_h", "True", "30", "32", "5" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter "Sequence 1", "length", "True", "39", "41", "5" 
End With

'@ farfield plot options

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "1.575" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1.0" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ new component: component2

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Component.New "component2"

'@ transform: translate component1

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Vector "d", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "4" 
     .MultipleSelection "False" 
     .Destination "component2" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ pick face

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.PickFaceFromId "component2:solid7_1", "4"

'@ define port: 2

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
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
     .Xrange "92.74", "97.74" 
     .Yrange "-10", "-10" 
     .Zrange "-1.9", "3.1" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ pick face

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.PickFaceFromId "component2:solid7_2", "4"

'@ define port: 3

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
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
     .Xrange "187.98", "192.98" 
     .Yrange "-10", "-10" 
     .Zrange "-1.9", "3.1" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ pick face

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.PickFaceFromId "component2:solid7_3", "4"

'@ define port: 4

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Port 
     .Reset 
     .PortNumber "4" 
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
     .Xrange "283.22", "288.22" 
     .Yrange "-10", "-10" 
     .Zrange "-1.9", "3.1" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ pick face

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.PickFaceFromId "component2:solid7_4", "4"

'@ define port: 5

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Port 
     .Reset 
     .PortNumber "5" 
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
     .Xrange "378.46", "383.46" 
     .Yrange "-10", "-10" 
     .Zrange "-1.9", "3.1" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ define solver excitation modes

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solver 
     .ResetExcitationModes 
     .SimultaneousExcitation "True" 
     .SetSimultaneousExcitAutoLabel "False" 
     .SetSimultaneousExcitationLabel "Simulation_1" 
     .SetSimultaneousExcitationOffset "Phaseshift" 
     .PhaseRefFrequency "1.575" 
     .ExcitationPortMode "1", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "2", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "3", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "4", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "5", "1", "1.0", "0.0", "default", "True" 
End With

'@ define time domain solver parameters

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "Selected"
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

'@ define solver excitation modes

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solver 
     .ResetExcitationModes 
     .SimultaneousExcitation "True" 
     .SetSimultaneousExcitAutoLabel "False" 
     .SetSimultaneousExcitationLabel "Simulation_1" 
     .SetSimultaneousExcitationOffset "Phaseshift" 
     .PhaseRefFrequency "1.575" 
     .ExcitationPortMode "1", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "2", "1", "0.3933", "175", "default", "True" 
     .ExcitationPortMode "3", "1", "0.3152", "175", "default", "True" 
     .ExcitationPortMode "4", "1", "0.266", "-156", "default", "True" 
     .ExcitationPortMode "5", "1", "0.0782", "128", "default", "True" 
End With

'@ farfield plot options

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "1.575" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1.0" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ define farfield monitor: farfield (f=2)

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "2" 
     .UseSubvolume "False" 
     .SetSubvolume  "-56.5",  "437.46",  "-35",  "107",  "-27.4",  "28.6" 
     .Create 
End With

'@ define solver excitation modes

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With Solver 
     .ResetExcitationModes 
     .SimultaneousExcitation "True" 
     .SetSimultaneousExcitAutoLabel "False" 
     .SetSimultaneousExcitationLabel "Simulation" 
     .SetSimultaneousExcitationOffset "Phaseshift" 
     .PhaseRefFrequency "1.575" 
     .ExcitationPortMode "1", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "2", "1", "1", "0", "default", "True" 
     .ExcitationPortMode "3", "1", "1", "0", "default", "True" 
     .ExcitationPortMode "4", "1", "1", "0", "default", "True" 
     .ExcitationPortMode "5", "1", "1", "0", "default", "True" 
End With

'@ delete component: component2

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Component.Delete "component2"

'@ delete port: port2

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Port.Delete "2"

'@ delete port: port3

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Port.Delete "3"

'@ delete port: port4

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Port.Delete "4"

'@ delete port: port5

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Port.Delete "5"

'@ switch working plane

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Plot.DrawWorkplane "false"

'@ farfield plot options

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "1.575" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "True" 
     .SetSpecials "disablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1.0" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ clear picks

'[VERSION]2012.4|22.0.0|20120707[/VERSION]
Pick.ClearAllPicks

'@ set mesh properties (for backward compatibility)

'[VERSION]2015.2|24.0.2|20150403[/VERSION]
With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 0%
     .SetMeshType "Srf"
     .Set "Version", 0%
End With
With MeshSettings 
     .SetMeshType "Tet" 
     .Set "CellsPerWavelengthPolicy", "cellsperwavelength" 
     .Set "CurvatureOrderPolicy", "off" 
     .SetMeshType "Plane" 
     .Set "CurvatureOrderPolicy", "off" 
End With

'@ change solver type

'[VERSION]2015.2|24.0.2|20150403[/VERSION]
ChangeSolverType "HF Time Domain"

'@ switch bounding box

'[VERSION]2016.6|25.0.2|20161004[/VERSION]
Plot.DrawBox "False"

'@ farfield plot options

'[VERSION]2016.6|25.0.2|20161004[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "1.575" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "True" 
     .SetSpecials "disablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1.0" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With 

