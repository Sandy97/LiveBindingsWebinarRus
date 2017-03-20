object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 458
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 231
    Height = 458
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    Columns = <>
    TabOrder = 0
    ViewStyle = vsList
    ExplicitHeight = 673
  end
  object Edit1: TEdit
    Left = 300
    Top = 70
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 300
    Top = 150
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 2
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 323
    Top = 321
    Width = 94
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 300
    Top = 288
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 4
    TextHint = #1053#1086#1074#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
  end
  object NavigatorpbsFooObjectDS: TBindNavigator
    Left = 239
    Top = 10
    Width = 300
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataSource = pbsFooObjectDS
    Orientation = orHorizontal
    TabOrder = 5
  end
  object pbsFooObjectDS: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Value'
        FieldType = ftUInteger
        Generator = 'AlphaColors'
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
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooObjectDSCreateAdapter
    Left = 256
    Top = 188
  end
  object pbsFooFoo2ObjectDS: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Foo2Value'
        Generator = 'ColorsNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooFoo2ObjectDSCreateAdapter
    Left = 260
    Top = 240
  end
end
