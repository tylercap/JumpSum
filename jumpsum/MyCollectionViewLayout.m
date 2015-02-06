//
//  MyCollectionViewLayout.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewLayout.h"

static NSString * const CellIdentifier = @"TileCell";
static NSString * const ButtonIdentifier = @"ButtonCell";

@implementation MyCollectionViewLayout

- (void)setup
{
    float spacing = 7.0f;
    self.itemInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    
    self.numberOfRows = [self.collectionView numberOfSections];
    self.numberOfColumns = [self.collectionView numberOfItemsInSection:3];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat availableWidth  = size.width - (spacing * (self.numberOfColumns + 1));
    CGFloat availableHeight = size.height - (spacing * (self.numberOfRows + 1));
    
    CGFloat squareSize = availableWidth / self.numberOfColumns;
    squareSize = fmin(squareSize, (availableHeight / self.numberOfRows));
    self.itemSize = CGSizeMake(squareSize, squareSize);
    
    self.interItemSpacingY = spacing;
    self.interItemSpacingX = spacing;
}

#pragma mark - Layout

- (void)prepareLayout
{
    [self setup];
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForItemAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[CellIdentifier] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

#pragma mark - Private

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.section;
    NSInteger column = indexPath.item;
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + self.interItemSpacingX) * column);
    
    CGFloat originY = floorf(self.itemInsets.top + (self.itemSize.height + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[CellIdentifier][indexPath];
}

- (CGSize)collectionViewContentSize
{
    NSInteger rowCount = [self.collectionView numberOfSections];
    CGFloat height = self.itemInsets.top + self.itemInsets.bottom +
                    rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY;
    
    NSInteger colCount = [self.collectionView numberOfItemsInSection:3];
    CGFloat width = self.itemInsets.left + self.itemInsets.right +
                    colCount * self.itemSize.width + (colCount - 1) * self.interItemSpacingX;
    
    return CGSizeMake(width, height);
}

@end