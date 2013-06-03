// =========================================================================================================
//  SAR_AI - DayZ AI library
//  Version: 1.5.0 
//  Author: Sarge (sarge@krumeich.ch) 
//
//		Wiki: to come
//		Forum: http://opendayz.net/#sarge-ai.131
//		
// ---------------------------------------------------------------------------------------------------------
//  Required:
//  UPSMon  (special SARGE version)
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   SAR_group_monitor.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------


private ["_allgroups","_running","_sleeptime","_count_friendly_groups","_count_unfriendly_groups","_debugstring"];

if (!isServer) exitWith {}; // only run this on the server

_running = true;
_sleeptime = 5;


while {_running} do {

    _allgroups = allgroups;

    _count_friendly_groups = {side _x == SAR_AI_friendly_side} count _allgroups;
    _count_unfriendly_groups = {side _x == SAR_AI_unfriendly_side} count _allgroups;

    if(_count_friendly_groups > 120) then {

        diag_log format["SARGE AI: WARNING - more than 120 friendly AI groups active. Consider decreasing your configured AI survivor and soldier groups. Number of active groups: %1.",_count_friendly_groups];
        SAR_MAX_GRP_WEST_SPAWN = true;
    } else {
        SAR_MAX_GRP_WEST_SPAWN = false;
    };

    if(_count_unfriendly_groups > 120) then {
    
        diag_log format["SARGE AI: WARNING - more than 120 unfriendly AI groups active. Consider decreasing your configured AI bandit groups. Number of active groups: %1.",_count_unfriendly_groups];
        SAR_MAX_GRP_EAST_SPAWN = true;
        
    } else {
        SAR_MAX_GRP_EAST_SPAWN = false;    
    };

    
    // SAR AI debug monitor
    
    if (SAR_DEBUGMONITOR) then {

        //[KRON_AllRes] call SAR_debug_array;
        //[KRON_AllEast] call SAR_debug_array;
        //[KRON_targetsPos] call SAR_debug_array;
    
        
        _debugstring = parseText format ["
        <t size='0.85' font='Bitstream' align='left' color='#0000FF'>  *******  SARGE AI Monitor *******</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># of AI units (alive/ever): </t><t size='0.85' font='Bitstream' align='right'>%6(%1)</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># of AI groups active: </t><t size='0.85' font='Bitstream' align='right'>%2</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#0000FF'>---- Friendly ----</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># of alive AI units: </t><t size='0.85' font='Bitstream' align='right'>%4</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># in combat: </t><t size='0.85' font='Bitstream' align='right'>%7</t><br/>        
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># leaders in fight/walkmode: </t><t size='0.85' font='Bitstream' align='right'>%8/%9</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># of %13/%12 AI units: </t><t size='0.85' font='Bitstream' align='right'>%11/%10</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#0000FF'>---- Unfriendly ----</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># of alive AI units: </t><t size='0.85' font='Bitstream' align='right'>%5</t><br/>        
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># in combat: </t><t size='0.85' font='Bitstream' align='right'>%14</t><br/>        
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># leaders in fight/walkmode: </t><t size='0.85' font='Bitstream' align='right'>%15/%16</t><br/>
        <t size='0.85' font='Bitstream' align='left' color='#FFBF00'># of %13/%12 AI units: </t><t size='0.85' font='Bitstream' align='right'>%18/%17</t><br/>",
        KRON_UPS_Total,                                                                                                                                                         // 1
        KRON_UPS_Instances,                                                                                                                                                     // 2
        ((count KRON_NPCs)-1),                                                                                                                                                  // 3
        {alive _x} count KRON_AllRes,                                                                                                                                           // 4
        {alive _x} count KRON_AllEast,                                                                                                                                          // 5
        ({alive _x} count KRON_AllRes) + ({alive _x} count KRON_AllEast),                                                                                                       // 6
        {alive _x && (combatMode _x == "RED")} count KRON_AllRes,                                                                                                               // 7
        ({alive _x && (_x getVariable ["SAR_fightmode","not defined"] =="fight")} count KRON_AllRes),                                                                           // 8
        ({alive _x && (_x getVariable ["SAR_fightmode","not defined"] =="walk")} count KRON_AllRes),                                                                            // 9
        ({alive _x && (_x getVariable ["SAR_AI_experience",0] >= SAR_AI_XP_LVL_3)} count KRON_AllRes),                                                                          // 10
        ({alive _x && ((_x getVariable ["SAR_AI_experience",0] >= SAR_AI_XP_LVL_2) && (_x getVariable ["SAR_AI_experience",0] < SAR_AI_XP_LVL_3))} count KRON_AllRes),          // 11
        SAR_AI_XP_NAME_3,                                                                                                                                                       // 12
        SAR_AI_XP_NAME_2,                                                                                                                                                       // 13
        {alive _x && (combatMode _x == "RED")} count KRON_AllEast,                                                                                                              // 14
        ({alive _x && (_x getVariable ["SAR_fightmode","not defined"] =="fight")} count KRON_AllEast),                                                                          // 15
        ({alive _x && (_x getVariable ["SAR_fightmode","not defined"] =="walk")} count KRON_AllEast),                                                                           // 16
        ({alive _x && (_x getVariable ["SAR_AI_experience",0] >= SAR_AI_XP_LVL_3)} count KRON_AllEast),                                                                         // 17
        ({alive _x && ((_x getVariable ["SAR_AI_experience",0] >= SAR_AI_XP_LVL_2) && (_x getVariable ["SAR_AI_experience",0] < SAR_AI_XP_LVL_3))} count KRON_AllEast)          // 18

        ];
        
        [nil,nil,rHINT,_debugstring] call RE;
        
        
    };
    
    sleep _sleeptime;

};