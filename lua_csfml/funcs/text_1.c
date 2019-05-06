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

int text_create(lua_State *L)
{
    sfText *text;
    sfText **text_p;

    text = sfText_create();
    text_p = (sfText **)lua_newuserdata(L, sizeof(sfText *));
    *text_p = text;
    return (1);
}

int text_destroy(lua_State *L)
{
    sfText *text = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        text = USERDATA_POINTER(L, 1, sfText);
        sfText_destroy(text);
    } else {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    return (0);
}

int text_get_position(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};


    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        text = USERDATA_POINTER(L, 1, sfText);
        vector = sfText_getPosition(text);
        lua_pushnumber(L, vector.x);
        lua_pushnumber(L, vector.y);
    } else {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    return (2);
}

int text_set_scale(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, Vector2f)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        if (!get_vector_2f(L, &vector, 2))
            return (0);
        sfText_setScale(text, vector);
    } else {
        luaL_error(L, "Expected (Text, Table)");
        return (0);
    }
    return (0);
}

int text_set_position(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, Vector2f)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        if (!get_vector_2f(L, &vector, 2))
            return (0);
        sfText_setPosition(text, vector);
    } else {
        luaL_error(L, "Expected (Text, Table)");
        return (0);
    }
    return (0);
}