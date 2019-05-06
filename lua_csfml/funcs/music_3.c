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

int music_set_loop(lua_State *L)
{
    sfMusic *music = 0;
    int nb = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Music, Bool)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        music = USERDATA_POINTER(L, 1, sfMusic);
        nb = lua_toboolean(L, 2);
        sfMusic_setLoop(music, nb);
    } else {
        luaL_error(L, "Expected (Music, Bool)");
        return (0);
    }
    return (0);
}