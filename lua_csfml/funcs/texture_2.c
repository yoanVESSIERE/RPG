/*
** EPITECH PROJECT, 2019
** texture_2
** File description:
** texture_2
*/

#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int texture_create_from_image(lua_State *L)
{
    sfTexture **texture = 0;
    sfImage *image = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Image, Rect)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        image = USERDATA_POINTER(L, 1, sfImage);
        sfIntRect rect = {0};
        if (!get_int_rect(L, &rect, 2)) return (0);
        texture = (sfTexture **)lua_newuserdata(L, sizeof(sfTexture **));
        *texture = sfTexture_createFromImage(image, &rect);
    } else {
        luaL_error(L, "Expected (Image, Table)");
        return (0);
    }
    return (1);
}

int texture_get_maximum_size(lua_State *L)
{
    lua_pushinteger(L, sfTexture_getMaximumSize());
    return (1);
}

int texture_get_size(lua_State *L)
{
    sfTexture *texture = 0;
    sfVector2u size = {0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        size = sfTexture_getSize(texture);
        lua_pushinteger(L, size.x);
        lua_pushinteger(L, size.y);
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (2);
}

int texture_destroy(lua_State *L)
{
    sfTexture *texture = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        sfTexture_destroy(texture);
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (0);
}

int texture_is_repeated(lua_State *L)
{
    sfTexture *texture = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        lua_pushboolean(L, sfTexture_isRepeated(texture));
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (1);
}
