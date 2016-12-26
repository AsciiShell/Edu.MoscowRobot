procedure InitializeComponent;
    begin
        self.components := new System.ComponentModel.Container();
        self.label1 := new System.Windows.Forms.Label();
        self.label2 := new System.Windows.Forms.Label();
        self.label3 := new System.Windows.Forms.Label();
        self.label4 := new System.Windows.Forms.Label();
        self.trackBar1 := new System.Windows.Forms.TrackBar();
        self.trackBar2 := new System.Windows.Forms.TrackBar();
        self.trackBar3 := new System.Windows.Forms.TrackBar();
        self.trackBar4 := new System.Windows.Forms.TrackBar();
        self.button1 := new System.Windows.Forms.Button();
        self.timer1 := new System.Windows.Forms.Timer(self.components);
        self.button2 := new System.Windows.Forms.Button();
        (System.ComponentModel.ISupportInitialize(self.trackBar1)).BeginInit();
        (System.ComponentModel.ISupportInitialize(self.trackBar2)).BeginInit();
        (System.ComponentModel.ISupportInitialize(self.trackBar3)).BeginInit();
        (System.ComponentModel.ISupportInitialize(self.trackBar4)).BeginInit();
        self.SuspendLayout();
        // 
        // label1
        // 
        self.label1.Location := new System.Drawing.Point(57, 9);
        self.label1.Name := 'label1';
        self.label1.Size := new System.Drawing.Size(100, 23);
        self.label1.TabIndex := 0;
        self.label1.Text := 'label1';
        // 
        // label2
        // 
        self.label2.Location := new System.Drawing.Point(164, 9);
        self.label2.Name := 'label2';
        self.label2.Size := new System.Drawing.Size(100, 23);
        self.label2.TabIndex := 1;
        self.label2.Text := 'label2';
        // 
        // label3
        // 
        self.label3.Location := new System.Drawing.Point(271, 9);
        self.label3.Name := 'label3';
        self.label3.Size := new System.Drawing.Size(100, 23);
        self.label3.TabIndex := 2;
        self.label3.Text := 'label3';
        // 
        // label4
        // 
        self.label4.Location := new System.Drawing.Point(378, 9);
        self.label4.Name := 'label4';
        self.label4.Size := new System.Drawing.Size(100, 23);
        self.label4.TabIndex := 3;
        self.label4.Text := 'label4';
        // 
        // trackBar1
        // 
        self.trackBar1.Location := new System.Drawing.Point(49, 35);
        self.trackBar1.Maximum := 100;
        self.trackBar1.Minimum := -100;
        self.trackBar1.Name := 'trackBar1';
        self.trackBar1.Orientation := System.Windows.Forms.Orientation.Vertical;
        self.trackBar1.Size := new System.Drawing.Size(45, 450);
        self.trackBar1.TabIndex := 4;
        self.trackBar1.Scroll += trackBar1_Scroll;
        // 
        // trackBar2
        // 
        self.trackBar2.Location := new System.Drawing.Point(164, 35);
        self.trackBar2.Maximum := 100;
        self.trackBar2.Minimum := -100;
        self.trackBar2.Name := 'trackBar2';
        self.trackBar2.Orientation := System.Windows.Forms.Orientation.Vertical;
        self.trackBar2.Size := new System.Drawing.Size(45, 450);
        self.trackBar2.TabIndex := 5;
        self.trackBar2.Scroll += trackBar2_Scroll;
        // 
        // trackBar3
        // 
        self.trackBar3.Location := new System.Drawing.Point(270, 35);
        self.trackBar3.Maximum := 100;
        self.trackBar3.Minimum := -100;
        self.trackBar3.Name := 'trackBar3';
        self.trackBar3.Orientation := System.Windows.Forms.Orientation.Vertical;
        self.trackBar3.Size := new System.Drawing.Size(45, 450);
        self.trackBar3.TabIndex := 6;
        self.trackBar3.Scroll += trackBar3_Scroll;
        // 
        // trackBar4
        // 
        self.trackBar4.Location := new System.Drawing.Point(378, 35);
        self.trackBar4.Maximum := 100;
        self.trackBar4.Minimum := -100;
        self.trackBar4.Name := 'trackBar4';
        self.trackBar4.Orientation := System.Windows.Forms.Orientation.Vertical;
        self.trackBar4.Size := new System.Drawing.Size(45, 450);
        self.trackBar4.TabIndex := 7;
        self.trackBar4.Scroll += trackBar4_Scroll;
        // 
        // button1
        // 
        self.button1.Location := new System.Drawing.Point(501, 8);
        self.button1.Name := 'button1';
        self.button1.Size := new System.Drawing.Size(146, 96);
        self.button1.TabIndex := 8;
        self.button1.Text := 'Стоп';
        self.button1.UseVisualStyleBackColor := true;
        self.button1.Click += button1_Click;
        // 
        // timer1
        // 
        self.timer1.Enabled := true;
        self.timer1.Interval := 400;
        self.timer1.Tick += timer1_Tick;
        // 
        // button2
        // 
        self.button2.Location := new System.Drawing.Point(501, 124);
        self.button2.Name := 'button2';
        self.button2.Size := new System.Drawing.Size(146, 23);
        self.button2.TabIndex := 9;
        self.button2.Text := 'Обнулить';
        self.button2.UseVisualStyleBackColor := true;
        self.button2.Click += button2_Click;
        // 
        // Form1
        // 
        self.ClientSize := new System.Drawing.Size(695, 497);
        self.Controls.Add(self.button2);
        self.Controls.Add(self.button1);
        self.Controls.Add(self.trackBar4);
        self.Controls.Add(self.trackBar3);
        self.Controls.Add(self.trackBar2);
        self.Controls.Add(self.trackBar1);
        self.Controls.Add(self.label4);
        self.Controls.Add(self.label3);
        self.Controls.Add(self.label2);
        self.Controls.Add(self.label1);
        self.Name := 'Form1';
        self.Text := 'Form1';
        self.FormClosing += Form1_FormClosing;
        self.Load += Form1_Load;
        (System.ComponentModel.ISupportInitialize(self.trackBar1)).EndInit();
        (System.ComponentModel.ISupportInitialize(self.trackBar2)).EndInit();
        (System.ComponentModel.ISupportInitialize(self.trackBar3)).EndInit();
        (System.ComponentModel.ISupportInitialize(self.trackBar4)).EndInit();
        self.ResumeLayout(false);
        self.PerformLayout();
    end;
