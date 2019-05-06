/*
** EPITECH PROJECT, 2019
** music
** File description:
** music
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include <SFML/Audio.h>
#include "utility.h"

int music_play(lua_State *L)
{
    sfMusic *music = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        sfMusic_play(music);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (0);
}

int music_stop(lua_State *L)
{
    sfMusic *music = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        sfMusic_stop(music);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (0);
}

int music_set_volume(lua_State *L)
{
    sfMusic *music = 0;
    float nb = 0.0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Music, Volume)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        nb = lua_tonumber(L, 2);
        sfMusic_setVolume(music, nb);
    } else {
        luaL_error(L, "Expected (Music, Float[0-100])");
        return (0);
    }
    return (0);
}

int music_set_position(lua_State *L)
{
    sfMusic *music = 0;
    sfVector3f vector = {0, 0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Music, Vector3f)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        if (!get_vector_3f(L, &vector, 2))
            return (0);
        sfMusic_setPosition(music, vector);
    } else {
        luaL_error(L, "Expected (Music, Table)");
        return (0);
    }
    return (0);
}

int music_get_position(lua_State *L)
{
    sfMusic *music = 0;
    sfVector3f vector = {0, 0, 0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        vector = sfMusic_getPosition(music);
        lua_pushnumber(L, vector.x);
        lua_pushnumber(L, vector.y);
        lua_pushnumber(L, vector.z);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (3);
}