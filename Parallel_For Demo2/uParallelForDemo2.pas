unit uParallelForDemo2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TForm5 = class(TForm)
    btnNormalForLoop: TButton;
    btnParallelForLoop: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    GridLayout: TGridLayout;
    lblItemCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnNormalForLoopClick(Sender: TObject);
  private
    { Private declarations }
    FItemCount : Integer;
    FItemList  : array of TFmxObject;

    function CreateShape: TRectangle;
  public
    { Public declarations }
  end;

var
  Form5 : TForm5;
  Layout: TGridLayout;

const
  _ITEMCOUNT_ = 88;

implementation

uses
  System.Threading;

{$R *.fmx}

procedure TForm5.btnNormalForLoopClick(Sender: TObject);
var
  I : Integer;
  ARectangle: TRectangle;
begin

  // paint shape by shape
  for I := 0 to Length(FItemList)-1 do Begin
                 // typecast
    ARectangle:= TRectangle(FItemList[I]);
    ARectangle.Fill.Color:= TAlphaColors.Blueviolet;
  End;
end;

function TForm5.CreateShape: TRectangle;
var MyRectangle: TRectangle;
begin
                                 // "on" which component do you want to create the dynamic object
  MyRectangle:= TRectangle.Create(Layout);
  MyRectangle.Visible:=True;
  Result:= MyRectangle;
end;

procedure TForm5.FormCreate(Sender: TObject);
Var
  AObject: TFmxObject;
  I,J: Integer;
begin
  SetLength(FItemList, _ITEMCOUNT_);

  for I := 0 to (_ITEMCOUNT_ - 1) do Begin
    AObject:= Self.CreateShape;
    AObject.Name:='Shape'+I.ToString;
    GridLayout.AddObject(AObject);
    FItemList[I]:=AObject;
  End;

  FItemCount:= Length(FItemList);
  lblItemCount.Text:= 'Rectangles : '+FItemCount.ToString;

end;

end.
