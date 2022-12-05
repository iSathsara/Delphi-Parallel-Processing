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
    edtStride: TEdit;
    Label1: TLabel;
    GridLayout: TGridLayout;
    lblItemCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnNormalForLoopClick(Sender: TObject);
    procedure btnParallelForLoopClick(Sender: TObject);
  private
    { Private declarations }
    FItemCount : Integer;
    FItemList  : array of TFmxObject;

    function CreateShape: TRectangle;

    procedure Clear;
    procedure NormalPaint(var index: Integer);
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

// clear shapes
procedure TForm5.Clear;
var
  I : Integer;
  ARectangle: TRectangle;
begin
  for I:= Low(FItemList)  to High(FItemList) do Begin
    ARectangle:= TRectangle(FItemList[I]);
    ARectangle.Fill:= TBrush.Create(TBrushKind.Solid, $FFE0E0E0);
  End;
end;

// Paint in formal for loop
procedure TForm5.NormalPaint(var index: Integer);
var
  I: Integer;
  ARectangle: TRectangle;
begin
  if FItemList[index] <> nil then Begin
    ARectangle:= TRectangle(FItemList[index]);
    ARectangle.Fill.Color:= TAlphaColors.Blueviolet;
  End else
    raise Exception.Create('Requested item is null');
End;

procedure TForm5.btnNormalForLoopClick(Sender: TObject);
var
  I: Integer;
  lFrom, lTo: Integer;
begin
  Clear;
  TTask.Run(procedure
            var
              index: Integer;
            Begin
              for index := Low(FItemList) to High(FItemList) do begin
                NormalPaint(index);
                Sleep(100);
              end;
            End);
end;

procedure TForm5.btnParallelForLoopClick(Sender: TObject);
var ARectangle: TRectangle;
    I: Integer;

begin
  Clear;
  TTask.Run(procedure
            Begin

            End);

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
