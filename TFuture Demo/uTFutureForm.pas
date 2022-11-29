unit uTFutureForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.StdCtrls, FMX.Controls.Presentation,

  System.Threading; // import TTask, TFuture

type
  TForm3 = class(TForm)
    lblFormStatus: TLabel;
    ProgressBar: TProgressBar;
    FloatAnimation: TFloatAnimation;
    lblDescription: TLabel;
    btnWithFuture: TButton;
    btnRefresh: TButton;
    procedure btnWithFutureClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    FutureResult: IFuture<String>;   // this interface will hold the result of Future function
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.btnRefreshClick(Sender: TObject);
begin
  lblDescription.Text:= FutureResult.Value;
  btnRefresh.Enabled:= False;
end;

procedure TForm3.btnWithFutureClick(Sender: TObject);
var
  res: String;
begin
  btnWithFuture.Text:='wait...';
  btnWithFuture.Enabled:= False;

  // Usage of TFuture
  FutureResult:= TTask.Future<String> (
    // this is an anonymous function
    function:String Begin
      Sleep(4000);
      res:= 'Random #'+Random(100).ToString;

      if not res.IsEmpty then begin
        btnRefresh.Enabled:= True;
        btnWithFuture.Text:='With TFuture';
        btnWithFuture.Enabled:=True;
      end;

      Result:=res;
    End);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  lblFormStatus.Text:= 'Form is Alive...';
  FloatAnimation.Enabled:= True;
end;

end.
