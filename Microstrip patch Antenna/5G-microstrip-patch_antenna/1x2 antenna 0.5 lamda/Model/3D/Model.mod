'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 2 fmax = 4
'# created = '[VERSION]2018.0|27.0.2|20171026[/VERSION]


'@ use template: Antenna - Planar_5.cfg

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
'set the frequency range
Solver.FrequencyRange "2", "4"
Dim sDefineAt As String
sDefineAt = "3.6"
Dim sDefineAtName As String
sDefineAtName = "3.6"
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
    .MonitorValue  zz_val
    .Create
End With
' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .MonitorValue  zz_val
    .Create
End With
' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .MonitorValue  zz_val
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

'@ define material: Copper (annealed)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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

'@ define material: FR-4 (lossy)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Material
     .Reset
     .Name "FR-4 (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "4.3"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.025"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.3"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ new component: component1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "component1"

'@ define brick: component1:gnd

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "gnd" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "0", "wg" 
     .Yrange "0", "lg" 
     .Zrange "-ht", "0" 
     .Create
End With

'@ define brick: component1:subs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "subs" 
     .Component "component1" 
     .Material "FR-4 (lossy)" 
     .Xrange "0", "wg" 
     .Yrange "0", "lg" 
     .Zrange "0", "hs" 
     .Create
End With

'@ define brick: component1:feed

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "feed" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2-wf/2", "wg/2+wf/2" 
     .Yrange "0", "lf" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ define brick: component1:patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2-wp/2", "wg/2+wp/2" 
     .Yrange "lf", "lf+lp" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ define brick: component1:cut

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "cut" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2+wf/2", "wg/2+wf/2+wc" 
     .Yrange "lf", "lf+lc" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ transform: translate component1:cut

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:cut" 
     .Vector "-wf-wc", "0", "0" 
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

'@ delete material: FR-4 (lossy)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Material.Delete "FR-4 (lossy)"

'@ define material: Rogers RT5880 (lossy)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Material
     .Reset
     .Name "Rogers RT5880 (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.2"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0009"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.20"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ define brick: component1:subs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "subs" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "0", "wg" 
     .Yrange "0", "lg" 
     .Zrange "0", "hs" 
     .Create
End With

'@ boolean subtract shapes: component1:patch, component1:cut

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "component1:patch", "component1:cut"

'@ boolean subtract shapes: component1:patch, component1:cut_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "component1:patch", "component1:cut_1"

'@ boolean add shapes: component1:feed, component1:patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:feed", "component1:patch"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2*7.09", "2*7.09"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2", "2*7.09"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ define time domain solver parameters

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "FALSE" 
     .Arraytype "Rectangular" 
     .XSet "1", "0", "0" 
     .YSet "2", "92", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ set optimizer parameters

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "hs", "False" 
  .SetParameterInit "1.6" 
  .SetParameterMin "1.44" 
  .SetParameterMax "1.76" 
  .SetParameterAnchors "5" 
  .SelectParameter "ht", "False" 
  .SetParameterInit "0.035" 
  .SetParameterMin "0.0315" 
  .SetParameterMax "0.0385" 
  .SetParameterAnchors "5" 
  .SelectParameter "lc", "False" 
  .SetParameterInit "8.317" 
  .SetParameterMin "7.485" 
  .SetParameterMax "9.149" 
  .SetParameterAnchors "5" 
  .SelectParameter "lf", "False" 
  .SetParameterInit "25.383" 
  .SetParameterMin "22.845" 
  .SetParameterMax "27.921" 
  .SetParameterAnchors "5" 
  .SelectParameter "lg", "False" 
  .SetParameterInit "81.9" 
  .SetParameterMin "73.71" 
  .SetParameterMax "90.09" 
  .SetParameterAnchors "5" 
  .SelectParameter "lp", "True" 
  .SetParameterInit "27.23" 
  .SetParameterMin "26.5" 
  .SetParameterMax "27.23" 
  .SetParameterAnchors "5" 
  .SelectParameter "wc", "False" 
  .SetParameterInit "2.465" 
  .SetParameterMin "2.2185" 
  .SetParameterMax "2.7115" 
  .SetParameterAnchors "5" 
  .SelectParameter "wf", "False" 
  .SetParameterInit "4.93" 
  .SetParameterMin "4.437" 
  .SetParameterMax "5.423" 
  .SetParameterAnchors "5" 
  .SelectParameter "wg", "False" 
  .SetParameterInit "59" 
  .SetParameterMin "53.1" 
  .SetParameterMax "64.9" 
  .SetParameterAnchors "5" 
  .SelectParameter "wp", "False" 
  .SetParameterInit "32.94" 
  .SetParameterMin "29.646" 
  .SetParameterMax "36.234" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Time Domain Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0.0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0.0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0.0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ add optimizer goals: 1DC Primary Result / 0

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Optimizer 
  .AddGoal "1DC Primary Result" 
  .SetGoalOperator "move max" 
  .SetGoalTarget "3.6" 
  .UseSlope "False" 
  .SetGoalTargetMax "0.0" 
  .SetGoalWeight "1.0" 
  .SetGoalNormNew "MaxDiff" 
  .SetGoal1DCResultName "1D Results\S-Parameters\S1,1" 
  .SetGoalScalarType "MagdB20" 
  .SetGoalRange "2", "4" 
  .SetGoalRangeType "total" 
