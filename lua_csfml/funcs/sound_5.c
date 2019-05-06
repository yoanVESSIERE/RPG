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

int sound_set_playing_offset(lua_State *L)
{
    sfSound *sound = 0;
    sfTime time = {0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Time)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        time.microseconds = lua_tointeger(L, 2);
        sfSound_setPlayingOffset(sound, time);
    } else {
        luaL_error(L, "Expected (Sound, Number)");
        return (0);
    }
    return (0);
}

int sound_set_position(lua_State *L)
{
    sfSound *sound = 0;
    sfVector3f pos = {0, 0, 0};

    if (lua_gettop(L) < 4) {
        luaL_error(L, "Expected (Sound, X, Y, Z)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2) &&
        lua_isnumber(L, 3) && lua_isnumber(L, 4)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        pos.x = lua_tonumber(L, 2);
        pos.y = lua_tonumber(L, 3);
        pos.z = lua_tonumber(L, 4);
        sfSound_setPosition(sound, pos);
    } else {
        luaL_error(L, "Expected (Sound, Number, Number, Number)");
        return (0);
    }
    return (0);
}

int sound_set_relative_to_lister(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Boolean)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_setRelativeToListener(sound, lua_toboolean(L, 2));
    } else {
        luaL_error(L, "Expected (Sound, Boolean)");
        return (0);
    }
    return (0);
}

int sound_set_volume(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Volume)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_setVolume(sound, lua_tonumber(L, 2));
    } else {
        luaL_error(L, "Expected (Sound, Number)");
        return (0);
    }
    return (0);
}

int sound_stop(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_stop(sound);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (0);
}