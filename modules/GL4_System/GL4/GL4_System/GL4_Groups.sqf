// ////////////////////////////////////////////////////////////////////////////
// GL4 v.1.0
// ////////////////////////////////////////////////////////////////////////////
// Groups
// Script by =\SNKMAN/=
// ////////////////////////////////////////////////////////////////////////////
private ["_a"];

_a = (GL4_Global select 1);

switch (_a) do
{
	case 0 :
	{
		_a = 3 + (random 5);

		_a = round _a;
	};

	default
	{
		_a = _a + 1;

		_a = round _a;
	};
};

GL4_Global set [1, _a];

GL4_System set [12, _a];