'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

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
     .Xrange "0", "21.984999999999999" 
     .Yrange "0", "46.60799999999999" 
     .Zrange "0", "0" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .ConsiderForStructureBoundary "False" 
     .Shield "PEC" 
     .WaveguideMonitor "False" 
     .ReferenceWCS "10.9925", "23.304", "0", "0", "0", "-1", "1", "0", "0"
     .CreateImported 
End With 
With Transform 
     .Reset 
     .Name "port1" 
     .UseGlobalCoordinates "True" 
     .Vector "29.729325", "0", "0" 
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
    .NumberOfElements "1", "2" 
    .Spacing "PAA_UC_DS1", "PAA_UC_DS2" 
    .GridAngle "PAA_UC_ANGLE" 
    .FillSpace "True" 
    .ForceParallelogram "False" 
    .ElementTypes "0;0;" 
    .ElementLabel "(1,1);(1,2);" 
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
	 .ExcitationPortMode "1", "1", "PAA_Amplitude(1)", "PAA_Phase( - 360.0 * PAA_FA_FREQ / clight * SinD(PAA_FA_SCANTHETA) * ((PAAx(0)) * CosD(PAA_FA_SCANPHI) + (PAAy(0)) * SinD(PAA_FA_SCANPHI)) * Units.GetGeometryUnitToSI * Units.GetFrequencyUnitToSI)", "default", "True" 
	 .ExcitationPortMode "2", "1", "PAA_Amplitude(1)", "PAA_Phase( - 360.0 * PAA_FA_FREQ / clight * SinD(PAA_FA_SCANTHETA) * ((PAAx(1)) * CosD(PAA_FA_SCANPHI) + (PAAy(1)) * SinD(PAA_FA_SCANPHI)) * Units.GetGeometryUnitToSI * Units.GetFrequencyUnitToSI)", "default", "True" 
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

