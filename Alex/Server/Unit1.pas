unit Unit1;

interface

uses
    System,
    System.Drawing,
    System.Windows.Forms,
    System.ComponentModel,
    System.Net,
    System.Net.Sockets;

type
    data = record
        value: integer;
        X: integer;
    end;

var
    BackServer: BackgroundWorker := new System.ComponentModel.BackgroundWorker();
    BackCamera: BackgroundWorker := new System.ComponentModel.BackgroundWorker();
    ServerIP: IPAddress;
    LastA, LastB, LastC: data;
    PenA := new Pen(Color.Red, 2);
    PenB := new Pen(Color.Green, 2);
    PenC := new Pen(Color.Blue, 2);
    DrawTick: integer := 1;
    DrawI := 0;

const
    PortTCP = 5555;

type
    Form1 = class(Form)
        procedure Scaner_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
        procedure Scaner_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure Scaner_DoWork(sender: Object; e: DoWorkEventArgs);
        
        procedure BackCamera_DoWork(sender: Object; e: DoWorkEventArgs);
        procedure BackCamera_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure BackCamera_RunWorkerCompleted(sender: Object; e: RunWorkerCompletedEventArgs);
        
        procedure Form1_Load(sender: Object; e: EventArgs);
        procedure Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
        procedure pictureBoxCamera_Paint(sender: Object; e: PaintEventArgs);
        procedure labelMotorCR_Click(sender: Object; e: EventArgs);
        procedure pictureBox1_Click(sender: Object; e: EventArgs);
        procedure labelMotorBR_Click(sender: Object; e: EventArgs);
        procedure labelSensor1_Click(sender: Object; e: EventArgs);
        procedure panel2_Paint(sender: Object; e: PaintEventArgs);
    {$region FormDesigner}
  private
    {$resource Unit1.Form1.resources}
    components: System.ComponentModel.IContainer;
    labelMotorA: &Label;
    labelMotorAR: &Label;
    labelMotorBR: &Label;
    labelMotorB: &Label;
    labelMotorCR: &Label;
    labelMotorC: &Label;
    labelSensor1R: &Label;
    labelSensor1: &Label;
    panel1: Panel;
    label1: &Label;
    panelGraph: Panel;
    panel2: Panel;
    label5: &Label;
    label4: &Label;
    label3: &Label;
    pictureBox1: PictureBox;
    label2: &Label;
    label6: &Label;
    {$include Unit1.Form1.inc}
    {$endregion FormDesigner}
    public 
        constructor;
        begin
            BackServer.DoWork += Scaner_Dowork;
            BackServer.RunWorkerCompleted += Scaner_RunWorkerCompleted;
            BackServer.ProgressChanged += Scaner_ProgressChanged;
            
            BackCamera.DoWork += BackCamera_DoWork;
            BackCamera.ProgressChanged += BackCamera_ProgressChanged;
            BackCamera.RunWorkerCompleted += BackCamera_RunWorkerCompleted;
            InitializeComponent;
        end;
    end;


var
    videoImage: Image;

implementation



procedure Form1.Scaner_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
begin
    BackServer.RunWorkerAsync();
    //timer1.Enabled := false;
    if e.Cancelled then
    begin
    end
    else if (e.Error <> nil) then
    begin
        
    end
    else
    begin
    end
end;

procedure Form1.Scaner_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    
end;



