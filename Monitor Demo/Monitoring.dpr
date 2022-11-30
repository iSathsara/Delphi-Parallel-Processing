program Monitoring;

uses
  System.StartUpCopy,
  FMX.Forms,
  uTMonitorForm in 'uTMonitorForm.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
