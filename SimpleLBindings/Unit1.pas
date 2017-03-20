unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Vcl.ComCtrls, Vcl.ExtCtrls,
  Data.Bind.DBScope, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.DBCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    FDMemTable1: TFDMemTable;
    FDMemTable1SpeciesNo: TFloatField;
    FDMemTable1Category: TStringField;
    FDMemTable1Common_Name: TStringField;
    FDMemTable1SpeciesName: TStringField;
    FDMemTable1Lengthcm: TFloatField;
    FDMemTable1Length_In: TFloatField;
    FDMemTable1Notes: TMemoField;
    FDMemTable1Graphic: TBlobField;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Edit1: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    Image1: TImage;
    LinkControlToField2: TLinkControlToField;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
