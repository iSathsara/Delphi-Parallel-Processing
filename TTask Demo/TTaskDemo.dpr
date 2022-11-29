program TTaskDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uTTaskForm in 'uTTaskForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
