% Clear the Command Window
clc

% Get Input Values From Spreadsheet
InputSpreadsheet = ('FISTestData.xlsx');
TestInputs = xlsread(InputSpreadsheet);

% Define a Fuzzy Inference System, Called 'Jog Rater'
JogRaterFIS = newfis('Jog Rater');

% Define the inputs for the Jog Rater FIS: 'Pace (Min per KM)', 'Distance (KM)', 'Cumulative Elevation Gain Per KM (KM)' and 'Mean Heart Rate (BPM) % of Average Maximum Heart Rate'
JogRaterFIS = addvar(JogRaterFIS, 'input', 'Pace (Min per KM)', [0 18]);
JogRaterFIS = addvar(JogRaterFIS, 'input', 'Distance (KM)', [0 42.5]);
JogRaterFIS = addvar(JogRaterFIS, 'input', 'Cumulative Elevation Gain Per KM (KM)', [0 1]);
JogRaterFIS = addvar(JogRaterFIS, 'input', 'Mean Heart Rate (BPM) % of Average Maximum Heart Rate', [0 100]);
 
% Define the Output (Athleticism)
JogRaterFIS = addvar(JogRaterFIS, 'output', 'Minimum Athleticism', [0 100]);

% Define Membership Functions for the 'Pace (Min per KM)' Input
JogRaterFIS = addmf(JogRaterFIS, 'input', 1, 'Crawling', 'trapmf', [14.6 15.6 17.6 18.6]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 1, 'Slow Walking', 'trapmf', [9 10 12 13]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 1, 'Walking', 'trapmf', [8 10 14 16]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 1, 'Fast Walking', 'trimf', [6.5 7.5 8.5]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 1, 'Jogging', 'trimf', [4 6 8]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 1, 'Sprinting', 'trapmf', [0 0 3 4]);

% Define Membership Functions for the 'Distance (KM)' Input
JogRaterFIS = addmf(JogRaterFIS, 'input', 2, 'Marathon', 'trapmf', [42 42.195 42.5 42.5]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 2, 'Very Long', 'trapmf', [16.047 18.047 41.5 42.5]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 2, 'Long', 'trapmf', [10 15.094 17.094 18.094]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 2, 'Medium', 'trapmf', [5.547 6.547 9.547 15]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 2, 'Short', 'trapmf', [2 4 6 8]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 2, 'Very Short', 'trapmf', [0 0 2 4]);

% Define Membership Functions for the 'Average Cumulative Elevation Gain Per KM (KM)' Input
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Level (0 to .3 Degree Slope)', 'trapmf', [0 0 0.00523596383141958 0.00523596383141958]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Nearly Level (.3 to 1.1 Degree Slope)', 'trapmf', [0.00523596383141958 0.00523596383141958 0.01919744239968967 0.01919744239968967]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Very Gentle (1.1 to 3 Degree Slope)', 'trapmf', [0.01919744239968967 0.01919744239968967 0.052335956242943835 0.052335956242943835]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Gentle (3 to 5 Degree Slope)', 'trapmf', [0.052335956242943835 0.052335956242943835 0.08715574274765817 0.08715574274765817]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Moderate (5 to 8.5 Degree Slope)', 'trapmf', [0.08715574274765817 0.08715574274765817 0.14780941112961063 0.14780941112961063]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Strong (8.5 to 16.5 Degree Slope)', 'trapmf', [0.14780941112961063 0.14780941112961063 0.28401534470392265 0.28401534470392265]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Very Strong (16.5 to 24 Degree Slope)', 'trapmf', [0.28401534470392265 0.28401534470392265 0.4067366430758002 0.4067366430758002]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Extreme (24 to 35 Degree Slope)', 'trapmf', [0.4067366430758002 0.4067366430758002 0.573576436351046 0.573576436351046]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Steep (35 to 45 Degree Slope)', 'trapmf', [0.573576436351046 0.573576436351046 0.7071067811865475 0.7071067811865475]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 3, 'Very Steep (>45 Degree Slope)', 'trapmf', [0.7071067811865475 0.7071067811865475 1 1]);

