attribute vec3 vPosition;
attribute vec3 vNormal;
attribute vec2 vTexCoord;

varying vec4 position;
varying vec3 normal;
varying vec2 texCoord;

uniform mat4 ModelView;
uniform mat4 Projection;

// Added bone variables for Part 2D.A.
attribute vec4 boneIDs;
attribute vec4 boneWeights;
uniform mat4 boneTransforms[64];

void main() {
    // PART 2D.A. Use type casting to convert float to int
    mat4 boneTransform = boneWeights[0] * boneTransforms[int(boneIDs[0])] +
                         boneWeights[1] * boneTransforms[int(boneIDs[1])] +
                         boneWeights[2] * boneTransforms[int(boneIDs[2])] +
                         boneWeights[3] * boneTransforms[int(boneIDs[3])];

    // Transform the vertex position and vertex normal with boneTransform
    vec4 positionTransform = boneTransform * vec4(vPosition, 1.0);
    vec3 normalTransform = vec3(boneTransform) * vNormal;

    position = positionTransform;
    normal = normalTransform;
    texCoord = vTexCoord;

    gl_Position = Projection * ModelView * positionTransform;
}
