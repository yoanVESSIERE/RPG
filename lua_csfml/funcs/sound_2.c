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

int sound_get_loop(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushboolean(L, sfSound_getLoop(sound));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_min_distance(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushnumber(L, sfSound_getMinDistance(sound));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_pitch(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushnumber(L, sfSound_getPitch(sound));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_playing_offset(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushinteger(L, sfSound_getPlayingOffset(sound).microseconds);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_position(lua_State *L)
{
    sfSound *sound = 0;
    sfVector3f vec = {0, 0, 0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        vec = sfSound_getPosition(sound);
        lua_pushnumber(L, vec.x);
        lua_pushnumber(L, vec.y);
        lua_pushnumber(L, vec.z);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (3);
}