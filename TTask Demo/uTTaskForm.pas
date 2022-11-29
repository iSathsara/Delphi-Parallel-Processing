unit uTTaskForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Ani;

type
  TForm1 = class(TForm)
    lblDescription: TLabel;
    btnWithoutTTask: TButton;
    btnWithTTask: TButton;
    ProgressBar: TProgressBar;
    FloatAnimation: TFloatAnimation;
    lblFormStatus: TLabel;
    Label1: TLabel;
    btnTTaskSync: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnWithoutTTaskClick(Sender: TObject);
    procedure btnWithTTaskClick(Sender: TObject);
    procedure btnTTaskSyncClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Threading; // import TTask

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  lblFormStatus.Text:= 'Form is Alive...';
  FloatAnimation.Enabled:= True;
end;

procedure TForm1.btnTTaskSyncClick(Sender: TObject);
var
  Value: Integer;
begin
  // the same process is run via TTask
  // Sync with Main Thread using Synchronize()
  TTask.Run(
    procedure Begin
      btnTTaskSync.Text:= 'wait...';
      btnTTaskSync.Enabled:= False;

      Sleep(4000);
      Value:= Random(100);
      // this will manage the synchronization with UI,
      // so events can be managed properly
      TThread.Synchronize(nil,
                          procedure Begin
                            lblDescription.Text:= Value.ToString;
                            btnTTaskSync.Text:= 'With TTask / Sync';
                            btnTTaskSync.Enabled:= True;
                          End);
    End
  );
end;

procedure TForm1.btnWithoutTTaskClick(Sender: TObject);
var
  Value : Integer;
begin
  // "Assume" this is a time consuming process
  // ex: network related task, database operation...

  lblFormStatus.Text:= 'Form will Freeze!';

  Sleep(4000);
  Value:= Random(100);
  lblDescription.Text:= Value.ToString;

  lblFormStatus.Text:= 'Form is Alive...';
end;

procedure TForm1.btnWithTTaskClick(Sender: TObject);
var
  Value: Integer;
begin
  // the same process is run via TTask
  TTask.Run(
    procedure Begin
      // these UI updates are not handling well...
      btnWithTTask.Text:= 'wait...';
      btnWithTTask.Enabled:= False;


      Sleep(4000);
      Value:= Random(100);
      lblDescription.Text:= Value.ToString;

      btnWithTTask.Text:= 'With TTask / No Sync';
      btnWithTTask.Enabled:= True;
    End
  );

end;

end.
