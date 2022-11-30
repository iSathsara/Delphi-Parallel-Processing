unit uTMonitorForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Ani, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo;

type
  TMyObject = class(TObject);

  TForm6 = class(TForm)
    btnStartWait: TButton;
    btnStartPulse: TButton;
    ProgressBar: TProgressBar;
    FloatAnimation: TFloatAnimation;
    lblFormStatus: TLabel;
    memResults: TMemo;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnStartWaitClick(Sender: TObject);
    procedure btnStartPulseClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
    FCounter: Integer;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  MyObject: TMyObject;

implementation

uses
  System.SyncObjs, System.Threading;

{$R *.fmx}

procedure TForm6.btnClearClick(Sender: TObject);
begin
  if memResults.Lines <> nil then
    memResults.Lines.Clear;
end;

procedure TForm6.btnStartPulseClick(Sender: TObject);
begin
  Dec(FCounter);
  TMonitor.Pulse(MyObject);

  if FCounter > 0 then Begin
    btnStartPulse.Text:= '# waiting to pulse ('+FCounter.ToString+')';
  End
  else if (FCounter <= 0) then Begin
    btnStartPulse.Text:= 'Nothing to Pulse';
    FCounter:= 0;
  End;

end;

procedure TForm6.btnStartWaitClick(Sender: TObject);
begin
  Inc(FCounter);
  btnStartPulse.Text:= '# waiting to pulse ('+FCounter.ToString+')';
  btnClear.Enabled:= True;

  TTask.Run(procedure Begin
                        // enter here
                        TMonitor.Enter(MyObject);
                        TThread.Synchronize(nil, procedure Begin
                                                   memResults.Lines.Add('enter obj #:'+FCounter.ToString);
                                                 End);
                        try
                          // wait here...
                                                  // wait INFINITE time in monitor.
                                                  // so we need to force pulse
                          TMonitor.Wait(MyObject, INFINITE);

                        finally
                          // exit here
                          // Automatically called by Pulse method
                          TMonitor.Exit(MyObject);
                          TThread.Synchronize(nil, procedure Begin
                                                     memResults.Lines.Add('exiting...');
                                                   End)
                        end;

                      End);
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  // create object which is going to Monitor
  MyObject:= TMyObject.Create;
  FCounter:= 0;
  FloatAnimation.Enabled:= True;
  lblFormStatus.Text:= 'Form is Alive...'+' object created!';
end;

end.
