unit Unit1;

interface

uses System, System.Drawing, System.Windows.Forms,System.ComponentModel;
uses EV3Communication,SmallBasicEV3Extension,Microsoft.SmallBasic.&Library;
var
    BackServer: BackgroundWorker := new System.ComponentModel.BackgroundWorker();

type
    Form1 = class(Form)
        procedure timer1_Tick(sender: Object; e: EventArgs);
        procedure button1_Click(sender: Object; e: EventArgs);
        
        procedure BackServer_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
        procedure BackServer_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure BackServer_DoWork(sender: Object; e: DoWorkEventArgs);
        procedure Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
        procedure trackBar1_Scroll(sender: Object; e: EventArgs);
        procedure trackBar2_Scroll(sender: Object; e: EventArgs);
        procedure trackBar3_Scroll(sender: Object; e: EventArgs);
        procedure trackBar4_Scroll(sender: Object; e: EventArgs);
        procedure Form1_Load(sender: Object; e: EventArgs);
    procedure button2_Click(sender: Object; e: EventArgs);
    {$region FormDesigner}
  private
    {$resource Unit1.Form1.resources}
    label1: &Label;
    label2: &Label;
    label3: &Label;
    label4: &Label;
    trackBar1: TrackBar;
    trackBar2: TrackBar;
    trackBar3: TrackBar;
    trackBar4: TrackBar;
    button1: Button;
    timer1: Timer;
    button2: Button;
    components: System.ComponentModel.IContainer;
    {$include Unit1.Form1.inc}
    {$endregion FormDesigner}
    public 
        constructor;
        begin
            BackServer.DoWork += BackServer_Dowork;
            BackServer.RunWorkerCompleted += BackServer_RunWorkerCompleted;
            BackServer.ProgressChanged += BackServer_ProgressChanged;
            BackServer.WorkerReportsProgress := true;
            BackServer.WorkerSupportsCancellation := true;
            BackServer.RunWorkerAsync;
            InitializeComponent;
        end;
    end;

implementation

procedure Form1.timer1_Tick(sender: Object; e: EventArgs);
begin
    label1.Text := Motor.GetCount(new primitive('A')).ToString;
    label2.Text := Motor.GetCount(new primitive('B')).ToString;
    label3.Text := Motor.GetCount(new primitive('C')).ToString;
    label4.Text := Motor.GetCount(new primitive('D')).ToString;
    
end;

procedure Form1.button1_Click(sender: Object; e: EventArgs);
begin
    Motor.Stop(new primitive('A'), true);
    Motor.Stop(new primitive('B'), true);
    Motor.Stop(new primitive('C'), true);
    Motor.Stop(new primitive('D'), true);
    trackBar1.Value := 0;
    trackBar2.Value := 0;
    trackBar3.Value := 0;
    trackBar4.Value := 0;
end;



procedure Form1.BackServer_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
begin
    
end;


procedure Form1.BackServer_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    
end;


procedure Form1.BackServer_DoWork(sender: Object; e: DoWorkEventArgs);
begin
    
end;

procedure Form1.Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
begin
    System.Diagnostics.Process.GetCurrentProcess.Kill;
end;

procedure Form1.trackBar1_Scroll(sender: Object; e: EventArgs);
begin
    Motor.Start(new primitive('A'), trackBar1.Value);
    
end;

procedure Form1.trackBar2_Scroll(sender: Object; e: EventArgs);
begin
    Motor.Start(new primitive('B'), trackBar2.Value);
end;

procedure Form1.trackBar3_Scroll(sender: Object; e: EventArgs);
begin
    Motor.Start(new primitive('C'), trackBar3.Value);
end;

procedure Form1.trackBar4_Scroll(sender: Object; e: EventArgs);
begin
    Motor.Start(new primitive('D'), trackBar4.Value);
end;

procedure Form1.Form1_Load(sender: Object; e: EventArgs);
begin
    timer1.start;
end;

procedure Form1.button2_Click(sender: Object; e: EventArgs);
begin
  Motor.ResetCount(new primitive('A'));
  Motor.ResetCount(new primitive('B'));
  Motor.ResetCount(new primitive('C'));
  Motor.ResetCount(new primitive('D'));
end;


end.