/*
** EPITECH PROJECT, 2019
** sound
** File description:
** sound
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include <SFML/Audio.h>

int sound_get_status(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSoundStatus status = sfSound_getStatus(sound);
        lua_pushstring(L, status == 0 ? "stopped" :
        (status == 1 ? "paused" : "playing"));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_volume(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushnumber(L, sfSound_getVolume(sound));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_is_relative_to_lister(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushboolean(L, sfSound_isRelativeToListener(sound));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_pause(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_pause(sound);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (0);
}

int sound_play(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_play(sound);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (0);
}