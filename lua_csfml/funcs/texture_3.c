/*
** EPITECH PROJECT, 2019
** texture_3
** File description:
** texture_3
*/

#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int texture_is_smooth(lua_State *L)
{
    sfTexture *texture = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        lua_pushboolean(L, sfTexture_isSmooth(texture));
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (1);
}

int texture_set_repeated(lua_State *L)
{
    sfTexture *texture = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Texture, isRepeated)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        sfTexture_setRepeated(texture, lua_toboolean(L, 2));
    } else {
        luaL_error(L, "Expected (Texture, Boolean)");
        return (0);
    }
    return (0);
}

int texture_set_smooth(lua_State *L)
{
    sfTexture *texture = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Texture, isSmooth)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        sfTexture_setSmooth(texture, lua_toboolean(L, 2));
    } else {
        luaL_error(L, "Expected (Texture, Boolean)");
        return (0);
    }
    return (0);
}

int texture_update_from_image(lua_State *L)
{
    sfTexture *texture = 0;
    sfImage *image = 0;

    if (lua_gettop(L) < 4) {
        luaL_error(L, "Expected (Texture, Image, x, y)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        lua_isinteger(L, 3) && lua_isinteger(L, 4)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        image = USERDATA_POINTER(L, 2, sfImage);
        sfTexture_updateFromImage(texture, image,
        (unsigned int)lua_tointeger(L, 3), (unsigned int)lua_tointeger(L, 4));
    } else {
        luaL_error(L, "Expected (Texture, Image, Number, Number)");
        return (0);
    }
    return (0);
}