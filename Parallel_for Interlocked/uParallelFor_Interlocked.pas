unit uParallelFor_Interlocked;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Ani;

type
  TForm5 = class(TForm)
    lblResult: TLabel;
    btnThreadSafe: TButton;
    Timer: TTimer;
    ProgressBar: TProgressBar;
    FloatAnimation: TFloatAnimation;
    lblFormStatus: TLabel;
    btnNoThreadSafe: TButton;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnThreadSafeClick(Sender: TObject);
    procedure btnNoThreadSafeClick(Sender: TObject);
  private
    { Private declarations }
    FTotal: Int64;
    FThreadSafe: Boolean;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  System.Threading, System.SyncObjs;

{$R *.fmx}

procedure TForm5.btnNoThreadSafeClick(Sender: TObject);
begin
  FTotal:= 0;
  FThreadSafe:= False;
  TParallel.For(0, 10000, procedure(index: integer) Begin
                            Sleep(2);
                            FTotal:= FTotal + Index;
                          End);
end;

procedure TForm5.btnThreadSafeClick(Sender: TObject);
begin
  // FTotal:= 0; is replaced with
  TInterlocked.Exchange(FTotal, 0);
  FThreadSafe:= True;

  TTask.Run(procedure Begin
    TParallel.For(0, 10000, procedure(index: integer) Begin
                            Sleep(2);
                            // FTotal:= TFotal + Index is replaced with
                            TInterlocked.Add(FTotal, index);
                          End);
  End);

end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  FThreadSafe:= False;
  Timer.Enabled:= True;
  FloatAnimation.Enabled:= True;
end;

procedure TForm5.TimerTimer(Sender: TObject);
var
  Value: Int64;
begin

  if FThreadSafe then Begin
    Value:= TInterlocked.Read(FTotal);
    lblResult.Text:= Value.ToString;
  End else
    lblResult.Text:= FTotal.ToString;
end;

end.
