//
//  FBXScene.mm
//  SwiftyFBX
//
//  Created by Hiroaki ENDOH on 2021/01/06.
//

#import "FBXScene.h"
#import "FBXSecne_Internal.h"
#import "FBXMesh.h"
#import "FBXMesh_Internal.h"
#import "FBXTexture.h"
#import "FBXTexture_Internal.h"
#import "fbxsdk.h"

@implementation FBXScene {
    FbxScene* _cScene;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cScene = NULL;
        _markers = [NSArray array];
        _meshs = [NSMutableArray array];
        _textures = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithCScene:(FbxScene* )cScene
{
    self = [self init];
    if(cScene == NULL) {
        return self;
    }
    _cScene = cScene;
    
    int totalCount = 0;
    totalCount = cScene->GetMemberCount<FbxMesh>();
    for (int i = 0; i < totalCount; i++) {
        FbxMesh* cMesh = cScene->GetMember<FbxMesh>(i);
        if (cMesh != NULL) {
            FBXMesh *mesh = [[FBXMesh alloc] initWithCMesh:cMesh];
            [_meshs addObject:mesh];
        }
    }
    
    totalCount = cScene->GetMemberCount<FbxTexture>();
    for (int i = 0; i < totalCount; i++) {
        FbxTexture* cTexture = cScene->GetMember<FbxTexture>(i);
        if (cTexture != NULL) {
            FBXTexture *texture = [[FBXTexture alloc] initWithCTexture:cTexture];            
            [_textures addObject:texture];
        }
    }
    
    return self;
}

- (void)dealloc {
    _cScene = NULL;
    _markers = nil;
    _meshs = nil;
    _textures = nil;
}

+ (instancetype)createWithManager:(FBXManager *)manager sceneName:(NSString *)sceneName {
    return [[FBXScene alloc] init];
}

+ (instancetype)sceneWithCScene:(FbxScene* )cScene {
    FBXScene *scene = [[FBXScene alloc] init];
    if(cScene == NULL) {
        return scene;
    }
            
    return scene;
}

- (int)textureCount {
    if(_cScene == NULL) {
        return 0;
    }
    return 0;
    //_cScene->GetMemberCount<FbxTexture>();
}

- (int)getMemberCount {
    return 0;
}

@end