End With

'@ set optimizer parameters

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Optimizer
  .SetMinMaxAuto "10" 
  .SetAlwaysStartFromCurrent "True" 
  .ResetParameterList
  .SelectParameter "hs", "False" 
  .SetParameterInit "1.6" 
  .SetParameterMin "1.44" 
  .SetParameterMax "1.76" 
  .SetParameterAnchors "5" 
  .SelectParameter "ht", "False" 
  .SetParameterInit "0.035" 
  .SetParameterMin "0.0315" 
  .SetParameterMax "0.0385" 
  .SetParameterAnchors "5" 
  .SelectParameter "lc", "False" 
  .SetParameterInit "8.317" 
  .SetParameterMin "7.485" 
  .SetParameterMax "9.149" 
  .SetParameterAnchors "5" 
  .SelectParameter "lf", "False" 
  .SetParameterInit "25.383" 
  .SetParameterMin "22.845" 
  .SetParameterMax "27.921" 
  .SetParameterAnchors "5" 
  .SelectParameter "lg", "False" 
  .SetParameterInit "81.9" 
  .SetParameterMin "73.71" 
  .SetParameterMax "90.09" 
  .SetParameterAnchors "5" 
  .SelectParameter "lp", "True" 
  .SetParameterInit "27.23" 
  .SetParameterMin "26.5" 
  .SetParameterMax "27.23" 
  .SetParameterAnchors "5" 
  .SelectParameter "wc", "False" 
  .SetParameterInit "2.465" 
  .SetParameterMin "2.2185" 
  .SetParameterMax "2.7115" 
  .SetParameterAnchors "5" 
  .SelectParameter "wf", "False" 
  .SetParameterInit "4.93" 
  .SetParameterMin "4.437" 
  .SetParameterMax "5.423" 
  .SetParameterAnchors "5" 
  .SelectParameter "wg", "False" 
  .SetParameterInit "59" 
  .SetParameterMin "53.1" 
  .SetParameterMax "64.9" 
  .SetParameterAnchors "5" 
  .SelectParameter "wp", "False" 
  .SetParameterInit "32.94" 
  .SetParameterMin "29.646" 
  .SetParameterMax "36.234" 
  .SetParameterAnchors "5" 
End With

