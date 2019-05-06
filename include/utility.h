/*
** EPITECH PROJECT, 2019
** utility
** File description:
** utility
*/

#ifndef LSFML_FUNCTION_H_
#define LSFML_FUNCTION_H_

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int get_vector_2f(lua_State *L, sfVector2f *vector, int index);
int get_int_rect(lua_State *L, sfIntRect *rect, int index);
int get_vector_3f(lua_State *L, sfVector3f *vector, int index);
int lua_iscolor(lua_State *L, int index);
sfColor lua_tocolor(lua_State *L, int index);
sfVertex lua_tovertex(lua_State *L, int index);
int lua_isvertex(lua_State *L, int index);
int lua_checktype(int (*func)(lua_State *, int), lua_State *L, int id);
char *primitive_type_to_char(sfPrimitiveType type);

#endif