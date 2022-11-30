program ParallelForInterlocked;

uses
  System.StartUpCopy,
  FMX.Forms,
  uParallelFor_Interlocked in 'uParallelFor_Interlocked.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
