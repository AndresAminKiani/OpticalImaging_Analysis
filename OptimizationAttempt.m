element = 3; k = 1; 
Img = imgDS_prob1_b4{ element };
time = 16; row = 50 : 250; col = 120 : 270;

trial = 1; 
Img_Fixed = Img(row, col, time, trial);
Img_Fixed(isnan(Img_Fixed)) = 0;
Img_Fixed = imgaussfilt(Img_Fixed, 4);


trial = 20; 
Img_Mov = Img(:, :, time, trial);
Img_Mov(isnan(Img_Mov)) = 0;
Img_Mov = imgaussfilt(Img_Mov, 4);

%%  
r_low = 1 - min(row); 
r_up = 316 - max(row);
c_low = 1 - min(col); 
c_up = 316 - max(col);
rot_low = -10;
rot_up = 10;
r = 1 - min(row) : 316 - max(row);
fmin_align(Img_Fixed, Img_Mov, [5, 5, 5])
func1 = @(x) fmin_align(Img_Fixed, Img_Mov, x);
func1([5, 5, 5])
fmincon(func1, [5, 5, 5], [], [], [], [], [r_low, c_low, rot_low], [r_up, c_up, rot_up])

%%
ga(func1, 3, [], [], [], [], [r_low, c_low, rot_low], [r_up, c_up, rot_up]);

%%aa
intcon = 1 : 3;
nonlcon = [];
val = ga(func1, 3, [], [], [], [], [r_low, c_low, rot_low], [r_up, c_up, rot_up], nonlcon, intcon);
