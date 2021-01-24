//
//  FBXScene.h
//  SwiftyFBX
//
//  Created by Hiroaki ENDOH on 2021/01/06.
//

#import <Foundation/Foundation.h>
#import "FBXDocument.h"
#import "FBXManager.h"

NS_ASSUME_NONNULL_BEGIN

@class FBXMesh;
@class FBXTexture;
@class FBXSkeleton;
@class FBXCamera;
@class FBXLight;
@class FBXSurfaceMaterial;

@interface FBXScene : FBXDocument
@property (nonatomic, readonly) NSArray<FBXMesh*> *meshs;
@property (nonatomic, readonly) NSArray<FBXTexture*> *textures;
@property (nonatomic, readonly) NSArray *markers;
@property (nonatomic, readonly) NSArray<FBXSkeleton*> *skeletons;
@property (nonatomic, readonly) NSArray *nurbs;
@property (nonatomic, readonly) NSArray *patches;
@property (nonatomic, readonly) NSArray<FBXCamera*> *cameras;
@property (nonatomic, readonly) NSArray<FBXLight*> *lights;
@property (nonatomic, readonly) NSArray *lodgroups;

- (NSUInteger)getPolygonCount;
- (NSUInteger)getMaterialCount;
- (FBXSurfaceMaterial*)getMaterialAtIndex:(int)index;
- (FBXSurfaceMaterial*)getMaterialWithName:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