'@ set optimizer settings

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Optimizer 
  .SetOptimizerType "Trust_Region" 
  .SetSimulationType "Time Domain Solver" 
  .SetAccuracy "0.01" 
  .SetNumRefinements "1" 
  .SetGenerationSize "32", "Genetic_Algorithm" 
  .SetGenerationSize "30", "Particle_Swarm" 
  .SetMaxIt "30", "Genetic_Algorithm" 
  .SetMaxIt "15", "Particle_Swarm" 
  .SetMaxEval "3000", "CMAES" 
  .SetUseMaxEval "True", "CMAES" 
  .SetSigma "0.2", "CMAES" 
  .SetSeed "1", "CMAES" 
  .SetSeed "1", "Genetic_Algorithm" 
  .SetSeed "1", "Particle_Swarm" 
  .SetSeed "1", "Nelder_Mead_Simplex" 
  .SetMaxEval "500", "Trust_Region" 
  .SetUseMaxEval "False", "Trust_Region" 
  .SetSigma "0.2", "Trust_Region" 
  .SetDomainAccuracy "0.01", "Trust_Region" 
  .SetFiniteDiff "0", "Trust_Region" 
  .SetMaxEval "250", "Nelder_Mead_Simplex" 
  .SetUseMaxEval "False", "Nelder_Mead_Simplex" 
  .SetUseInterpolation "No_Interpolation", "Genetic_Algorithm" 
  .SetUseInterpolation "No_Interpolation", "Particle_Swarm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Genetic_Algorithm" 
  .SetInitialDistribution "Latin_Hyper_Cube", "Particle_Swarm" 
  .SetInitialDistribution "Noisy_Latin_Hyper_Cube", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "Nelder_Mead_Simplex" 
  .SetUsePreDefPointInInitDistribution "True", "CMAES" 
  .SetGoalFunctionLevel "0.0", "Genetic_Algorithm" 
  .SetGoalFunctionLevel "0.0", "Particle_Swarm" 
  .SetGoalFunctionLevel "0.0", "Nelder_Mead_Simplex" 
  .SetMutaionRate "60", "Genetic_Algorithm" 
  .SetMinSimplexSize "1e-6" 
  .SetGoalSummaryType "Sum_All_Goals" 
  .SetUseDataOfPreviousCalculations "False" 
  .SetDataStorageStrategy "None" 
  .SetOptionMoveMesh "False" 
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "1.8*7.42", "1.8*7.42"
  .YrangeAdd "0", "0"
  .ZrangeAdd "1.8", "1.8*7.42"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ pick center point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickCenterpointFromId "component1:gnd", "2"

'@ define cylinder: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "10" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-ht", "0" 
     .Xcenter "29.5" 
     .Ycenter "40.95" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "10.4" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-ht", "0" 
     .Xcenter "29.5" 
     .Ycenter "40.9" 
     .Segments "0" 
     .Create 
End With

'@ boolean subtract shapes: component1:solid2, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "component1:solid2", "component1:solid1"

'@ boolean subtract shapes: component1:gnd, component1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "component1:gnd", "component1:solid2"

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg+11", "0" 
     .YSet "2", "lg", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "FALSE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "2", "lg", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "3", "wg", "0" 
     .YSet "1", "0", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "2", "lg", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define brick: component1:ground

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "ground" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "0", "wg" 
     .Yrange "0", "lg" 
     .Zrange "-ht", "0" 
     .Create
End With

'@ delete shape: component1:gnd

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:gnd"

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2*7.77", "2*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2", "2*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "FALSE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "2", "lg", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.2*7.49", "2.2*7.49"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.2", "2.2*7.49"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.3*7.77", "2.3*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.3", "2.3*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.5*7.77", "2.5*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.5", "2.5*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.5*7.77", "2.5*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.5", "2.5*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.6*7.77", "2.6*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.6", "2.6*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.5*7.77", "2.5*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.5", "2.5*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:feed", "25"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.5*7.77", "2.5*7.77"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.5", "2.5*7.77"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "3.6" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "1", "0", "0" 
     .YSet "2", "lg", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "3.6" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "2", "lg-10", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "3.6" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "True" 
     .ShowStructureProfile "True" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "2", "lg-10", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ transform: translate component1:feed

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:feed" 
     .Vector "83.3333/2", "0", "0" 
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

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "15.73", "48.67" 
     .Yrange "25.38294", "44" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ boolean add shapes: component1:feed, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:feed", "component1:solid1"

