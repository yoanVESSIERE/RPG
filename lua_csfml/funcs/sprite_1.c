/*
** EPITECH PROJECT, 2019
** sprite
** File description:
** sprite
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include "utility.h"

int sprite_set_texture(lua_State *L)
{
    sfSprite *sprite = 0;
    sfTexture *texture = 0;
    int nb;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Sprite, Texture, resetRect)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) && lua_isboolean(L, 3)) {
        sprite = USERDATA_POINTER(L, 1, sfSprite);
        texture = USERDATA_POINTER(L, 2, sfTexture);
        nb = lua_toboolean(L, 3);
        sfSprite_setTexture(sprite, texture, nb);
    } else {
        luaL_error(L, "Expected (Sprite, Texture, Bool)");
        return (0);
    }
    return (0);
}

int sprite_get_position(lua_State *L)
{
    sfSprite *sprite = 0;
    sfVector2f vector = {0, 0};


    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sprite)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sprite = USERDATA_POINTER(L, 1, sfSprite);
        vector = sfSprite_getPosition(sprite);
        lua_pushnumber(L, vector.x);
        lua_pushnumber(L, vector.y);
    } else {
        luaL_error(L, "Expected (Sprite)");
        return (0);
    }
    return (2);
}

int sprite_create(lua_State *L)
{
    sfSprite *sprite;
    sfSprite **sprite_p;

    sprite = sfSprite_create();
    sprite_p = (sfSprite **)lua_newuserdata(L, sizeof(sfSprite *));
    *sprite_p = sprite;
    return (1);
}

int sprite_destroy(lua_State *L)
{
    sfSprite *sprite = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Sprite)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        sprite = USERDATA_POINTER(L, 1, sfSprite);
        sfSprite_destroy(sprite);
    } else {
        luaL_error(L, "Expected (Sprite)");
        return (0);
    }
    return (0);
}

int sprite_move(lua_State *L)
{
    sfSprite *sprite = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Sprite, Vector2f)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        sprite = USERDATA_POINTER(L, 1, sfSprite);
        if (!get_vector_2f(L, &vector, 2))
            return (0);
        sfSprite_move(sprite, vector);
    } else {
        luaL_error(L, "Expected (Sprite, Table)");
        return (0);
    }
    return (0);
}