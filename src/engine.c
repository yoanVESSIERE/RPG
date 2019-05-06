/*
** EPITECH PROJECT, 2019
** engine
** File description:
** engine
*/

#include "lsfml.h"
#include <SFML/Window.h>
#include <SFML/Graphics.h>
#include <SFML/System.h>
#include "engine.h"

int init(lua_State *L)
{
    const char *error = 0;
    int len = -1;

    lua_getglobal(L, "init");
    if (pcall(L, 0, 0) != LUA_OK) {
        error = lua_tostring(L, -1);
        while (error[++len]);
        write(1,  error, len);
        write(1, "\n", 1);
        return (84);
    }
    return (1);
}

int draw(lua_State *L)
{
    const char *error = 0;
    int len = -1;

    lua_getglobal(L, "draw");
    if (pcall(L, 0, 0) != LUA_OK) {
        error = lua_tostring(L, -1);
        while (error[++len]);
        write(1,  error, len);
        write(1, "\n", 1);
        return (84);
    }
    return (1);
}

int update(lua_State *L)
{
    const char *error = 0;
    int len = -1;

    lua_getglobal(L, "update");
    if (pcall(L, 0, 0) != LUA_OK) {
        error = lua_tostring(L, -1);
        while (error[++len]);
        write(1,  error, len);
        write(1, "\n", 1);
        return (84);
    }
    return (1);
}

int event(lua_State *L, sfRenderWindow *window)
{
    const char *error = 0;
    int len = -1;
    sfEvent event;
    int args = 0;

    lua_getglobal(L, "event");
    if (!lua_isfunction(L, -1)) return (84);
    lua_pop(L, 1);
    while (sfRenderWindow_pollEvent(window, &event)) {
        lua_getglobal(L, "event");
        args = get_event(L, &event);
        if (pcall(L, args, 0) != LUA_OK) {
            error = lua_tostring(L, -1);
            while (error[++len]);
            write(1,  error, len);
            write(1, "\n", 1);
            return (84);
        }
    }
    return (1);
}

int engine(lua_State *L, sfRenderWindow *window)
{
    sfClock *update_clock = sfClock_create();
    sfTime deltatime = {0};

    if (init(L) == 84) return (84);
    sfRenderWindow_setFramerateLimit(window, 60);
    while (sfRenderWindow_isOpen(window)) {
        deltatime = sfClock_getElapsedTime(update_clock);
        lua_pushnumber(L, deltatime.microseconds / (1000000.0 / 60.0));
        sfClock_restart(update_clock);
        lua_setglobal(L, "DeltaTime");
        if (event(L, window) == 84) return (84);
        if (update(L) == 84) return (84);
        if (draw(L) == 84) return (84);
        sfRenderWindow_display(window);
    }
    return (0);
}