% Define Membership Functions for the 'Mean Heart Rate (BPM) % of Average Maximum Heart Rate' Input
JogRaterFIS = addmf(JogRaterFIS, 'input', 4, 'Low', 'trapmf', [0 0 50 50]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 4, 'Target', 'trapmf', [50 50 85 85]);
JogRaterFIS = addmf(JogRaterFIS, 'input', 4, 'High', 'trapmf', [85 85 100 100]);

% Define Membership Functions for the 'Observed Athleticism' Output
JogRaterFIS = addmf(JogRaterFIS, 'output', 1, 'Very Low', 'trimf', [0 0 20]);
JogRaterFIS = addmf(JogRaterFIS, 'output', 1, 'Low', 'trapmf', [10 20 40 50]);
JogRaterFIS = addmf(JogRaterFIS, 'output', 1, 'Moderate', 'gaussmf', [3 50]);
JogRaterFIS = addmf(JogRaterFIS, 'output', 1, 'High', 'trapmf', [50 60 80 90]);
JogRaterFIS = addmf(JogRaterFIS, 'output', 1, 'Very High', 'trimf', [80 100 100]);
 
% Plot the Membership Functions of the Inputs to the TipFIS on a Graph
figure('Name','Tip % Fuzzy Inference System','NumberTitle','off');

