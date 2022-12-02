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
  private
    { Private declarations }
    FItemCount: Integer;

    function CreateShape: TRectangle;
  public
    { Public declarations }
  end;

var
  Form5 : TForm5;
  Layout: TGridLayout;

implementation

{$R *.fmx}



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
  I : Integer;

begin
  for I := 0 to 87 do Begin
    AObject:= Self.CreateShape;
    AObject.Name:='Shape'+I.ToString;
    GridLayout.AddObject(AObject);
  End;
  FItemCount:= GridLayout.ChildrenCount;
  lblItemCount.Text:= 'Rectangles : '+FItemCount.ToString;
end;

end.
