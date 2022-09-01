#include <sourcemod>
#include <zepremium>
// #include <colorvariables>

public Plugin myinfo =
{
	name = "[ZR] Show Damage",
	author = "Franc1sco, Modified by. Someone, edited by Sniper007",
	description = "",
	version = "1.0",
	url = "http://steamcommunity.com/id/franug"
};

public OnPluginStart()
{
	HookEvent("player_hurt", Event_PlayerHurt);
}

public Action Event_PlayerHurt(Handle event, char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	
	if(!attacker)
		return;

	if(GetClientTeam(attacker) == 2 || ZR_IsClientZombie(attacker))
		return;
		
	if(attacker == client)
		return;
	
	// int restante = GetClientHealth(client);
	int damage = GetEventInt(event, "dmg_health");
/*
	char input[512];
	
	if(restante > 0)
	{
		
		Format(input, 512, "\n<font class='fontSize-l'>Health Remaining: <font color='#FF0000'>%i</font> (-%i)", restante, damage);
	}
	PrintHintText(attacker, input);
*/

	CSGO_AddMoney(attacker, damage);
}

/**
*	Retrieves the current amount of money a client has in CSGO.
*
*	client	Client index.
*
*	return	Amount of money the client currently has.
**/
stock int CSGO_GetMoney(int client)
{
	return GetEntProp(client, Prop_Send, "m_iAccount");
}

/**
*	A simple stock to set money on a client.
*
*	client	Client index.
*	amount	Amount of money to set.
*
*	return	void
**/
stock void CSGO_SetMoney(int client, int amount)
{
	if (amount < 0)
		amount = 0;
	
	int max = FindConVar("mp_maxmoney").IntValue;
	
	if (amount > max)
		amount = max;
	
	SetEntProp(client, Prop_Send, "m_iAccount", amount);
}

/**
*	A simple stock to add money to a client.
*
*	client	Client index.
*	amount	Amount of money to add.
*
*	return	void
**/
stock void CSGO_AddMoney(int client, int amount)
{
	SetEntProp(client, Prop_Send, "m_iAccount", (GetEntProp(client, Prop_Send, "m_iAccount") + amount));
}

/**
*	A simple stock to add money to a client.
*
*	client	Client index.
*	amount	Amount of money to add.
*
*	return	void
**/
stock bool CSGO_RemoveMoney(int client, int amount, bool force = true)
{
	int new_amount = GetEntProp(client, Prop_Send, "m_iAccount") - amount;
	
	if (force)
	{
		if (new_amount < 0)
			new_amount = 0;
		
		SetEntProp(client, Prop_Send, "m_iAccount", new_amount);
		return true;
	}
	else if (new_amount < 0)
		return false;
	
	return true;
}