% Define System Rule Base
% Abstract Rules
rule1 = [0 0  0 1 2  1   1]; % If Heart Rate is Low then Athleticism is Low
rule2 = [0 0  0 3 2  1   1]; % If Heart Rate is High then Athleticism is Low
rule5 = [0 1  0 0 5 0.8  1]; % If Distance is Marathon then Athleticism is Very High
rule6 = [0 2  0 0 4 0.8  1]; % If Distance is Very Long then Athleticism is High
% Specific Rules (All use Heart Rate of Target))
% If (Pace = Crawling) and (Distance = Long)
rule7 =  [1 3 1  2 3 0.6 1]; % Elevation = Level
rule8 =  [1 3 2  2 3 0.6 1]; % Elevation = Nearly Level
rule9 =  [1 3 3  2 3 0.6 1]; % Elevation = Very Gentle
rule10 = [1 3 4  2 3 0.6 1]; % Elevation = Gentle
rule11 = [1 3 5  2 4 0.6 1]; % Elevation = Moderate
rule12 = [1 3 6  2 4 0.6 1]; % Elevation = Strong
rule13 = [1 3 7  2 4 0.6 1]; % Elevation = Very Strong
rule14 = [1 3 8  2 4 0.6 1]; % Elevation = Extreme
rule15 = [1 3 9  2 5 0.6 1]; % Elevation = Steep
rule16 = [1 3 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Slow Walking) and (Distance = Long)
rule17 = [2 3 1  2 3 0.6 1]; % Elevation = Level
rule18 = [2 3 2  2 3 0.6 1]; % Elevation = Nearly Level
rule19 = [2 3 3  2 3 0.6 1]; % Elevation = Very Gentle
rule20 = [2 3 4  2 3 0.6 1]; % Elevation = Gentle
rule21 = [2 3 5  2 4 0.6 1]; % Elevation = Moderate
rule22 = [2 3 6  2 4 0.6 1]; % Elevation = Strong
rule23 = [2 3 7  2 4 0.6 1]; % Elevation = Very Strong
rule24 = [2 3 8  2 4 0.6 1]; % Elevation = Extreme
rule25 = [2 3 9  2 5 0.6 1]; % Elevation = Steep
rule26 = [2 3 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Walking) and (Distance = Long)
rule27 = [3 3 1  2 3 0.6 1]; % Elevation = Level
rule28 = [3 3 2  2 3 0.6 1]; % Elevation = Nearly Level
rule29 = [3 3 3  2 3 0.6 1]; % Elevation = Very Gentle
rule30 = [3 3 4  2 4 0.6 1]; % Elevation = Gentle
rule31 = [3 3 5  2 4 0.6 1]; % Elevation = Moderate
rule32 = [3 3 6  2 4 0.6 1]; % Elevation = Strong
rule33 = [3 3 7  2 4 0.6 1]; % Elevation = Very Strong
rule34 = [3 3 8  2 4 0.6 1]; % Elevation = Extreme
rule35 = [3 3 9  2 5 0.6 1]; % Elevation = Steep
rule36 = [3 3 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Fast Walking) and (Distance = Long)
rule37 = [4 3 1  2 3 0.6 1]; % Elevation = Level
rule38 = [4 3 2  2 3 0.6 1]; % Elevation = Nearly Level
rule39 = [4 3 3  2 3 0.6 1]; % Elevation = Very Gentle
rule40 = [4 3 4  2 4 0.6 1]; % Elevation = Gentle
rule41 = [4 3 5  2 4 0.6 1]; % Elevation = Moderate
rule42 = [4 3 6  2 5 0.6 1]; % Elevation = Strong
rule43 = [4 3 7  2 5 0.6 1]; % Elevation = Very Strong
rule44 = [4 3 8  2 5 0.6 1]; % Elevation = Extreme
rule45 = [4 3 9  2 5 0.6 1]; % Elevation = Steep
rule46 = [4 3 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Jogging) and (Distance = Long)
rule47 = [5 3 1  2 4 0.6 1]; % Elevation = Level
rule48 = [5 3 2  2 4 0.6 1]; % Elevation = Nearly Level
rule49 = [5 3 3  2 4 0.6 1]; % Elevation = Very Gentle
rule50 = [5 3 4  2 4 0.6 1]; % Elevation = Gentle
rule51 = [5 3 5  2 5 0.6 1]; % Elevation = Moderate
rule52 = [5 3 6  2 5 0.6 1]; % Elevation = Strong
rule53 = [5 3 7  2 5 0.6 1]; % Elevation = Very Strong
rule54 = [5 3 8  2 5 0.6 1]; % Elevation = Extreme
rule55 = [5 3 9  2 5 0.6 1]; % Elevation = Steep
rule56 = [5 3 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Sprinting) and (Distance = Long)
rule57 = [6 3 1  2 5 0.6 1]; % Elevation = Level
rule58 = [6 3 2  2 5 0.6 1]; % Elevation = Nearly Level
rule59 = [6 3 3  2 5 0.6 1]; % Elevation = Very Gentle
rule60 = [6 3 4  2 5 0.6 1]; % Elevation = Gentle
rule61 = [6 3 5  2 5 0.6 1]; % Elevation = Moderate
rule62 = [6 3 6  2 5 0.6 1]; % Elevation = Strong
rule63 = [6 3 7  2 5 0.6 1]; % Elevation = Very Strong
rule64 = [6 3 8  2 5 0.6 1]; % Elevation = Extreme
rule65 = [6 3 9  2 5 0.6 1]; % Elevation = Steep
rule66 = [6 3 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Crawling) and (Distance = Medium)
rule67 = [1 4 1  2 3 0.6 1]; % Elevation = Level
rule68 = [1 4 2  2 3 0.6 1]; % Elevation = Nearly Level
rule69 = [1 4 3  2 3 0.6 1]; % Elevation = Very Gentle
rule70 = [1 4 4  2 3 0.6 1]; % Elevation = Gentle
rule71 = [1 4 5  2 4 0.6 1]; % Elevation = Moderate
rule72 = [1 4 6  2 4 0.6 1]; % Elevation = Strong
rule73 = [1 4 7  2 4 0.6 1]; % Elevation = Very Strong
rule74 = [1 4 8  2 4 0.6 1]; % Elevation = Extreme
rule75 = [1 4 9  2 5 0.6 1]; % Elevation = Steep
rule76 = [1 4 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Slow Walking) and (Distance = Medium)
rule77 = [2 4 1  2 3 0.6 1]; % Elevation = Level
rule78 = [2 4 2  2 3 0.6 1]; % Elevation = Nearly Level
rule79 = [2 4 3  2 3 0.6 1]; % Elevation = Very Gentle
rule80 = [2 4 4  2 3 0.6 1]; % Elevation = Gentle
rule81 = [2 4 5  2 4 0.6 1]; % Elevation = Moderate
rule82 = [2 4 6  2 4 0.6 1]; % Elevation = Strong
rule83 = [2 4 7  2 4 0.6 1]; % Elevation = Very Strong
rule84 = [2 4 8  2 4 0.6 1]; % Elevation = Extreme
rule85 = [2 4 9  2 5 0.6 1]; % Elevation = Steep
rule86 = [2 4 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Walking) and (Distance = Medium)
rule87 = [3 4 1  2 3 0.6 1]; % Elevation = Level
rule88 = [3 4 2  2 3 0.6 1]; % Elevation = Nearly Level
rule89 = [3 4 3  2 3 0.6 1]; % Elevation = Very Gentle
rule90 = [3 4 4  2 4 0.6 1]; % Elevation = Gentle
rule91 = [3 4 5  2 4 0.6 1]; % Elevation = Moderate
rule92 = [3 4 6  2 4 0.6 1]; % Elevation = Strong
rule93 = [3 4 7  2 4 0.6 1]; % Elevation = Very Strong
rule94 = [3 4 8  2 4 0.6 1]; % Elevation = Extreme
rule95 = [3 4 9  2 5 0.6 1]; % Elevation = Steep
rule96 = [3 4 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Fast Walking) and (Distance = Medium)
rule97  = [4 4 1  2 3 0.6 1]; % Elevation = Level
rule98  = [4 4 2  2 3 0.6 1]; % Elevation = Nearly Level
rule99  = [4 4 3  2 3 0.6 1]; % Elevation = Very Gentle
rule100 = [4 4 4  2 4 0.6 1]; % Elevation = Gentle
rule101 = [4 4 5  2 4 0.6 1]; % Elevation = Moderate
rule102 = [4 4 6  2 5 0.6 1]; % Elevation = Strong
rule103 = [4 4 7  2 5 0.6 1]; % Elevation = Very Strong
rule104 = [4 4 8  2 5 0.6 1]; % Elevation = Extreme
rule105 = [4 4 9  2 5 0.6 1]; % Elevation = Steep
rule106 = [4 4 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Jogging) and (Distance = Medium)
rule107 = [5 4 1  2 4 0.6 1]; % Elevation = Level
rule108 = [5 4 2  2 4 0.6 1]; % Elevation = Nearly Level
rule109 = [5 4 3  2 4 0.6 1]; % Elevation = Very Gentle
rule110 = [5 4 4  2 4 0.6 1]; % Elevation = Gentle
rule111 = [5 4 5  2 5 0.6 1]; % Elevation = Moderate
rule112 = [5 4 6  2 5 0.6 1]; % Elevation = Strong
rule113 = [5 4 7  2 5 0.6 1]; % Elevation = Very Strong
rule114 = [5 4 8  2 5 0.6 1]; % Elevation = Extreme
rule115 = [5 4 9  2 5 0.6 1]; % Elevation = Steep
rule116 = [5 4 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Sprinting) and (Distance = Medium)
rule117 = [6 4 1  2 4 0.6 1]; % Elevation = Level
rule118 = [6 4 2  2 4 0.6 1]; % Elevation = Nearly Level
rule119 = [6 4 3  2 4 0.6 1]; % Elevation = Very Gentle
rule120 = [6 4 4  2 5 0.6 1]; % Elevation = Gentle
rule121 = [6 4 5  2 5 0.6 1]; % Elevation = Moderate
rule122 = [6 4 6  2 5 0.6 1]; % Elevation = Strong
rule123 = [6 4 7  2 5 0.6 1]; % Elevation = Very Strong
rule124 = [6 4 8  2 5 0.6 1]; % Elevation = Extreme
rule125 = [6 4 9  2 5 0.6 1]; % Elevation = Steep
rule126 = [6 4 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Crawling) and (Distance = Short)
rule127 = [1 5 1  2 1 0.6 1]; % Elevation = Level
rule128 = [1 5 2  2 1 0.6 1]; % Elevation = Nearly Level
rule129 = [1 5 3  2 1 0.6 1]; % Elevation = Very Gentle
rule130 = [1 5 4  2 1 0.6 1]; % Elevation = Gentle
rule131 = [1 5 5  2 2 0.6 1]; % Elevation = Moderate
rule132 = [1 5 6  2 2 0.6 1]; % Elevation = Strong
rule133 = [1 5 7  2 3 0.6 1]; % Elevation = Very Strong
rule134 = [1 5 8  2 3 0.6 1]; % Elevation = Extreme
rule135 = [1 5 9  2 3 0.6 1]; % Elevation = Steep
rule136 = [1 5 10 2 4 0.6 1]; % Elevation = Very Steep
% If (Pace = Slow Walking) and (Distance = Short)
rule137 = [2 5 1  2 2 0.6 1]; % Elevation = Level
rule138 = [2 5 2  2 2 0.6 1]; % Elevation = Nearly Level
rule139 = [2 5 3  2 2 0.6 1]; % Elevation = Very Gentle
rule140 = [2 5 4  2 3 0.6 1]; % Elevation = Gentle
rule141 = [2 5 5  2 3 0.6 1]; % Elevation = Moderate
rule142 = [2 5 6  2 3 0.6 1]; % Elevation = Strong
rule143 = [2 5 7  2 3 0.6 1]; % Elevation = Very Strong
rule144 = [2 5 8  2 3 0.6 1]; % Elevation = Extreme
rule145 = [2 5 9  2 4 0.6 1]; % Elevation = Steep
rule146 = [2 5 10 2 4 0.6 1]; % Elevation = Very Steep
% If (Pace = Walking) and (Distance = Short)
rule147 = [3 5 1  2 3 0.6 1]; % Elevation = Level
rule148 = [3 5 2  2 3 0.6 1]; % Elevation = Nearly Level
rule149 = [3 5 3  2 3 0.6 1]; % Elevation = Very Gentle
rule150 = [3 5 4  2 3 0.6 1]; % Elevation = Gentle
rule151 = [3 5 5  2 3 0.6 1]; % Elevation = Moderate
rule152 = [3 5 6  2 3 0.6 1]; % Elevation = Strong
rule153 = [3 5 7  2 4 0.6 1]; % Elevation = Very Strong
rule154 = [3 5 8  2 4 0.6 1]; % Elevation = Extreme
rule155 = [3 5 9  2 4 0.6 1]; % Elevation = Steep
rule156 = [3 5 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Fast Walking) and (Distance = Short)
rule157 = [4 5 1  2 3 0.6 1]; % Elevation = Level
rule158 = [4 5 2  2 3 0.6 1]; % Elevation = Nearly Level
rule159 = [4 5 3  2 3 0.6 1]; % Elevation = Very Gentle
rule160 = [4 5 4  2 3 0.6 1]; % Elevation = Gentle
rule161 = [4 5 5  2 4 0.6 1]; % Elevation = Moderate
rule162 = [4 5 6  2 4 0.6 1]; % Elevation = Strong
rule163 = [4 5 7  2 4 0.6 1]; % Elevation = Very Strong
rule164 = [4 5 8  2 5 0.6 1]; % Elevation = Extreme
rule165 = [4 5 9  2 5 0.6 1]; % Elevation = Steep
rule166 = [4 5 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Jogging) and (Distance = Short)
rule167 = [5 5 1  2 3 0.6 1]; % Elevation = Level
rule168 = [5 5 2  2 3 0.6 1]; % Elevation = Nearly Level
rule169 = [5 5 3  2 3 0.6 1]; % Elevation = Very Gentle
rule170 = [5 5 4  2 3 0.6 1]; % Elevation = Gentle
rule171 = [5 5 5  2 4 0.6 1]; % Elevation = Moderate
rule172 = [5 5 6  2 4 0.6 1]; % Elevation = Strong
rule173 = [5 5 7  2 5 0.6 1]; % Elevation = Very Strong
rule174 = [5 5 8  2 5 0.6 1]; % Elevation = Extreme
rule175 = [5 5 9  2 5 0.6 1]; % Elevation = Steep
rule176 = [5 5 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Sprinting) and (Distance = Short)
rule177 = [6 5 1  2 3 0.6 1]; % Elevation = Level
rule178 = [6 5 2  2 3 0.6 1]; % Elevation = Nearly Level
rule179 = [6 5 3  2 3 0.6 1]; % Elevation = Very Gentle
rule180 = [6 5 4  2 4 0.6 1]; % Elevation = Gentle
rule181 = [6 5 5  2 4 0.6 1]; % Elevation = Moderate
rule182 = [6 5 6  2 5 0.6 1]; % Elevation = Strong
rule183 = [6 5 7  2 5 0.6 1]; % Elevation = Very Strong
rule184 = [6 5 8  2 5 0.6 1]; % Elevation = Extreme
rule185 = [6 5 9  2 5 0.6 1]; % Elevation = Steep
rule186 = [6 5 10 2 5 0.6 1]; % Elevation = Very Steep
% If (Pace = Crawling) and (Distance = Very Short)
rule187 = [1 6 1  2 1 0.6 1]; % Elevation = Level
rule188 = [1 6 2  2 1 0.6 1]; % Elevation = Nearly Level
rule189 = [1 6 3  2 1 0.6 1]; % Elevation = Very Gentle
rule190 = [1 6 4  2 1 0.6 1]; % Elevation = Gentle
rule191 = [1 6 5  2 2 0.6 1]; % Elevation = Moderate
rule192 = [1 6 6  2 2 0.6 1]; % Elevation = Strong
rule193 = [1 6 7  2 3 0.6 1]; % Elevation = Very Strong
rule194 = [1 6 8  2 3 0.6 1]; % Elevation = Extreme
rule195 = [1 6 9  2 3 0.6 1]; % Elevation = Steep
rule196 = [1 6 10 2 3 0.6 1]; % Elevation = Very Steep
% If (Pace = Slow Walking) and (Distance = Very Short)
rule197 = [2 6 1  2 1 0.6 1]; % Elevation = Level
rule198 = [2 6 2  2 1 0.6 1]; % Elevation = Nearly Level
rule199 = [2 6 3  2 2 0.6 1]; % Elevation = Very Gentle
rule200 = [2 6 4  2 2 0.6 1]; % Elevation = Gentle
rule201 = [2 6 5  2 3 0.6 1]; % Elevation = Moderate
rule202 = [2 6 6  2 3 0.6 1]; % Elevation = Strong
rule203 = [2 6 7  2 3 0.6 1]; % Elevation = Very Strong
rule204 = [2 6 8  2 3 0.6 1]; % Elevation = Extreme
rule205 = [2 6 9  2 3 0.6 1]; % Elevation = Steep
rule206 = [2 6 10 2 3 0.6 1]; % Elevation = Very Steep
% If (Pace = Walking) and (Distance = Very Short)
rule207 = [3 6 1  2 2 0.6 1]; % Elevation = Level
rule208 = [3 6 2  2 2 0.6 1]; % Elevation = Nearly Level
rule209 = [3 6 3  2 3 0.6 1]; % Elevation = Very Gentle
rule210 = [3 6 4  2 3 0.6 1]; % Elevation = Gentle
rule211 = [3 6 5  2 3 0.6 1]; % Elevation = Moderate
rule212 = [3 6 6  2 3 0.6 1]; % Elevation = Strong
rule213 = [3 6 7  2 3 0.6 1]; % Elevation = Very Strong
rule214 = [3 6 8  2 3 0.6 1]; % Elevation = Extreme
rule215 = [3 6 9  2 4 0.6 1]; % Elevation = Steep
rule216 = [3 6 10 2 4 0.6 1]; % Elevation = Very Steep
% If (Pace = Fast Walking) and (Distance = Very Short)
rule217 = [4 6 1  2 3 0.6 1]; % Elevation = Level
rule218 = [4 6 2  2 3 0.6 1]; % Elevation = Nearly Level
rule219 = [4 6 3  2 3 0.6 1]; % Elevation = Very Gentle
rule220 = [4 6 4  2 3 0.6 1]; % Elevation = Gentle
rule221 = [4 6 5  2 3 0.6 1]; % Elevation = Moderate
rule222 = [4 6 6  2 3 0.6 1]; % Elevation = Strong
rule223 = [4 6 7  2 4 0.6 1]; % Elevation = Very Strong
rule224 = [4 6 8  2 4 0.6 1]; % Elevation = Extreme
rule225 = [4 6 9  2 4 0.6 1]; % Elevation = Steep
rule226 = [4 6 10 2 4 0.6 1]; % Elevation = Very Steep
% If (Pace = Jogging) and (Distance = Very Short)
rule227 = [5 6 1  2 3 0.6 1]; % Elevation = Level
rule228 = [5 6 2  2 3 0.6 1]; % Elevation = Nearly Level
rule229 = [5 6 3  2 3 0.6 1]; % Elevation = Very Gentle
rule230 = [5 6 4  2 3 0.6 1]; % Elevation = Gentle
rule231 = [5 6 5  2 3 0.6 1]; % Elevation = Moderate
rule232 = [5 6 6  2 4 0.6 1]; % Elevation = Strong
rule233 = [5 6 7  2 4 0.6 1]; % Elevation = Very Strong
rule234 = [5 6 8  2 4 0.6 1]; % Elevation = Extreme
rule235 = [5 6 9  2 4 0.6 1]; % Elevation = Steep
rule236 = [5 6 10 2 4 0.6 1]; % Elevation = Very Steep
% If (Pace = Sprinting) and (Distance = Very Short)
rule237 = [6 6 1  2 3 0.6 1]; % Elevation = Level
rule238 = [6 6 2  2 3 0.6 1]; % Elevation = Nearly Level
rule239 = [6 6 3  2 3 0.6 1]; % Elevation = Very Gentle
rule240 = [6 6 4  2 3 0.6 1]; % Elevation = Gentle
rule241 = [6 6 5  2 4 0.6 1]; % Elevation = Moderate
rule242 = [6 6 6  2 4 0.6 1]; % Elevation = Strong
rule243 = [6 6 7  2 4 0.6 1]; % Elevation = Very Strong
rule244 = [6 6 8  2 4 0.6 1]; % Elevation = Extreme
rule245 = [6 6 9  2 4 0.6 1]; % Elevation = Steep
rule246 = [6 6 10 2 4 0.6 1]; % Elevation = Very Steep

