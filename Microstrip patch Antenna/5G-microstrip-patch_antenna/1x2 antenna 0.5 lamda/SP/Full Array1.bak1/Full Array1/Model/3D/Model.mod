'# MWS Version: Version 2018.0 - Oct 26 2017 - ACIS 27.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 2 fmax = 4
'# created = '[VERSION]2018.0|27.0.2|20171026[/VERSION]


'@ define units

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Units 
     .Geometry "mm" 
     .Frequency "GHz" 
     .Time "ns" 
     .TemperatureUnit "Kelvin" 
     .Voltage "V" 
     .Current "A" 
     .Resistance "Ohm" 
     .Conductance "Siemens" 
     .Capacitance "F" 
     .Inductance "H" 
End With  



'@ import external project: ..\..\ModelCache\Model.mif

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Material 
     .Reset 
     .Name "Copper (annealed)" 
     .Folder "MWSSCHEM1" 
     .Rho "8930.0"
     .ThermalType "Normal"
     .ThermalConductivity "401.0"
     .HeatCapacity "0.39"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0"
     .VoxelConvection "0"
     .BloodFlow "0"
     .MechanicsType "Isotropic"
     .YoungsModulus "120"
     .PoissonsRatio "0.33"
     .ThermalExpansionRate "17"
     .FrqType "static"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "1"
     .Mu "1.0"
     .Sigma "5.8e+007"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NonlinearMeasurementError "1e-1"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .FrqType "all"
     .Type "Lossy metal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Mu "1.0"
     .Sigma "5.8e+007"
     .LossyMetalSIRoughness "0.0"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .NonlinearMeasurementError "1e-1"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With 

With Material 
     .Reset 
     .Name "Rogers RT5880 (lossy)" 
     .Folder "MWSSCHEM1" 
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.20"
     .HeatCapacity "0"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "2.2"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.0009"
     .TanDFreq "10.0"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0.0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMu "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NonlinearMeasurementError "1e-1"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With 

With SAT
     .Reset 
     .FileName "*Model.mif^3D.sab" 
     .SubProjectName3D "..\..\ModelCache\Model.mif" 
     .SubProjectScaleFactor "0.001" 
     .Version "11.0" 
     .PortnameMap "1>1" 
     .AssemblyPartName "MWSSCHEM1" 
     .ImportToActiveCoordinateSystem "False" 
     .Curves "True" 
     .Wires "True" 
     .SolidWiresAsSolids "False" 
     .ImportSources "True" 
     .Set "ImportSensitivityInformation", "False" 
     .Read 
End With
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "1" 
     .Coordinates "Free" 
     .Orientation "zmin" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "0", "15.190999999999999" 
     .Yrange "0", "31.641999999999996" 
     .Zrange "0", "0" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .ConsiderForStructureBoundary "False" 
     .Shield "PEC" 
     .WaveguideMonitor "False" 
     .ReferenceWCS "7.5955", "15.821", "0", "0", "0", "-1", "1", "0", "0"
     .CreateImported 
End With 

With Transform 
     .Reset 
     .Name "port1" 
     .UseGlobalCoordinates "True" 
     .Vector "13.679", "0", "-2.2204460492503e-16" 
     .AdjustVectorToSubProjectScaleFactor 
     .Matrix "0", "0", "1", "1", "0", "0", "0", "1", "0" 
     .Transform "port", "matrix" 
     .Transform "port", "GlobalToLocal" 
End With 




'@ activate global coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "global"



'@ build array geometry from unit cell

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With PhasedAntennaArray
    .Reset 
    .Orientation "XY" 
    .NumberOfElements "2", "2" 
    .Spacing "PAA_UC_DS1", "PAA_UC_DS2" 
    .GridAngle "PAA_UC_ANGLE" 
    .FillSpace "True" 
    .ForceParallelogram "False" 
    .ElementTypes "0;0;0;0;" 
    .ElementLabel "(1,1);(2,1);(1,2);(2,2);" 
    .Create 
End With



'@ define frequency range

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solver.FrequencyRange "2", "4"


