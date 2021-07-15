object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Balanza de Carga'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Crear Vacio'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 177
    Top = 8
    Width = 320
    Height = 209
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Codigo'
    TabOrder = 2
  end
  object LabeledEdit2: TLabeledEdit
    Left = 8
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'Nombre'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 8
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Agregar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 164
    Width = 75
    Height = 25
    Caption = 'Recuperar'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 89
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Baja'
    TabOrder = 6
  end
  object Button5: TButton
    Left = 89
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Alta'
    TabOrder = 7
  end
  object Button6: TButton
    Left = 89
    Top = 164
    Width = 75
    Height = 25
    Caption = 'Modificacion'
    TabOrder = 8
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 195
    Width = 75
    Height = 25
    Caption = 'Rec String'
    TabOrder = 9
    OnClick = Button7Click
  end
end
