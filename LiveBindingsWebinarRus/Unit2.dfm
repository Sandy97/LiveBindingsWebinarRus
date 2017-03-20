object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 607
  ClientWidth = 1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object ListView1: TListView
    Left = 10
    Top = 30
    Width = 501
    Height = 301
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <>
    TabOrder = 0
    ViewStyle = vsList
  end
  object Edit1: TEdit
    Left = 519
    Top = 70
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
    Text = '4290283019'
  end
  object Edit2: TEdit
    Left = 519
    Top = 140
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 519
    Top = 220
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 3
    Text = 'Edit3'
  end
  object ListView2: TListView
    Left = 702
    Top = 22
    Width = 192
    Height = 301
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Columns = <>
    TabOrder = 4
    ViewStyle = vsList
  end
  object Edit4: TEdit
    Left = 913
    Top = 62
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 5
    Text = 'Edit4'
  end
  object Edit5: TEdit
    Left = 913
    Top = 132
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 6
    Text = 'Edit5'
  end
  object DBGrid1: TDBGrid
    Left = 10
    Top = 350
    Width = 501
    Height = 221
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataSource = DataSource1
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pbsFooObjects: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Value'
        FieldType = ftUInteger
        Generator = 'AlphaColors'
        ReadOnly = False
      end
      item
        Name = 'Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooObjectsCreateAdapter
    Left = 424
    Top = 40
  end
  object pbsFooFoo2Object: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Foo2Value'
        Generator = 'ColorsNames'
        ReadOnly = True
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooFoo2ObjectCreateAdapter
    Left = 416
    Top = 104
  end
  object pbsFooFeeObject: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'FeeValue'
        Generator = 'ColorsNames'
        ReadOnly = True
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFooFeeObjectCreateAdapter
    Left = 416
    Top = 168
  end
  object pbsFudObjects: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Value'
        FieldType = ftUInteger
        Generator = 'AlphaColors'
        ReadOnly = False
      end
      item
        Name = 'Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFudObjectsCreateAdapter
    Left = 659
    Top = 64
  end
  object pbsFudFoo: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Foo2Value'
        Generator = 'ColorsNames'
        ReadOnly = True
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsFudFooCreateAdapter
    Left = 667
    Top = 120
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 448
    Top = 288
    object FDMemTable1Name: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 10
    end
    object FDMemTable1Colour: TStringField
      DisplayWidth = 30
      FieldName = 'Colour'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 448
    Top = 344
  end
end
