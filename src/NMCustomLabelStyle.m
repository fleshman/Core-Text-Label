//
//  NMCustomLabelStyle.m
//  Banana Stand
//
//  Created by Robert Haining on 6/18/12.
//  Copyright (c) 2012 News.me. All rights reserved.
//
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
//

#import "NMCustomLabelStyle.h"

NSString * const NMCustomLabelStyleDefaultKey = @"nm-default-style";
NSString * const NMCustomLabelStyleBoldKey = @"nm-bold-style";

@implementation NMCustomLabelStyle

@synthesize fontName, fontSize, textColor, highlightedTextColor, image, imageVerticalOffset;
@synthesize fontRef, colorRef, highlightedColorRef;

+(id)styleWithFont:(UIFont *)font color:(UIColor *)color highlightColor:(UIColor *)highlightColor{
    NMCustomLabelStyle *style = [NMCustomLabelStyle styleWithFont:font color:color];
	style.highlightedTextColor = highlightColor;
	return style;
}

+(id)styleWithFont:(UIFont *)font color:(UIColor *)color{
	NMCustomLabelStyle *style = [NMCustomLabelStyle new];
	style.fontName = font.fontName;
	style.fontSize = font.pointSize;
	style.textColor = color;
	return style;
}
+(id)styleWithImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset{
	NMCustomLabelStyle *style = [NMCustomLabelStyle new];
	style.image = image;
	style.imageVerticalOffset = verticalOffset;
	return style;
}
+(id)styleWithImage:(UIImage *)image{
	return [self styleWithImage:image verticalOffset:0];
}

-(void)dealloc{
	[self resetFontRef];
	[self resetTextColor];
}
-(void)resetFontRef{
	if(fontRef){
		CFRelease(fontRef);
		fontRef = nil;
	}	
}
-(void)resetTextColor{
	if(colorRef){
		CFRelease(colorRef);
		colorRef = nil;
	}	
}

-(void)setFontName:(NSString *)_fontName{
	fontName = [_fontName copy];
	[self resetFontRef];
}
-(void)setFontSize:(CGFloat)_fontSize{
	fontSize = _fontSize;
	[self resetFontRef];
}
-(void)setTextColor:(UIColor *)_textColor{
	textColor = _textColor;
}
-(void)setHighlightedTextColor:(UIColor *)_highlightedTextColor{
    highlightedTextColor = _highlightedTextColor;
}
-(void)setImage:(UIImage *)_image{
	image= _image;
}

-(CTFontRef)fontRef{
	if(!fontRef){
		if(!fontName){
			fontName = @"Helvetica";
		}
		if (fontSize == 0) {
			fontSize = 12;
		}
		fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, fontSize, NULL);
	}
	return fontRef;
}
-(CGColorRef)colorRef{
	if(textColor){
		return [textColor CGColor];
	}else{
		return [[UIColor blackColor] CGColor];
	}
}
-(CGColorRef)highlightedColorRef{
	if(highlightedTextColor){
		return [highlightedTextColor CGColor];
	}else{
		return [[UIColor whiteColor] CGColor];
	}
}

@end
