unit uParallelFor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Ani, FMX.Controls.Presentation;

type
  TForm4 = class(TForm)
    lblFormStatus: TLabel;
    ProgressBar: TProgressBar;
    FloatAnimation: TFloatAnimation;
    btnParallelFor: TButton;
    btnParallelForSync: TButton;
    memOutput: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnParallelForClick(Sender: TObject);
    procedure btnParallelForSyncClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses
  System.Threading;

{$R *.fmx}

procedure TForm4.btnParallelForClick(Sender: TObject);
begin
  memOutput.Lines.Clear;

  // Run in Main Thread
                // low value in For loop
                    // high value in For loop
  TParallel.For( 0, 10, procedure(index: Integer)
                        Begin
                          Sleep(300);
                          TThread.Queue(nil, procedure
                                             begin
                                               memOutput.Lines.Add(index.ToString)
                                             end);
                        End);
end;

procedure TForm4.btnParallelForSyncClick(Sender: TObject);
begin
  memOutput.Lines.Clear;

  // Run in TTask
  TTask.Run(
    procedure Begin
      TParallel.For(0, 10, procedure(index: Integer)
                           Begin
                             Sleep(300);
                             TThread.Queue(nil, procedure
                                                begin
                                                  memOutput.Lines.Add(index.ToString)
                                                end);
                           End);
    End);

end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  lblFormStatus.Text:= 'Form is Alive...';
  FloatAnimation.Enabled:= True;
end;

end.
