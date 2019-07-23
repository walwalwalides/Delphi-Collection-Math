object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmMain'
  ClientHeight = 426
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GrBoxCalcul: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 329
    Height = 134
    Align = alTop
    Caption = 'Addition'
    TabOrder = 0
    object lblPlus: TLabel
      Left = 149
      Top = 35
      Width = 26
      Height = 24
      Alignment = taCenter
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtResult: TEdit
      Left = 8
      Top = 67
      Width = 303
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 2
    end
    object edtValue1: TEdit
      Left = 8
      Top = 40
      Width = 135
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtValue1Change
    end
    object edtValue2: TEdit
      Left = 176
      Top = 40
      Width = 135
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      OnChange = edtValue2Change
    end
    object btnSum: TButton
      Left = 97
      Top = 97
      Width = 135
      Height = 25
      Cursor = crHandPoint
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnSumClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 184
    object File1: TMenuItem
      Caption = 'File'
      object OpenFiles1: TMenuItem
        Action = actOpenFile
      end
      object OpenFolders1: TMenuItem
        Action = actOpenFolder
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actExit
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object CopytoClipboard1: TMenuItem
        Action = actCopyToClipboard
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Refresh1: TMenuItem
        Action = actRefresh
      end
    end
    object A1: TMenuItem
      Caption = 'Action'
      object C1: TMenuItem
        Action = actClear
      end
      object miSum: TMenuItem
        Action = actSum
        Enabled = False
      end
    end
    object Option1: TMenuItem
      Caption = 'Option'
      object actOption1: TMenuItem
        Action = actOption
      end
    end
    object A2: TMenuItem
      Caption = 'About'
      object actAbout1: TMenuItem
        Action = actAbout
      end
    end
  end
  object ActionList1: TActionList
    Left = 137
    Top = 208
    object actClear: TAction
      Category = 'Action'
      Caption = 'Clear'
      ShortCut = 16451
      OnExecute = actClearExecute
    end
    object actSum: TAction
      Category = 'Action'
      Caption = 'Sum'
      ShortCut = 16467
      OnExecute = actSumExecute
    end
    object actOpenFile: TAction
      Category = 'File'
      Caption = 'Open File(s)...'
    end
    object actShowInExplorer: TAction
      Caption = 'Show in Explorer'
    end
    object actOpenFolder: TAction
      Category = 'File'
      Caption = 'Open Folder(s)...'
    end
    object actExit: TAction
      Category = 'File'
      Caption = 'Exit'
      OnExecute = actExitExecute
    end
    object actCopyToClipboard: TAction
      Category = 'Edit'
      Caption = 'Copy to Clipboard'
      ShortCut = 16451
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = 'Refresh'
      ShortCut = 116
    end
    object actOption: TAction
      Category = 'Option'
      Caption = 'Option'
      ShortCut = 16463
    end
    object actAbout: TAction
      Category = 'About'
      Caption = 'Info'
      ShortCut = 16457
      OnExecute = actAboutExecute
    end
  end
end
