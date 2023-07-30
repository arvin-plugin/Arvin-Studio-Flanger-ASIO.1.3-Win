object FlangerDataModule: TFlangerDataModule
  OldCreateOrder = False
  OnCreate = VSTModuleCreate
  Flags = [effFlagsHasEditor, effFlagsCanMono, effFlagsCanReplacing]
  Version = '0.0'
  EffectName = 'Flanger'
  ProductName = 'Arvin Flanger Pedal'
  VendorName = 'Arvin Studio'
  PlugCategory = vpcEffect
  CanDos = [vcdPlugAsChannelInsert, vcdPlugAsSend, vcd2in2out]
  SampleRate = 44100.000000000000000000
  CurrentProgram = 0
  CurrentProgramName = 'Init'
  UniqueID = 'xPKI'
  ShellPlugins = <>
  Programs = <
    item
      DisplayName = 'Init'
      VSTModule = Owner
    end>
  ParameterProperties = <
    item
      Max = 1.000000000000000000
      Curve = ctLinear
      DisplayName = 'Width'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = FlangerDataModuleParameterProperties0ParameterChange
    end
    item
      Max = 1.000000000000000000
      Curve = ctLinear
      DisplayName = 'Speed'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = FlangerDataModuleParameterProperties1ParameterChange
    end
    item
      Max = 1.000000000000000000
      Curve = ctLinear
      DisplayName = 'Intensity'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = FlangerDataModuleParameterProperties2ParameterChange
    end>
  OnEditOpen = VSTModuleEditOpen
  OnProcess = VSTModuleProcess
  OnProcessReplacing = VSTModuleProcess
  Left = 579
  Top = 169
  Height = 150
  Width = 215
end