'@ define background

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Background 
     .Reset 
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
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "m"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "1.0"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstSigma"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NonlinearMeasurementError "1e-1"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.6", "0.6", "0.6" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeBackgroundMaterial
End With


'@ define boundaries

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .ApplyInAllDirections "False"
     .ThermalBoundary "Xmin", "isothermal"
     .ThermalBoundary "Xmax", "isothermal"
     .ThermalBoundary "Ymin", "isothermal"
     .ThermalBoundary "Ymax", "isothermal"
     .ThermalBoundary "Zmin", "isothermal"
     .ThermalBoundary "Zmax", "isothermal"
     .ThermalSymmetry "X", "none"
     .ThermalSymmetry "Y", "none"
     .ThermalSymmetry "Z", "none"
     .ResetThermalBoundaryValues
     .WallFlow "Xmin", "NoSlip"
     .WallFlow "Xmax", "NoSlip"
     .WallFlow "Ymin", "NoSlip"
     .WallFlow "Ymax", "NoSlip"
     .WallFlow "Zmin", "NoSlip"
     .WallFlow "Zmax", "NoSlip"
End With


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


'@ define frequency range

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solver.FrequencyRange "2", "4"


'@ define background

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Background 
     .Reset 
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
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "m"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "1.0"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstSigma"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NonlinearMeasurementError "1e-1"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.6", "0.6", "0.6" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeBackgroundMaterial
End With 




'@ define boundaries

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .ApplyInAllDirections "False"
     .ThermalBoundary "Xmin", "isothermal"
     .ThermalBoundary "Xmax", "isothermal"
     .ThermalBoundary "Ymin", "isothermal"
     .ThermalBoundary "Ymax", "isothermal"
     .ThermalBoundary "Zmin", "isothermal"
     .ThermalBoundary "Zmax", "isothermal"
     .ThermalSymmetry "X", "none"
     .ThermalSymmetry "Y", "none"
     .ThermalSymmetry "Z", "none"
     .ResetThermalBoundaryValues
     .WallFlow "Xmin", "NoSlip"
     .WallFlow "Xmax", "NoSlip"
     .WallFlow "Ymin", "NoSlip"
     .WallFlow "Ymax", "NoSlip"
     .WallFlow "Zmin", "NoSlip"
     .WallFlow "Zmax", "NoSlip"
End With 



'@ define units

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Units 
     .Geometry "mm" 
     .Frequency "GHz" 
     .Time "ns" 
     .TemperatureUnit "Kelvin" 
     .Voltage "V" 
     .Current "A" 
     .Resistance "Ohm" 
     .Conductance "Siemens" 
     .Capacitance "F" 
     .Inductance "H" 
End With  



'@ change problem type

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
ChangeProblemType "High Frequency" 



'@ set solver type

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
SetSolverType "HF_TRANSIENT" 
ChangeSolverType "HF Time Domain" 
With Solver
     .Method "Hexahedral"
End With



'@ define array excitation properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With PhasedAntennaArray
    .QuantizationError "0", "0", "0.5" 
    .Pedestal 0, "0.0" 
End With



'@ define boundaries

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
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
     .XminThermal "isothermal"  
     .XmaxThermal "isothermal"  
     .YminThermal "isothermal"  
     .YmaxThermal "isothermal"  
     .ZminThermal "isothermal"  
     .ZmaxThermal "isothermal"  
     .XsymmetryThermal "none"  
     .YsymmetryThermal "none"  
     .ZsymmetryThermal "none"  
     .ApplyInAllDirections "False"  
     .ApplyInAllDirectionsThermal "False"  
     .XminTemperature ""  
     .XminTemperatureType "None"  
     .XmaxTemperature ""  
     .XmaxTemperatureType "None"  
     .YminTemperature ""  
     .YminTemperatureType "None"  
     .YmaxTemperature ""  
     .YmaxTemperatureType "None"  
     .ZminTemperature ""  
     .ZminTemperatureType "None"  
     .ZmaxTemperature ""  
     .ZmaxTemperatureType "None"  
