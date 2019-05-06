/*
** EPITECH PROJECT, 2019
** clock
** File description:
** clokc
*/

#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int clock_create(lua_State *L)
{
    sfClock **clock = 0;

    clock = (sfClock **)lua_newuserdata(L, sizeof(sfClock **));
    *clock = sfClock_create();
    return (1);
}

int clock_copy(lua_State *L)
{
    sfClock *clock = 0;
    sfClock **new = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        clock = USERDATA_POINTER(L, 1, sfClock);
        new = (sfClock **)lua_newuserdata(L, sizeof(sfClock **));
        *new = sfClock_copy(clock);
    } else {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    return (1);
}

int clock_destroy(lua_State *L)
{
    sfClock *clock = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        clock = USERDATA_POINTER(L, 1, sfClock);
        sfClock_destroy(clock);
    } else {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    return (0);
}

int clock_get_ellapsed_time(lua_State *L)
{
    sfClock *clock = 0;
    sfTime time = {0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        clock = USERDATA_POINTER(L, 1, sfClock);
        time = sfClock_getElapsedTime(clock);
        lua_pushinteger(L, time.microseconds);
    } else {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    return (1);
}

int clock_restart(lua_State *L)
{
    sfClock *clock = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        clock = USERDATA_POINTER(L, 1, sfClock);
        sfClock_restart(clock);
    } else {
        luaL_error(L, "Expected (Clock)");
        return (0);
    }
    return (0);
}