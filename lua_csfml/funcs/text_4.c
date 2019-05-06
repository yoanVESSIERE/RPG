/*
** EPITECH PROJECT, 2019
** text
** File description:
** text
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include "utility.h"

int text_set_character_size(lua_State *L)
{
    sfText *text = 0;
    unsigned int size = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, Size)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        size = lua_tointeger(L, 2);
        sfText_setCharacterSize(text, size);
    } else {
        luaL_error(L, "Expected (Text, Integer)");
        return (0);
    }
    return (0);
}

int text_set_color(lua_State *L)
{
    sfText *text = 0;
    sfColor color = {0, 0, 0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, R, G, B, A)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2) && lua_isinteger(L, 3) &&
        lua_isinteger(L, 4) && lua_isinteger(L, 5)) {
        text = USERDATA_POINTER(L, 1, sfText);
        color.r = lua_tointeger(L, 2);
        color.g = lua_tointeger(L, 3);
        color.b = lua_tointeger(L, 4);
        color.a = lua_tointeger(L, 5);
        sfText_setColor(text, color);
    } else {
        luaL_error(L, "Expected (Text, Number, Number, Number, Number)");
        return (0);
    }
    return (0);
}

int text_get_string(lua_State *L)
{
    sfText *text = 0;
    const char *str = NULL;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        text = USERDATA_POINTER(L, 1, sfText);
        str = sfText_getString(text);
        lua_pushstring(L, str);
    } else {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    return (1);
}