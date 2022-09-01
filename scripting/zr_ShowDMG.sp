#include <sourcemod>
#include <zepremium>
#include <colorvariables>

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
	
	int restante = GetClientHealth(client);
	char input[512];
	
	if(restante > 0)
	{
		int damage = GetEventInt(event, "dmg_health");
		Format(input, 512, "\n<font class='fontSize-l'>Health Remaining: <font color='#FF0000'>%i</font> (-%i)", restante, damage);
	}
	PrintHintText(attacker, input);
}