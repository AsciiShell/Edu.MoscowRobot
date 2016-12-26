procedure InitializeComponent;
    begin
        var resources: System.ComponentModel.ComponentResourceManager := new System.ComponentModel.ComponentResourceManager(typeof(Form1));
        self.StartButton := new System.Windows.Forms.Button();
        self.StopButton := new System.Windows.Forms.Button();
        self.InfoLabel := new System.Windows.Forms.Label();
        self.pictureBoxMap := new System.Windows.Forms.PictureBox();
        self.panelControls := new System.Windows.Forms.Panel();
        self.trackBarGradScan := new System.Windows.Forms.TrackBar();
        self.labelGradTurn := new System.Windows.Forms.Label();
        self.labelLog := new System.Windows.Forms.Label();
        self.labelSpeedScan := new System.Windows.Forms.Label();
        self.trackBarSpeedScan := new System.Windows.Forms.TrackBar();
        self.buttonSave := new System.Windows.Forms.Button();
        self.saveFileDialog1 := new System.Windows.Forms.SaveFileDialog();
        (System.ComponentModel.ISupportInitialize(self.pictureBoxMap)).BeginInit();
        self.panelControls.SuspendLayout();
        (System.ComponentModel.ISupportInitialize(self.trackBarGradScan)).BeginInit();
        (System.ComponentModel.ISupportInitialize(self.trackBarSpeedScan)).BeginInit();
        self.SuspendLayout();
        // 
        // StartButton
        // 
        self.StartButton.Location := new System.Drawing.Point(18, 12);
        self.StartButton.Name := 'StartButton';
        self.StartButton.Size := new System.Drawing.Size(75, 23);
        self.StartButton.TabIndex := 1;
        self.StartButton.Text := 'Старт';
        self.StartButton.UseVisualStyleBackColor := true;
        self.StartButton.Click += StartButton_Click;
        // 
        // StopButton
        // 
        self.StopButton.Enabled := false;
        self.StopButton.Location := new System.Drawing.Point(18, 41);
        self.StopButton.Name := 'StopButton';
        self.StopButton.Size := new System.Drawing.Size(75, 23);
        self.StopButton.TabIndex := 2;
        self.StopButton.Text := 'Стоп';
        self.StopButton.UseVisualStyleBackColor := true;
        self.StopButton.Click += StopButton_Click;
        // 
        // InfoLabel
        // 
        self.InfoLabel.Font := new System.Drawing.Font('Microsoft Sans Serif', 10, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.InfoLabel.Location := new System.Drawing.Point(12, 375);
        self.InfoLabel.Name := 'InfoLabel';
        self.InfoLabel.Size := new System.Drawing.Size(470, 23);
        self.InfoLabel.TabIndex := 3;
        // 
        // pictureBoxMap
        // 
        self.pictureBoxMap.Location := new System.Drawing.Point(12, 12);
        self.pictureBoxMap.Name := 'pictureBoxMap';
        self.pictureBoxMap.Size := new System.Drawing.Size(470, 360);
        self.pictureBoxMap.TabIndex := 0;
        self.pictureBoxMap.TabStop := false;
        self.pictureBoxMap.MouseLeave += pictureBoxMap_MouseLeave;
        self.pictureBoxMap.MouseMove += pictureBoxMap_MouseMove;
        // 
        // panelControls
        // 
        self.panelControls.Controls.Add(self.buttonSave);
        self.panelControls.Controls.Add(self.trackBarGradScan);
        self.panelControls.Controls.Add(self.labelGradTurn);
        self.panelControls.Controls.Add(self.labelSpeedScan);
        self.panelControls.Controls.Add(self.trackBarSpeedScan);
        self.panelControls.Controls.Add(self.StartButton);
        self.panelControls.Controls.Add(self.StopButton);
        self.panelControls.Dock := System.Windows.Forms.DockStyle.Right;
        self.panelControls.Location := new System.Drawing.Point(518, 0);
        self.panelControls.Name := 'panelControls';
        self.panelControls.Size := new System.Drawing.Size(174, 561);
        self.panelControls.TabIndex := 4;
        // 
        // trackBarGradScan
        // 
        self.trackBarGradScan.Location := new System.Drawing.Point(18, 176);
        self.trackBarGradScan.Maximum := 360;
        self.trackBarGradScan.Name := 'trackBarGradScan';
        self.trackBarGradScan.Size := new System.Drawing.Size(144, 45);
        self.trackBarGradScan.TabIndex := 9;
        self.trackBarGradScan.TickFrequency := 34;
        self.trackBarGradScan.Scroll += trackBarGradScan_Scroll;
        // 
        // labelGradTurn
        // 
        self.labelGradTurn.Location := new System.Drawing.Point(18, 149);
        self.labelGradTurn.Name := 'labelGradTurn';
        self.labelGradTurn.Size := new System.Drawing.Size(144, 23);
        self.labelGradTurn.TabIndex := 8;
        self.labelGradTurn.Text := 'Угол поворота сканера';
        // 
        // labelLog
        // 
        self.labelLog.Location := new System.Drawing.Point(12, 398);
        self.labelLog.Name := 'labelLog';
        self.labelLog.Size := new System.Drawing.Size(470, 154);
        self.labelLog.TabIndex := 7;
        // 
        // labelSpeedScan
        // 
        self.labelSpeedScan.Location := new System.Drawing.Point(18, 71);
        self.labelSpeedScan.Name := 'labelSpeedScan';
        self.labelSpeedScan.Size := new System.Drawing.Size(153, 23);
        self.labelSpeedScan.TabIndex := 4;
        self.labelSpeedScan.Text := 'Скорость проверки';
        // 
        // trackBarSpeedScan
        // 
        self.trackBarSpeedScan.Location := new System.Drawing.Point(18, 97);
        self.trackBarSpeedScan.Maximum := 100;
        self.trackBarSpeedScan.Name := 'trackBarSpeedScan';
        self.trackBarSpeedScan.Size := new System.Drawing.Size(144, 45);
        self.trackBarSpeedScan.TabIndex := 3;
        self.trackBarSpeedScan.TickFrequency := 10;
        self.trackBarSpeedScan.Scroll += trackBarSpeedScan_Scroll;
        // 
        // buttonSave
        // 
        self.buttonSave.Location := new System.Drawing.Point(18, 228);
        self.buttonSave.Name := 'buttonSave';
        self.buttonSave.Size := new System.Drawing.Size(144, 23);
        self.buttonSave.TabIndex := 10;
        self.buttonSave.Text := 'Сохранить';
        self.buttonSave.UseVisualStyleBackColor := true;
        self.buttonSave.Click += buttonSave_Click;
        // 
        // Form1
        // 
        self.BackColor := System.Drawing.SystemColors.Control;
        self.ClientSize := new System.Drawing.Size(692, 561);
        self.Controls.Add(self.panelControls);
        self.Controls.Add(self.pictureBoxMap);
        self.Controls.Add(self.labelLog);
        self.Controls.Add(self.InfoLabel);
        self.Icon := (System.Drawing.Icon(resources.GetObject('$this.Icon')));
        self.Name := 'Form1';
        self.Text := 'Проверка ТВЭЛ';
        self.FormClosing += Form1_FormClosing;
        self.Load += Form1_Load;
        (System.ComponentModel.ISupportInitialize(self.pictureBoxMap)).EndInit();
        self.panelControls.ResumeLayout(false);
        self.panelControls.PerformLayout();
        (System.ComponentModel.ISupportInitialize(self.trackBarGradScan)).EndInit();
        (System.ComponentModel.ISupportInitialize(self.trackBarSpeedScan)).EndInit();
        self.ResumeLayout(false);
    end;
