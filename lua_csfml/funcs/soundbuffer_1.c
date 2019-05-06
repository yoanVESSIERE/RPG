/*
** EPITECH PROJECT, 2019
** soundbuffer
** File description:
** soundbuffer
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include <SFML/Audio.h>

int soundbuffer_create_from_file(lua_State *L)
{
    sfSoundBuffer **new = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (File)");
        return (0);
    }
    if (lua_isstring(L, 1)) {
        new = (sfSoundBuffer **)lua_newuserdata(L, sizeof(sfSoundBuffer *));
        *new = sfSoundBuffer_createFromFile(lua_tostring(L, 1));
    } else {
        luaL_error(L, "Expected (String)");
        return (0);
    }
    return (1);
}

int soundbuffer_destroy(lua_State *L)
{
    sfSoundBuffer *sound = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (SoundBuffer)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sound = USERDATA_POINTER(L, 1, sfSoundBuffer);
        sfSoundBuffer_destroy(sound);
    } else {
        luaL_error(L, "Expected (SoundBuffer)");
        return (0);
    }
    return (1);
}