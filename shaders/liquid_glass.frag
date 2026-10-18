// Liquid Glass backdrop for MmGlass, used through ImageFilter.shader on
// Impeller.
//
// The panel is a rounded rectangle of thick, clear glass. Inside a band along
// its rim (the bezel) the surface curves, so light bends: each pixel there
// shows the backdrop from a little further out, pulling what is just past the
// edge into the rim. Red and blue bend slightly differently, giving a faint
// colour fringe. The middle of the panel is flat and shows the backdrop as
// is, with saturation lifted a little.
//
// Fragment coordinates are in render-target pixels, so the panel's rect is
// passed in the same space (global logical position times device pixel
// ratio).

#version 460 core

#include <flutter/runtime_effect.glsl>

// Set by the engine: the size of the backdrop texture.
uniform vec2 uSize;
// The panel: left, top, width, height in render-target pixels.
uniform vec4 uRect;
// Corner radius, in pixels.
uniform float uRadius;
// Width of the curved rim, in pixels.
uniform float uBezel;
// How far, in pixels, the outermost rim samples beyond itself.
uniform float uStrength;
// Red/blue split as a fraction of the bend (0 turns it off).
uniform float uDispersion;
// 1 leaves colours alone; above 1 makes them more vivid.
uniform float uSaturation;

// Set by the engine: the backdrop.
uniform sampler2D uTexture;

out vec4 fragColor;

// Signed distance to a rounded box centred on the origin: negative inside.
float roundedBox(vec2 p, vec2 halfSize, float r) {
  vec2 q = abs(p) - halfSize + vec2(r);
  return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

vec4 sampleAt(vec2 pos) {
  vec2 uv = clamp(pos / uSize, vec2(0.0), vec2(1.0));
#ifdef IMPELLER_TARGET_OPENGLES
  uv.y = 1.0 - uv.y;
#endif
  return texture(uTexture, uv);
}

void main() {
  vec2 frag = FlutterFragCoord().xy;
  vec2 halfSize = uRect.zw * 0.5;
  vec2 p = frag - (uRect.xy + halfSize);
  float r = min(uRadius, min(halfSize.x, halfSize.y));
  float d = roundedBox(p, halfSize, r);

  vec4 color;
  if (d > 0.0 || uBezel <= 0.0 || uStrength <= 0.0) {
    color = sampleAt(frag);
  } else {
    // Outward normal from the distance field's gradient.
    vec2 e = vec2(1.0, 0.0);
    vec2 n = vec2(
      roundedBox(p + e.xy, halfSize, r) - roundedBox(p - e.xy, halfSize, r),
      roundedBox(p + e.yx, halfSize, r) - roundedBox(p - e.yx, halfSize, r)
    );
    n /= max(length(n), 1e-4);

    // 0 on the rim, 1 once past the bezel; the bend falls off smoothly.
    float t = clamp(-d / uBezel, 0.0, 1.0);
    float bend = (1.0 - t) * (1.0 - t) * uStrength;
    vec2 shift = n * bend;

    color = sampleAt(frag + shift);
    if (uDispersion > 0.0) {
      color.r = sampleAt(frag + shift * (1.0 + uDispersion)).r;
      color.b = sampleAt(frag + shift * (1.0 - uDispersion)).b;
    }
  }

  // Colours are premultiplied; scaling around luma keeps them so.
  float luma = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
  color.rgb = mix(vec3(luma), color.rgb, uSaturation);
  fragColor = color;
}
