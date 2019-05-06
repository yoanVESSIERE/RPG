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

int sound_copy(lua_State *L)
{
    sfSound *sound = 0;
    sfSound **new = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        new = (sfSound **)lua_newuserdata(L, sizeof(sfSound *));
        *new = sfSound_copy(sound);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_create(lua_State *L)
{
    sfSound **new = 0;

    new = (sfSound **)lua_newuserdata(L, sizeof(sfSound *));
    *new = sfSound_create();
    return (1);
}

int sound_destroy(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        sfSound_destroy(sound);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (0);
}

int sound_get_attenuation(lua_State *L)
{
    sfSound *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        lua_pushnumber(L, sfSound_getAttenuation(sound));
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}

int sound_get_buffer(lua_State *L)
{
    sfSound *sound = 0;
    const sfSoundBuffer **new = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSound);
        new = (const sfSoundBuffer **)
        lua_newuserdata(L, sizeof(sfSoundBuffer *));
        *new = sfSound_getBuffer(sound);
    } else {
        luaL_error(L, "Expected (Sound)");
        return (0);
    }
    return (1);
}