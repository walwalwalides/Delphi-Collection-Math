object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 502
  ClientWidth = 831
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 831
    Height = 177
    Align = alTop
    TabOrder = 0
    object MonthCalendar1: TMonthCalendar
      Left = 1
      Top = 1
      Width = 191
      Height = 175
      Align = alLeft
      Date = 43804.000000000000000000
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 195
      Top = 4
      Width = 632
      Height = 169
      Align = alClient
      Caption = 'Birhtday Paradox'
      TabOrder = 1
      ExplicitLeft = 179
      ExplicitTop = 7
      object lblCD: TLabel
        Left = 258
        Top = 75
        Width = 82
        Height = 13
        Caption = 'Chance Differetn'
      end
      object lblPairs: TLabel
        Left = 258
        Top = 14
        Width = 23
        Height = 13
        Caption = 'Pairs'
      end
      object lblCM: TLabel
        Left = 259
        Top = 104
        Width = 81
        Height = 13
        Caption = 'Chance of Match'
      end
      object lblCP: TLabel
        Left = 258
        Top = 41
        Width = 76
        Height = 13
        Caption = 'Chance per Pair'
      end
      object lblPairsV: TLabel
        Left = 440
        Top = 14
        Width = 39
        Height = 13
        Caption = 'lblPairsV'
      end
      object lblCPV: TLabel
        Left = 440
        Top = 41
        Width = 29
        Height = 13
        Caption = 'lblCPV'
      end
      object lblCDV: TLabel
        Left = 440
        Top = 75
        Width = 30
        Height = 13
        Caption = 'lblCDV'
      end
      object lblCMV: TLabel
        Left = 440
        Top = 104
        Width = 31
        Height = 13
        Caption = 'lblCMV'
      end
      object bvlvertical: TBevel
        Left = 153
        Top = 11
        Width = 1
        Height = 152
      end
      object bvlVertical2: TBevel
        Left = 161
        Top = 17
        Width = 1
        Height = 152
      end
      object lbledtPepole: TLabeledEdit
        Left = 48
        Top = 38
        Width = 121
        Height = 21
        EditLabel.Width = 32
        EditLabel.Height = 13
        EditLabel.Caption = 'People'
        TabOrder = 0
        OnChange = lbledtPepoleChange
      end
      object lbledtDays: TLabeledEdit
        Left = 48
        Top = 75
        Width = 121
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'Day'
        TabOrder = 1
        OnChange = lbledtDaysChange
      end
      object BitBtnCalculate: TBitBtn
        Left = 72
        Top = 128
        Width = 75
        Height = 25
        Kind = bkOK
        NumGlyphs = 2
        TabOrder = 2
        OnClick = BitBtnCalculateClick
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 272
    Top = 344
  end
  object MainMenu1: TMainMenu
    Left = 224
    Top = 288
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
        Action = actSettings
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
    Left = 321
    Top = 280
    object actClear: TAction
      Category = 'Action'
      Caption = 'Clear'
      ShortCut = 16451
    end
    object actSum: TAction
      Category = 'Action'
      Caption = 'Sum'
      ShortCut = 16467
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
    object actSettings: TAction
      Category = 'Option'
      Caption = 'Settings'
      ShortCut = 16467
    end
    object actAbout: TAction
      Category = 'About'
      Caption = 'Info'
      ShortCut = 16457
      OnExecute = actAboutExecute
    end
  end
end
