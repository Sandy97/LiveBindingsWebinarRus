unit UDBL01;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Button1: TButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    valuel: double;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
  Label1.caption:='';
end;

end.
