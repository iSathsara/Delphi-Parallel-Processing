program TFutureDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uTFutureForm in 'uTFutureForm.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