'@ delete shape: component1:feed_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:feed_1"

'@ transform: translate component1:feed

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:feed" 
     .Vector "83.33/2", "0", "0" 
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

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "28.3485", "36.05" 
     .Yrange "-0", "25.38294" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ define brick: component1:patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2-wp/2", "wg/2+wp/2" 
     .Yrange "lf", "lf+lp" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ delete shapes

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:feed" 
Solid.Delete "component1:feed_1" 
Solid.Delete "component1:solid1"

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2-1.354/2", "wg/2+1.354/2" 
     .Yrange "lf/2", "lf" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ boolean add shapes: component1:patch, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:patch", "component1:solid1"

'@ transform: translate component1:patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:patch" 
     .Vector "83.3333/2", "0", "0" 
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

'@ rename block: component1:patch_1 to: component1:patch2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:patch_1", "patch2"

'@ rename block: component1:patch to: component1:patch1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:patch", "patch1"

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2-1.354/2", "wg/2+1.354/2+83.33/2" 
     .Yrange "lf/2", "lf/2+1.354" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ boolean add shapes: component1:patch1, component1:patch2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:patch1", "component1:patch2"

'@ boolean add shapes: component1:patch1, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:patch1", "component1:solid1"

'@ pick mid point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickMidpointFromId "component1:patch1", "44"

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "53.033325-7.708/2", "53.033325+7.708/2" 
     .Yrange "0", "lf/2" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ boolean add shapes: component1:patch1, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:patch1", "component1:solid1"

'@ transform: translate component1:ground

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:ground" 
     .Vector "27", "0", "0" 
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

'@ clear picks

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.ClearAllPicks

'@ delete shape: component1:ground_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:ground_1"

'@ transform: translate component1:ground

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:ground" 
     .Vector "83.3333/2", "0", "0" 
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

'@ transform: translate component1:subs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:subs" 
     .Vector "83.3333/2", "0", "0" 
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

'@ boolean add shapes: component1:ground, component1:ground_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:ground", "component1:ground_1"

'@ boolean add shapes: component1:subs, component1:subs_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:subs", "component1:subs_1"

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:patch1", "3"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.5*7.78", "2.5*7.78"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.5", "2.5*7.78"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "FALSE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "2", "lg-10", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ transform: translate component1:patch1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:patch1" 
     .Vector "0", "10", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "wg/2+83.3333/4-7.708/2", "wg/2+83.3333/4+7.708/2" 
     .Yrange "0", "18.38" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ delete shape: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:solid1"

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "wg/2+83.3333/4-7.708/2", "wg/2+83.3333/4+7.708/2" 
     .Yrange "0", "22" 
     .Zrange "hs", "hs+ht" 
     .Create
End With

'@ boolean add shapes: component1:patch1, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:patch1", "component1:solid1"

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:patch1", "3"

'@ define port:1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
' Port constructed by macro Solver -> Ports -> Calculate port extension coefficient
With Port
  .Reset
  .PortNumber "1"
  .NumberOfModes "1"
  .AdjustPolarization False
  .PolarizationAngle "0.0"
  .ReferencePlaneDistance "0"
  .TextSize "50"
  .Coordinates "Picks"
  .Orientation "Positive"
  .PortOnBound "True"
  .ClipPickedPortToBound "False"
  .XrangeAdd "2.5*7.78", "2.5*7.78"
  .YrangeAdd "0", "0"
  .ZrangeAdd "2.5", "2.5*7.78"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "3.6" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ clear picks

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.ClearAllPicks

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "TRUE" 
     .Arraytype "Rectangular" 
     .XSet "1", "0", "0" 
     .YSet "2", "lg", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "3.6" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ farfield array properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldArray
     .Reset 
     .UseArray "FALSE" 
     .Arraytype "Rectangular" 
     .XSet "2", "wg", "0" 
     .YSet "1", "0", "0" 
     .ZSet "1", "0", "0" 
     .SetList
End With

