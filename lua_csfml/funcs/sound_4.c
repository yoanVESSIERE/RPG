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

int sound_set_attenuation(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Attenuation)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_setAttenuation(sound, lua_tonumber(L, 2));
    } else {
        luaL_error(L, "Expected (Sound, Number)");
        return (0);
    }
    return (0);
}

int sound_set_buffer(lua_State *L)
{
    sfSound *sound = 0;
    sfSoundBuffer *buf = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, SoundBuffer)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        buf = USERDATA_POINTER(L, 2, sfSoundBuffer);
        sfSound_setBuffer(sound, buf);
    } else {
        luaL_error(L, "Expected (Sound, SoundBuffer)");
        return (0);
    }
    return (0);
}

int sound_set_loop(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Loop)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_setLoop(sound, lua_toboolean(L, 2));
    } else {
        luaL_error(L, "Expected (Sound, Boolean)");
        return (0);
    }
    return (0);
}

int sound_set_min_distance(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Distance)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_setMinDistance(sound, lua_tonumber(L, 2));
    } else {
        luaL_error(L, "Expected (Sound, Number)");
        return (0);
    }
    return (0);
}

int sound_set_pitch(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sound, Pitch)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_setPitch(sound, lua_tonumber(L, 2));
    } else {
        luaL_error(L, "Expected (Sound, Number)");
        return (0);
    }
    return (0);
}