End With 



'@ define solver excitation modes

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Solver 
	 .ResetExcitationModes 
	 .SimultaneousExcitation "True" 
	 .SetSimultaneousExcitAutoLabel "False" 
	 .SetSimultaneousExcitationLabel "Array Scanning" 
	 .SetSimultaneousExcitationOffset "Phaseshift" 
	 .PhaseRefFrequency "PAA_FA_FREQ" 
	 .ExcitationPortMode "1", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
	 .ExcitationPortMode "2", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
	 .ExcitationPortMode "3", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
	 .ExcitationPortMode "4", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
End With 



'@ define farfield monitor: Farfield (PAA_FA_FREQ)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
	 .Reset 
	 .Name "Farfield (PAA_FA_FREQ)" 
	 .Domain "Frequency" 
	 .FieldType "Farfield" 
	 .Frequency "PAA_FA_FREQ" 
	 .UseSubvolume "False" 
	 .ExportFarfieldSource "False" 
	 .Create 
End With 



'@ define time domain solver parameters

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
	 .Method "Hexahedral" 
	 .CalculationType "TD-S" 
	 .StimulationPort "Selected" 
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



'@ define farfield monitoring specials

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solver.MonitorFarFieldsNearToModel "True" 



'@ change solver type

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
ChangeSolverType "HF Time Domain" 



'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:subs, Element (1,2)/MWSSCHEM1/component1:subs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:subs", "Element (1,2)/MWSSCHEM1/component1:subs" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:subs, Element (2,1)/MWSSCHEM1/component1:subs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:subs", "Element (2,1)/MWSSCHEM1/component1:subs" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:subs, Element (2,2)/MWSSCHEM1/component1:subs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:subs", "Element (2,2)/MWSSCHEM1/component1:subs" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:gnd, Element (1,2)/MWSSCHEM1/component1:gnd

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:gnd", "Element (1,2)/MWSSCHEM1/component1:gnd" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:gnd, Element (2,1)/MWSSCHEM1/component1:gnd

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:gnd", "Element (2,1)/MWSSCHEM1/component1:gnd" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:gnd, Element (2,2)/MWSSCHEM1/component1:gnd

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:gnd", "Element (2,2)/MWSSCHEM1/component1:gnd" 


'@ change solver type

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
ChangeSolverType "HF Time Domain" 


'@ define solver excitation modes

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Solver 
     .ResetExcitationModes 
     .SParameterPortExcitation "False" 
     .SimultaneousExcitation "True" 
     .SetSimultaneousExcitAutoLabel "False" 
     .SetSimultaneousExcitationLabel "Array Scanning" 
     .SetSimultaneousExcitationOffset "Phaseshift" 
     .PhaseRefFrequency "PAA_FA_FREQ" 
     .ExcitationSelectionShowAdditionalSettings "False" 
     .ExcitationPortMode "1", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
     .ExcitationPortMode "2", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
     .ExcitationPortMode "3", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
     .ExcitationPortMode "4", "1", "PAA_Amplitude(1)", "PAA_Phase(0)", "default", "True" 
End With 


'@ define time domain solver parameters

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "Selected"
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


'@ delete port folders

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.DeleteFolder "Element (1,1)" 
Port.DeleteFolder "Element (1,2)" 
Port.DeleteFolder "Element (2,1)" 
Port.DeleteFolder "Element (2,2)" 


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


'@ new component: component1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "component1" 


'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "57", "59" 
     .Yrange "0", "20" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ new component: cut1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "cut1" 


'@ define brick: cut1:cu1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "cu1" 
     .Component "cut1" 
     .Material "Copper (annealed)" 
     .Xrange "27", "32" 
     .Yrange "0", "13" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ transform: translate cut1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "cut1" 
     .Vector "58.965", "0", "0" 
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


'@ boolean subtract shapes: Element (1,1)/MWSSCHEM1/component1:feed, cut1:cu1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "Element (1,1)/MWSSCHEM1/component1:feed", "cut1:cu1" 