% Make Rule List
rulelist = [rule1; rule2; rule5; rule6; rule7; rule8;...
    rule9; rule10; rule11; rule12; rule13; rule14; rule15; rule16;...
    rule17; rule18; rule19; rule20; rule21; rule22; rule23; rule24;...
    rule25; rule26; rule27; rule28; rule29; rule30; rule31; rule32;...
    rule33; rule34; rule35; rule36; rule37; rule38; rule39; rule40;...
    rule41; rule42; rule43; rule44; rule45; rule46; rule47; rule48;...
    rule49; rule50; rule51; rule52; rule53; rule54; rule55; rule56;...
    rule57; rule58; rule59; rule60; rule61; rule62; rule63; rule64;...
    rule65; rule66; rule67; rule68; rule69; rule70; rule71; rule72;...
    rule73; rule74; rule75; rule76; rule77; rule78; rule79; rule80; rule81;...
    rule82; rule83; rule84; rule85; rule86; rule87; rule88; rule89;...
    rule90; rule91; rule92; rule93; rule94; rule95; rule96; rule97;...
    rule98; rule99; rule100; rule101; rule102; rule103; rule104;...
    rule105; rule106; rule107; rule108; rule109; rule110; rule111;...
    rule112; rule113; rule114; rule115; rule116; rule117; rule118;...
    rule119; rule120; rule121; rule122; rule123; rule124; rule125;...
    rule126; rule127; rule128; rule129; rule130; rule131; rule132;...
    rule133; rule134; rule135; rule136; rule137; rule138; rule139;...
    rule140; rule141; rule142; rule143; rule144; rule145; rule146;...
    rule147; rule148; rule149; rule150; rule151; rule152; rule153;...
    rule154; rule155; rule156; rule157; rule158; rule159; rule160;...
    rule161; rule162; rule163; rule164; rule165; rule166; rule167;...
    rule168; rule169; rule170; rule171; rule172; rule173; rule174;...
    rule175; rule176; rule177; rule178; rule179; rule180; rule181;...
    rule182; rule183; rule184; rule185; rule186; rule187; rule188;...
    rule189; rule190; rule191; rule192; rule193; rule194; rule195;...
    rule196; rule197; rule198; rule199; rule200; rule201; rule202;...
    rule203; rule204; rule205; rule206; rule207; rule208; rule209;...
    rule210; rule211; rule212; rule213; rule214; rule215; rule216;...
    rule217; rule218; rule219; rule220; rule221; rule222; rule223;...
    rule224; rule225; rule226; rule227; rule228; rule229; rule230;...
    rule231; rule232; rule233; rule234; rule235; rule236; rule237;...
    rule238; rule239; rule240; rule241; rule242; rule243; rule244;...
    rule245; rule246;];
    
