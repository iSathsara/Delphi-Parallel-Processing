program ParallelForDemo2;

uses
  System.StartUpCopy,
  FMX.Forms,
  uParallelForDemo2 in 'uParallelForDemo2.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