procedure Form1.Scaner_DoWork(sender: Object; e: DoWorkEventArgs);
begin
    var worker := sender as BackgroundWorker;
    begin
        // Data buffer for incoming data.
        var bytes := new byte[1024];
        
        // Connect to a remote device.
        try
            
            // Establish the remote endpoint for the socket.
            // This example uses port 11000 on the local computer.
            var remoteEP := new IPEndPoint(ServerIP, portTCP);
            
            // Create a TCP/IP  socket.
            var Client := new Socket(AddressFamily.InterNetwork, 
            SocketType.Stream, ProtocolType.Tcp );
            
            // Connect the socket to the remote endpoint. Catch any errors.
            try
                Client.Connect(remoteEP);
                
                // Receive the response from the remote device.
                var bytesRec := Client.Receive(bytes);
                var message := Encoding.ASCII.GetString(bytes, 0, bytesRec);
                var param := message.Split(' ');
                var boolDraw := (DrawI mod DrawTick) = 0;
                if boolDraw then DrawI := 1
                else inc(DrawI);
                for var i := 0 to param.Length - 1 do
                begin
                    if param[i] = 'A' then
                    begin
                        if boolDraw then
                        begin
                            var gr := panelGraph.CreateGraphics;
                            if LastA.X > panelGraph.Width then 
                            begin
                                gr.Clear(BackColor);
                                LastA.X := 0;
                            end;
                            var value := Round((-1) * integer.Parse(param[i + 1]) / 17) + 300;
                            gr.DrawLine(PenA, LastA.X, LastA.value, LastA.X + 2, value);
                            gr.Dispose;
                            LastA.X += 2;
                            LastA.value := value;
                        end;
                        labelMotorAR.Text := param[i + 1];
                    end;
                    if param[i] = 'B' then 
                    begin
                        
                        if boolDraw then
                        begin
                            var gr := panelGraph.CreateGraphics;
                            if LastB.X > panelGraph.Width then 
                            begin
                                gr.Clear(BackColor);
                                LastB.X := 0;
                            end;
                            var value := Round((300 + (-1) * integer.Parse(param[i + 1])) / 1.7);
                            
                            gr.DrawLine(PenB, LastB.X, LastB.value, LastB.X + 2, value);
                            gr.Dispose;
                            LastB.X += 2;
                            LastB.value := value;
                        end;
                        labelMotorBR.Text := param[i + 1];
                    end;
                    if param[i] = 'C' then 
                    begin
                        
                        if boolDraw then
                        begin
                            var gr := panelGraph.CreateGraphics;
                            if LastC.X > panelGraph.Width then 
                            begin
                                gr.Clear(BackColor);
                                LastC.X := 0;
                            end;
                            var value := ((-1) * integer.Parse(param[i + 1]) div 7) mod 360;
                            gr.DrawLine(PenC, LastC.X, LastC.value + 510, LastC.X + 2, 510 + value);
                            gr.Dispose;
                            LastC.X += 2;
                            LastC.value := value;
                        end;
                        labelMotorCR.Text := ((integer.Parse(param[i + 1]) div 7) mod 360 ).Tostring;
                    end;
                    if param[i] = 'S1' then 
                        case param[i + 1][1] of
                            '0':  
                                begin
                                    labelSensor1R.Text := 'Цвета нет';
                                    labelSensor1R.ForeColor := Color.FromArgb(127, 127, 127, 127);
                                end;
                            '1':  
                                begin
                                    labelSensor1R.Text := 'Черный';
                                    labelSensor1R.ForeColor := Color.Black;
                                end;
                            '2':  
                                begin
                                    labelSensor1R.Text := 'Голубой';
                                    labelSensor1R.ForeColor := Color.Blue;
                                end;
                            '3':  
                                begin
                                    labelSensor1R.Text := 'Зеленый';
                                    labelSensor1R.ForeColor := Color.Green;
                                end;
                            '4':  
                                begin
                                    labelSensor1R.Text := 'Желтый';
                                    labelSensor1R.ForeColor := Color.Yellow;
                                end;
                            '5':  
                                begin
                                    labelSensor1R.Text := 'Красный';
                                    labelSensor1R.ForeColor := Color.Red;
                                end;
                            '6':  
                                begin
                                    labelSensor1R.Text := 'Белый';
                                    labelSensor1R.ForeColor := Color.White;
                                end;
                            '7':  
                                begin
                                    labelSensor1R.Text := 'Коричневый';
                                    labelSensor1R.ForeColor := Color.Brown;
                                end;
                        end;
                end;
                // Release the socket.
                Client.Shutdown(SocketShutdown.Both);
                Client.Close();
            except
                on ane: ArgumentNullException do
                    Console.WriteLine('ArgumentNullException : {0}', ane.ToString());
                on se: SocketException do
                    Console.WriteLine('SocketException : {0}', se.ToString());
                on ue: Exception do
                    Console.WriteLine('Unexpected exception : {0}', ue.ToString());
            
            end;
        
        except
            on ue: Exception do
                Console.WriteLine('Unexpected exception : {0}', ue.ToString());
        end;
    end;    