'@ boolean subtract shapes: Element (2,1)/MWSSCHEM1/component1:feed, cut1:cu1_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "Element (2,1)/MWSSCHEM1/component1:feed", "cut1:cu1_1" 

'@ define brick: cut1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "cut1" 
     .Material "Copper (annealed)" 
     .Xrange "29", "57" 
     .Yrange "11", "11.5" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ define brick: cut1:solid3

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "cut1" 
     .Material "Copper (annealed)" 
     .Xrange "29.1", "29.47" 
     .Yrange "11.35", "15" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ transform: translate cut1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "cut1:solid2" 
     .Vector "30", "0", "0" 
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


'@ boolean add shapes: cut1:solid2, cut1:solid3

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "cut1:solid2", "cut1:solid3" 


'@ delete shape: cut1:solid2_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "cut1:solid2_1" 


'@ transform: rotate cut1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "cut1" 
     .Origin "CommonCenter" 
     .Center "0", "0", "0" 
     .Angle "0", "180", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With 


'@ transform: translate cut1:solid2_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "cut1:solid2_1" 
     .Vector "29.9", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, Element (2,1)/MWSSCHEM1/component1:feed

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "Element (2,1)/MWSSCHEM1/component1:feed" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, cut1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "cut1:solid2" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, cut1:solid2_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "cut1:solid2_1" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "component1:solid1" 


'@ delete component: Element (2,1)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "Element (2,1)" 


'@ delete component: Element (1,2)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "Element (1,2)" 


'@ delete component: Element (2,2)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "Element (2,2)" 


'@ transform: translate Element (1,1)/MWSSCHEM1/component1:feed

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "Element (1,1)/MWSSCHEM1/component1:feed" 
     .Vector "0", "lg", "0" 
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


'@ pick mid point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickMidpointFromId "Element (1,1)/MWSSCHEM1/component1:feed_1", "4" 


'@ pick end point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEndpointFromId "Element (1,1)/MWSSCHEM1/component1:feed_1", "4" 


'@ pick end point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEndpointFromId "Element (1,1)/MWSSCHEM1/component1:feed_1", "1" 


'@ new component: s22

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "s22" 


'@ define brick: s22:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "s22" 
     .Material "MWSSCHEM1/Copper (annealed)" 
     .Xrange "57", "59" 
     .Yrange "0", "81.4" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ clear picks

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.ClearAllPicks 


'@ new component: sd

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "sd" 


'@ define brick: sd:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "sd" 
     .Material "MWSSCHEM1/Copper (annealed)" 
     .Xrange "57", "59" 
     .Yrange "0", "82.02" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, Element (1,1)/MWSSCHEM1/component1:feed_1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "Element (1,1)/MWSSCHEM1/component1:feed_1" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, s22:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "s22:solid1" 


'@ boolean add shapes: Element (1,1)/MWSSCHEM1/component1:feed, sd:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "Element (1,1)/MWSSCHEM1/component1:feed", "sd:solid2" 


'@ delete shapes

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "s22" 
Component.Delete "sd" 


'@ new component: component2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "component2" 


'@ define brick: component2:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component2" 
     .Material "MWSSCHEM1/Copper (annealed)" 
     .Xrange "57", "59" 
     .Yrange "93.4", "102.2" 
     .Zrange "hs", "hs+ht" 
     .Create
End With


'@ delete component: component1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "component1" 


'@ delete component: cut1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "cut1" 


'@ boolean subtract shapes: Element (1,1)/MWSSCHEM1/component1:feed, component2:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "Element (1,1)/MWSSCHEM1/component1:feed", "component2:solid1" 

'@ delete component: component2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.Delete "component2" 


'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "Element (1,1)/MWSSCHEM1/component1:feed", "198" 


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
  .XrangeAdd "1.8*10.79", "1.8*10.79"
  .YrangeAdd "0", "0"
  .ZrangeAdd "1.8", "1.8*10.79"
  .Shield "PEC"
  .SingleEnded "False"
  .Create
End With



