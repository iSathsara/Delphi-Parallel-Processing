program ParallelForDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uParallelFor in 'uParallelFor.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