% Add Rules to System
JogRaterFIS = addrule(JogRaterFIS, rulelist);
 
% Output Rules
rules = showrule(JogRaterFIS)
 
% Set Defuzzification Method
JogRaterFIS.defuzzMethod = 'mom';

% Declare Output Array
outputarray = zeros(size(TestInputs,1),1);
 
% Run Tests
for i=1:size(TestInputs,1) % Loop Through Output Array
        % Get Result
        Result = evalfis([TestInputs(i, 2), TestInputs(i, 3), TestInputs(i, 4), TestInputs(i, 5)], JogRaterFIS);
        
        % Output
        %fprintf('Pace = %.4f Distance = %.4f Elevation = %.4f BPM = %.4f Result = %.4f', TestInputs(i, 2), TestInputs(i, 3), TestInputs(i, 4), TestInputs(i, 5), Result)
        
        % Save Result in Output Array
        outputarray(i, 1) = Result; % Assign Result Values to Array
end
  
% Output Rules
ruleview(JogRaterFIS)

%Output
xlswrite(InputSpreadsheet,outputarray,1,'G2');

% Output Diagrams
subplot(5,1,1), plotmf(JogRaterFIS,'input',1);
subplot(5,1,2), plotmf(JogRaterFIS,'input',2);
subplot(5,1,3), plotmf(JogRaterFIS,'input',3);
subplot(5,1,4), plotmf(JogRaterFIS,'input',4);
subplot(5,1,5), plotmf(JogRaterFIS,'output',1);