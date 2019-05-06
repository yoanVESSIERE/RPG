/*
** EPITECH PROJECT, 2019
** texture_1
** File description:
** texture_1
*/


#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int texture_bind(lua_State *L)
{
    sfTexture *texture = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        sfTexture_bind(texture);
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (0);
}

int texture_copy(lua_State *L)
{
    sfTexture *texture = 0;
    sfTexture **ptr = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        ptr = (sfTexture **)lua_newuserdata(L, sizeof(sfTexture **));
        *ptr = sfTexture_copy(texture);
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (1);
}

int texture_copy_to_image(lua_State *L)
{
    sfTexture *texture = 0;
    sfImage **image = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        texture = USERDATA_POINTER(L, 1, sfTexture);
        image = (sfImage **)lua_newuserdata(L, sizeof(sfImage **));
        *image = sfTexture_copyToImage(texture);
    } else {
        luaL_error(L, "Expected (Texture)");
        return (0);
    }
    return (1);
}

int texture_create(lua_State *L)
{
    sfTexture **texture = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Width, Height)");
        return (0);
    }
    if (lua_isinteger(L, 1) && lua_isinteger(L, 2)) {
        texture = (sfTexture **)lua_newuserdata(L, sizeof(sfTexture **));
        *texture = sfTexture_create((unsigned int)lua_tointeger(L, 1),
        (unsigned int)lua_tointeger(L, 2));
    } else {
        luaL_error(L, "Expected (Number, Number)");
        return (0);
    }
    return (1);
}

int texture_create_from_file(lua_State *L)
{
    sfTexture **texture = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (TextureFile, Rect)");
        return (0);
    }
    if (lua_isstring(L, 1) && lua_istable(L, 2)) {
        sfIntRect rect = {0};
        if (!get_int_rect(L, &rect, 2)) return (0);
        texture = (sfTexture **)lua_newuserdata(L, sizeof(sfTexture **));
        *texture = sfTexture_createFromFile(lua_tostring(L, 1), &rect);
    } else {
        luaL_error(L, "Expected (String, Table)");
        return (0);
    }
    return (1);
}