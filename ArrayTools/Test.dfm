object frmTest: TfrmTest
  Left = 0
  Top = 0
  Caption = 'Test'
  ClientHeight = 566
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    563
    566)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSort2Array: TButton
    Left = 8
    Top = 533
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Sort2Array'
    TabOrder = 0
    OnClick = btnSort2ArrayClick
  end
  object btnIncArray: TButton
    Left = 192
    Top = 533
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'IncArray'
    TabOrder = 1
    OnClick = btnIncArrayClick
  end
  object btnRotate: TButton
    Left = 100
    Top = 533
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'RotateArray'
    TabOrder = 2
    OnClick = btnRotateClick
  end
  object btnShortestSubArray: TButton
    Left = 284
    Top = 533
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'ShortSubArray'
    TabOrder = 3
    OnClick = btnShortestSubArrayClick
  end
  object btnSum: TButton
    Left = 376
    Top = 533
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Sum'
    TabOrder = 4
    OnClick = btnSumClick
  end
  object btnAdd1: TButton
    Left = 468
    Top = 533
    Width = 86
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add One'
    TabOrder = 5
    OnClick = btnAdd1Click
  end
end
