object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 395
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 344
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 297
    Height = 395
    Align = alLeft
    Columns = <>
    TabOrder = 1
    ViewStyle = vsList
  end
  object PrototypeBindSource1: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'ContactName1'
        Generator = 'ContactNames'
        ReadOnly = False
      end
      item
        Name = 'ContactBitmap1'
        FieldType = ftBitmap
        Generator = 'ContactBitmaps'
        ReadOnly = False
      end
      item
        Name = 'Value'
        FieldType = ftUInteger
        Generator = 'AlphaColors'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = PrototypeBindSource1CreateAdapter
    Left = 352
    Top = 168
  end
end
