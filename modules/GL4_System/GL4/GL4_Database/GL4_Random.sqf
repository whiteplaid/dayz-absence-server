// ////////////////////////////////////////////////////////////////////////////
// GL4 v.1.0
// ////////////////////////////////////////////////////////////////////////////
// Random Database
// Based on Operation Flashpoint Mod E.C.P. ( Enhanced Configuration Project )
// By =\SNKMAN/=
// ////////////////////////////////////////////////////////////////////////////

GL4_Random = [

	10,
	14,

	[900, 1200],
	[300, 600],
	[0, 1],
	[0, 1],
	[0, 1],

	0.3,
	30
];

if (GL4_Path == "\GL4_System\") then
{
	call compile preprocessFile "\UserConfig\GL4\GL4_Random.sqf";
};