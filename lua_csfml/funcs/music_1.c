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

int music_create_from_file(lua_State *L)
{
    sfMusic *music = 0;
    sfMusic **music_p = 0;
    const char *str = NULL;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (FileName)");
        return (0);
    }
    if (lua_isstring(L, 1)) {
        str = lua_tostring(L, 1);
        music = sfMusic_createFromFile(str);
        music_p = (sfMusic **)lua_newuserdata(L, sizeof(sfMusic *));
        *music_p = music;
    } else {
        luaL_error(L, "Expected (String)");
        return (0);
    }
    return (1);
}

int music_destroy(lua_State *L)
{
    sfMusic *music = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        sfMusic_destroy(music);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (0);
}

int music_get_duration(lua_State *L)
{
    sfMusic *music = 0;
    sfTime time_m = {0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        time_m = sfMusic_getDuration(music);
        lua_pushinteger(L, time_m.microseconds);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (1);
}

int music_get_volume(lua_State *L)
{
    sfMusic *music = 0;
    double vol = 0.0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        vol = sfMusic_getVolume(music);
        lua_pushnumber(L, vol);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (1);
}

int music_pause(lua_State *L)
{
    sfMusic *music = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        sfMusic_pause(music);
    } else {
        luaL_error(L, "Expected (Music)");
        return (0);
    }
    return (0);
}