end;

procedure Form1.Form1_Load(sender: Object; e: EventArgs);
begin
    ServerIP := IPAddress.Parse(System.IO.&file.ReadAllLines('IpConfig.txt')[0]);
    BackServer.RunWorkerAsync();
    BackCamera.RunWorkerAsync();
    
end;


procedure Form1.BackCamera_DoWork(sender: Object; e: DoWorkEventArgs);
begin
    var worker := sender as BackgroundWorker;
    begin
        // Data buffer for incoming data.
        var bytes := new byte[1228800];
        
        // Connect to a remote device.
        try
            
            // Establish the remote endpoint for the socket.
            // This example uses port 11000 on the local computer.
            var remoteEP := new IPEndPoint(ServerIP, portTCP + 1);
            
            // Create a TCP/IP  socket.
            var Client := new Socket(AddressFamily.InterNetwork, 
            SocketType.Stream, ProtocolType.Tcp );
            
            // Connect the socket to the remote endpoint. Catch any errors.
            try
                Client.Connect(remoteEP);
                
                // Receive the response from the remote device.
                var bytesRec := Client.Receive(bytes);
                var ms := new System.IO.MemoryStream(bytes);
                pictureBox1.Image := Image.FromStream(ms);
                // Release the socket.
                Client.Shutdown(SocketShutdown.Both);
                Client.Close();
            except
                on ane: ArgumentNullException do
                    Console.WriteLine('ArgumentNullException : {0}', ane.ToString());
                on se: SocketException do
                    Console.WriteLine('SocketException : {0}', se.ToString());
                on ue: Exception do
                    Console.WriteLine('Unexpected exception : {0}', ue.ToString());
            
            end;
        
        except
            on ue: Exception do
                Console.WriteLine('Unexpected exception : {0}', ue.ToString());
        end;
    end;  
end;


procedure Form1.BackCamera_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    
end;


procedure Form1.BackCamera_RunWorkerCompleted(sender: Object; e: RunWorkerCompletedEventArgs);
begin
    BackCamera.RunWorkerAsync();
    if e.Cancelled then
    begin
    end
    else if (e.Error <> nil) then
    begin
        
    end
    else
    begin
    end
end;

procedure Form1.Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
begin
    System.Diagnostics.Process.GetCurrentProcess.Kill();
end;

procedure Form1.pictureBoxCamera_Paint(sender: Object; e: PaintEventArgs);
begin
    
end;

procedure Form1.labelMotorCR_Click(sender: Object; e: EventArgs);
begin
    
end;

procedure Form1.pictureBox1_Click(sender: Object; e: EventArgs);
begin
    
end;

procedure Form1.labelMotorBR_Click(sender: Object; e: EventArgs);
begin
    
end;

procedure Form1.labelSensor1_Click(sender: Object; e: EventArgs);
begin
    
end;

procedure Form1.panel2_Paint(sender: Object; e: PaintEventArgs);
begin
    var gr := panel2.CreateGraphics;
    gr.DrawLine(PenA, 5, 15, 150, 15);
    gr.DrawLine(PenB, 5, 50, 150, 50);
    gr.DrawLine(PenC, 5, 85, 150, 85);
    gr.Dispose;
end;

end.