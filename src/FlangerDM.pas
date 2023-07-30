unit FlangerDM;

interface

uses 
  Windows, Messages, SysUtils, Classes, Forms, 
  DAVDCommon, DVSTModule;

type
  TFlangerDataModule = class(TVSTModule)
    procedure VSTModuleEditOpen(Sender: TObject; var GUI: TForm; ParentWindow: Cardinal);
    procedure VSTModuleCreate(Sender: TObject);
    procedure VSTModuleProcess(const Inputs,
      Outputs: TAVDArrayOfSingleDynArray; const SampleFrames: Integer);
    procedure FlangerDataModuleParameterProperties0ParameterChange(
      Sender: TObject; const Index: Integer; var Value: Single);
    procedure FlangerDataModuleParameterProperties1ParameterChange(
      Sender: TObject; const Index: Integer; var Value: Single);
    procedure FlangerDataModuleParameterProperties2ParameterChange(
      Sender: TObject; const Index: Integer; var Value: Single);
  private
    fWidth: Single;      // Nilai knob "Width" (lebar)
    fSpeed: Single;      // Nilai knob "Speed" (kecepatan)
    fIntensity: Single;  // Nilai knob "Intensity" (intensitas)
    fDelayBuffer: array of array of Single; // Buffer delay untuk efek flanger
    fReadIndex, fWriteIndex: Integer; // Indeks baca dan tulis untuk buffer delay
  public
  end;

implementation

{$R *.DFM}

uses
  UIFlanger;
// Fungsi ini akan dipanggil ketika antarmuka pengguna (GUI) untuk efek flanger dibuka.
procedure TFlangerDataModule.VSTModuleEditOpen(Sender: TObject; var GUI: TForm; ParentWindow: Cardinal);
begin
  GUI := TFlangerUI.Create(Self);
end;

// Fungsi ini akan dipanggil saat modul efek flanger dibuat.
procedure TFlangerDataModule.VSTModuleCreate(Sender: TObject);
begin
// Nilai default untuk knob "Width", "Speed", dan "Intensity"
  Parameter[0] := 0.5; // Width (lebar) default
  Parameter[1] := 0.5; // Speed (kecepatan) default
  Parameter[2] := 0.5; // Intensity (intensitas) default

  // Menyimpan nilai dari ketiga knob ke variabel terkait
  fWidth := Parameter[0];
  fSpeed := Parameter[1];
  fIntensity := Parameter[2];

  // Menginisialisasi buffer delay untuk efek flanger
  SetLength(fDelayBuffer, 2, 88200); // 2 saluran, ukuran buffer 2 detik pada 44100 Hz
  fReadIndex := 0;
  fWriteIndex := 0;
end;

// Fungsi ini merupakan inti dari efek flanger. Sinyal audio akan diproses di sini.
procedure TFlangerDataModule.VSTModuleProcess(const Inputs,
  Outputs: TAVDArrayOfSingleDynArray; const SampleFrames: Integer);
var
  j, Channel: Integer;
  DelayLength, FractionalDelay: Single;
  TempSample: Single;
begin
  for j := 0 to SampleFrames - 1 do
  begin
    for Channel := 0 to 1 do
    begin
      // Menghitung panjang delay berdasarkan nilai knob "Width"
      DelayLength := fWidth * 0.002; // Delay maksimum adalah 2 detik

      // Menghitung nilai delay fraksional menggunakan gelombang sinus berdasarkan knob "Speed"
      FractionalDelay := DelayLength * (0.5 + 0.5 * Sin(2 * Pi * fSpeed * j / SampleFrames));

      // Menghitung bagian integer dan fraksional dari delay
      fReadIndex := (fWriteIndex - Round(FractionalDelay * SampleRate) + Length(fDelayBuffer[Channel])) mod Length(fDelayBuffer[Channel]);

      // Mengaplikasikan efek flanger berdasarkan knob "Intensity"
      TempSample := Inputs[Channel, j] + fIntensity * fDelayBuffer[Channel, fReadIndex];

      // Memverifikasi dan mengatasi suara pecah (clipping)
      if TempSample > 1.0 then
        TempSample := 1.0
      else if TempSample < -1.0 then
        TempSample := -1.0;

      Outputs[Channel, j] := TempSample;

      // Memperbarui buffer delay
      fDelayBuffer[Channel, fWriteIndex] := Inputs[Channel, j];
      fWriteIndex := (fWriteIndex + 1) mod Length(fDelayBuffer[Channel]);
    end;
  end;
end;

// Fungsi ini akan dipanggil saat nilai knob "Width" berubah.
procedure TFlangerDataModule.FlangerDataModuleParameterProperties0ParameterChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
fWidth := Value;
end;
// Fungsi ini akan dipanggil saat nilai knob "Speed" berubah.
procedure TFlangerDataModule.FlangerDataModuleParameterProperties1ParameterChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 fSpeed := Value;
end;
// Fungsi ini akan dipanggil saat nilai knob "Intensity" berubah.
procedure TFlangerDataModule.FlangerDataModuleParameterProperties2ParameterChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
  fIntensity := Value;
end;

end.