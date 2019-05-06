/*
** EPITECH PROJECT, 2019
** lsfml_function
** File description:
** lsfml_function
*/

#ifndef LSFML_FUNCTION_H_
#define LSFML_FUNCTION_H_

#include "lua_include.h"

int win_clear(lua_State *L);
int win_cursor_visible(lua_State *L);
int win_close(lua_State *L);
int win_draw_circle_shape(lua_State *L);
int win_get_size(lua_State *L);
int win_draw_convex_shape(lua_State *L);
int win_draw_vertex_array(lua_State *L);
int win_draw_rectangle_shape(lua_State *L);
int win_draw_shape(lua_State *L);
int win_draw_sprite(lua_State *L);
int win_draw_text(lua_State *L);
int win_set_framerate_limit(lua_State *L);
int win_set_mouse_cursor_grabbed(lua_State *L);

int sprite_set_texture(lua_State *L);
int sprite_get_position(lua_State *L);
int sprite_create(lua_State *L);
int sprite_destroy(lua_State *L);
int sprite_move(lua_State *L);
int sprite_set_position(lua_State *L);
int sprite_set_scale(lua_State *L);
int sprite_get_scale(lua_State *L);
int sprite_set_rotation(lua_State *L);
int sprite_rotate(lua_State *L);
int sprite_get_rotation(lua_State *L);
int sprite_get_origin(lua_State *L);
int sprite_scale(lua_State *L);
int sprite_set_origin(lua_State *L);
int sprite_set_texture_rect(lua_State *L);
int sprite_set_color(lua_State *L);
int sprite_copy(lua_State *L);

int text_create(lua_State *L);
int text_destroy(lua_State *L);
int text_get_position(lua_State *L);
int text_set_scale(lua_State *L);
int text_set_position(lua_State *L);
int text_move(lua_State *L);
int text_rotate(lua_State *L);
int text_scale(lua_State *L);
int text_set_rotation(lua_State *L);
int text_get_origin(lua_State *L);
int text_get_scale(lua_State *L);
int text_set_origin(lua_State *L);
int text_get_rotation(lua_State *L);
int text_set_string(lua_State *L);
int text_set_font(lua_State *L);
int text_set_character_size(lua_State *L);
int text_get_string(lua_State *L);

int font_create_from_file(lua_State *L);
int font_destroy(lua_State *L);

int shader_bind(lua_State *L);
int shader_create_from_file(lua_State *L);
int shader_create_from_memory(lua_State *L);
int shader_destroy(lua_State *L);
int shader_is_available(lua_State *L);
int shader_set_color_parameter(lua_State *L);
int shader_set_texture_parameter(lua_State *L);
int shader_set_float2_parameter(lua_State *L);
int shader_set_float3_parameter(lua_State *L);
int shader_set_float4_parameter(lua_State *L);
int shader_set_float_parameter(lua_State *L);
int shader_setcurrenttextureparameter(lua_State *L);
int shader_set_transform_parameter(lua_State *L);

int texture_bind(lua_State *L);
int texture_copy(lua_State *L);
int texture_copy_to_image(lua_State *L);
int texture_create(lua_State *L);
int texture_create_from_file(lua_State *L);
int texture_create_from_image(lua_State *L);
int texture_get_maximum_size(lua_State *L);
int texture_get_size(lua_State *L);
int texture_destroy(lua_State *L);
int texture_is_repeated(lua_State *L);
int texture_is_smooth(lua_State *L);
int texture_set_repeated(lua_State *L);
int texture_set_smooth(lua_State *L);
int texture_update_from_image(lua_State *L);

int clock_create(lua_State *L);
int clock_copy(lua_State *L);
int clock_destroy(lua_State *L);
int clock_get_ellapsed_time(lua_State *L);
int clock_restart(lua_State *L);

int music_create_from_file(lua_State *L);
int music_destroy(lua_State *L);
int music_get_duration(lua_State *L);
int music_get_volume(lua_State *L);
int music_pause(lua_State *L);
int music_play(lua_State *L);
int music_stop(lua_State *L);
int music_set_volume(lua_State *L);
int music_set_position(lua_State *L);
int music_get_position(lua_State *L);
int music_set_loop(lua_State *L);

int vertexarray_append(lua_State *L);
int vertexarray_clear(lua_State *L);
int vertexarray_copy(lua_State *L);
int vertexarray_create(lua_State *L);
int vertexarray_destroy(lua_State *L);
int vertexarray_get_bounds(lua_State *L);
int vertexarray_get_primitive_type(lua_State *L);
int vertexarray_get_vertex(lua_State *L);
int vertexarray_get_vertex_count(lua_State *L);
int vertexarray_resize(lua_State *L);
int vertexarray_set_primitive_type(lua_State *L);

int vertex_destroy(lua_State *L);
int vertex_create(lua_State *L);
int vertex_set_x(lua_State *L);
int vertex_set_y(lua_State *L);
int vertex_set_tx(lua_State *L);
int vertex_set_ty(lua_State *L);
int vertex_set_r(lua_State *L);
int vertex_set_g(lua_State *L);
int vertex_set_b(lua_State *L);
int vertex_set_a(lua_State *L);
int vertex_get_x(lua_State *L);
int vertex_get_y(lua_State *L);
int vertex_get_tx(lua_State *L);
int vertex_get_ty(lua_State *L);
int vertex_get_r(lua_State *L);
int vertex_get_g(lua_State *L);
int vertex_get_b(lua_State *L);
int vertex_get_a(lua_State *L);

int mouse_get_position(lua_State *L);
int mouse_set_position(lua_State *L);
int mouse_is_button_pressed(lua_State *L);

int keyboard_key_pressed(lua_State *L);

int sound_copy(lua_State *L);
int sound_create(lua_State *L);
int sound_destroy(lua_State *L);
int sound_get_attenuation(lua_State *L);
int sound_get_buffer(lua_State *L);
int sound_get_loop(lua_State *L);
int sound_get_min_distance(lua_State *L);
int sound_get_pitch(lua_State *L);
int sound_get_playing_offset(lua_State *L);
int sound_get_position(lua_State *L);
int sound_get_status(lua_State *L);
int sound_get_volume(lua_State *L);
int sound_get_is_relative_to_lister(lua_State *L);
int sound_pause(lua_State *L);
int sound_play(lua_State *L);
int sound_set_attenuation(lua_State *L);
int sound_set_buffer(lua_State *L);
int sound_set_loop(lua_State *L);
int sound_set_min_distance(lua_State *L);
int sound_set_pitch(lua_State *L);
int sound_set_playing_offset(lua_State *L);
int sound_set_position(lua_State *L);
int sound_set_relative_to_lister(lua_State *L);
int sound_set_volume(lua_State *L);
int sound_stop(lua_State *L);

int soundbuffer_destroy(lua_State *L);
int soundbuffer_create_from_file(lua_State *L);

#endif /* !LSFML_FUNCTION_H_ */
