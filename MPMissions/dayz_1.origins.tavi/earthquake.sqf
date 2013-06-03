earth = {
playsound "eq";
for "_i" from 0 to 140 do {
_vx = vectorup _this select 0;
_vy = vectorup _this select 1;
_vz = vectorup _this select 2;
_coef = 0.01 - (0.0001 * _i);
_this setvectorup [
_vx+(-_coef+random (2*_coef)),
_vy+(-_coef+random (2*_coef)),
_vz+(-_coef+random (2*_coef))
];
sleep (0.01 + random 0.01);
};

};

while {true} do {
player spawn earth;
sleep (180 + random 60);
};