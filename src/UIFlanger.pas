unit UIFlanger;

interface

uses 
  Windows, Messages, SysUtils, Classes, Forms, DAVDCommon, DVSTModule,
  DGuiBaseControl, DGuiDial, Graphics, Controls, ExtCtrls;

type
  TFlangerUI = class(TForm)
    Skin: TImage;
    KnobIntensity: TGuiDial;
    KnobSpeed: TGuiDial;
    KnobWidth: TGuiDial;
    procedure KnobWidthChange(Sender: TObject);
    procedure KnobSpeedChange(Sender: TObject);
    procedure KnobIntensityChange(Sender: TObject);
  end;

implementation

uses FlangerDM;

{$R *.DFM}

procedure TFlangerUI.KnobWidthChange(Sender: TObject);
begin
TFlangerDataModule(Owner).Parameter[0] := KnobWidth.Position;
end;

procedure TFlangerUI.KnobSpeedChange(Sender: TObject);
begin
TFlangerDataModule(Owner).Parameter[1] := KnobSpeed.Position;
end;

procedure TFlangerUI.KnobIntensityChange(Sender: TObject);
begin
TFlangerDataModule(Owner).Parameter[2] := KnobIntensity.Position;
end;

end.