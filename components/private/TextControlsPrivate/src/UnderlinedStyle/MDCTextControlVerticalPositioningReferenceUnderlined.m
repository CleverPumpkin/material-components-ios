// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCTextControlVerticalPositioningReferenceUnderlined.h"
#import "MDCTextControlVerticalPositioningReference.h"

/**
 These values do not come from anywhere in particular. They are values I chose in an attempt to
 achieve the look and feel of the textfields at
 https://material.io/design/components/text-fields.html.
*/

static const CGFloat kMinPaddingAroundTextWhenNoFloatingLabel = 6.0f;
static const CGFloat kMaxPaddingAroundTextWhenNoFloatingLabel = 10.0f;
static const CGFloat kMinPaddingBetweenContainerTopAndFloatingLabel = 6.0f;
static const CGFloat kMaxPaddingBetweenContainerTopAndFloatingLabel = 10.0f;
static const CGFloat kMinPaddingBetweenFloatingLabelAndEditingText = 3.0f;
static const CGFloat kMaxPaddingBetweenFloatingLabelAndEditingText = 4.0f;
static const CGFloat kMinPaddingBetweenEditingTextAndContainerBottom = 6.0f;
static const CGFloat kMaxPaddingBetweenEditingTextAndContainerBottom = 8.0f;
static const CGFloat kMinPaddingAboveAssistiveLabels = 3.0f;
static const CGFloat kMaxPaddingAboveAssistiveLabels = 18.0f;
static const CGFloat kMinPaddingBelowAssistiveLabels = 0.0f;
static const CGFloat kMaxPaddingBelowAssistiveLabels = 0.0f;

/**
 For slightly more context on what this class is doing look at
 MDCTextControlVerticalPositioningReferenceBase. It's very similar and has some comments. Maybe at
 some point all the positioning references should be refactored to share a superclass, because
 there's currently a lot of duplicated code among the three of them.
*/
@interface MDCTextControlVerticalPositioningReferenceUnderlined ()
@end

@implementation MDCTextControlVerticalPositioningReferenceUnderlined

@synthesize paddingBetweenContainerTopAndFloatingLabel =
    _paddingBetweenContainerTopAndFloatingLabel;
@synthesize paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndEditingText = _paddingBetweenFloatingLabelAndEditingText;
@synthesize paddingBetweenEditingTextAndContainerBottom =
    _paddingBetweenEditingTextAndContainerBottom;
@synthesize containerHeightWithFloatingLabel = _containerHeightWithFloatingLabel;
@synthesize containerHeightWithoutFloatingLabel = _containerHeightWithoutFloatingLabel;
@synthesize paddingAroundTextWhenNoFloatingLabel = _paddingAroundTextWhenNoFloatingLabel;
@synthesize paddingAboveAssistiveLabels = _paddingAboveAssistiveLabels;
@synthesize paddingBelowAssistiveLabels = _paddingBelowAssistiveLabels;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight
                        isMultilineTextControl:(BOOL)isMultilineTextControl {
  self = [super init];
  if (self) {
    [self calculatePaddingValuesWithFoatingFontLineHeight:floatingLabelHeight
                                     normalFontLineHeight:normalFontLineHeight
                                            textRowHeight:textRowHeight
                                         numberOfTextRows:numberOfTextRows
                                                  density:density
                                 preferredContainerHeight:preferredContainerHeight
                                   isMultilineTextControl:isMultilineTextControl];
  }
  return self;
}

- (void)calculatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                   normalFontLineHeight:(CGFloat)normalFontLineHeight
                                          textRowHeight:(CGFloat)textRowHeight
                                       numberOfTextRows:(CGFloat)numberOfTextRows
                                                density:(CGFloat)density
                               preferredContainerHeight:(CGFloat)preferredContainerHeight
                                 isMultilineTextControl:(BOOL)isMultilineTextControl {
  CGFloat clampedDensity = MDCTextControlClampDensity(density);

  _paddingBetweenContainerTopAndFloatingLabel = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenContainerTopAndFloatingLabel,
      kMaxPaddingBetweenContainerTopAndFloatingLabel, clampedDensity);

  _paddingBetweenFloatingLabelAndEditingText = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenFloatingLabelAndEditingText, kMaxPaddingBetweenFloatingLabelAndEditingText,
      clampedDensity);

  _paddingBetweenEditingTextAndContainerBottom = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenEditingTextAndContainerBottom,
      kMaxPaddingBetweenEditingTextAndContainerBottom, clampedDensity);

  _paddingAboveAssistiveLabels = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingAboveAssistiveLabels, kMaxPaddingAboveAssistiveLabels, clampedDensity);
    
  _paddingBelowAssistiveLabels = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBelowAssistiveLabels, kMaxPaddingBelowAssistiveLabels, clampedDensity);

  _paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndFloatingLabel +
                                              floatingLabelHeight +
                                              _paddingBetweenFloatingLabelAndEditingText;

  CGFloat defaultContainerHeightForFloatingLabel =
      MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
          floatingLabelHeight, textRowHeight, numberOfTextRows,
          _paddingBetweenContainerTopAndFloatingLabel, _paddingBetweenFloatingLabelAndEditingText,
          _paddingBetweenEditingTextAndContainerBottom);
  BOOL preferredContainerHeightIsValidForFloatingLabel =
      preferredContainerHeight > defaultContainerHeightForFloatingLabel;
  if (preferredContainerHeightIsValidForFloatingLabel) {
    _containerHeightWithFloatingLabel = preferredContainerHeight;
    BOOL shouldUpdatePaddingValuesToMeetMinimumHeight = !isMultilineTextControl;
    if (shouldUpdatePaddingValuesToMeetMinimumHeight) {
      CGFloat difference = preferredContainerHeight - defaultContainerHeightForFloatingLabel;
      CGFloat sumOfPaddingValues = _paddingBetweenContainerTopAndFloatingLabel +
                                   _paddingBetweenFloatingLabelAndEditingText +
                                   _paddingBetweenEditingTextAndContainerBottom;
      _paddingBetweenContainerTopAndFloatingLabel =
          _paddingBetweenContainerTopAndFloatingLabel +
          ((_paddingBetweenContainerTopAndFloatingLabel / sumOfPaddingValues) * difference);
      _paddingBetweenFloatingLabelAndEditingText =
          _paddingBetweenFloatingLabelAndEditingText +
          ((_paddingBetweenFloatingLabelAndEditingText / sumOfPaddingValues) * difference);
      _paddingBetweenEditingTextAndContainerBottom =
          _paddingBetweenEditingTextAndContainerBottom +
          ((_paddingBetweenEditingTextAndContainerBottom / sumOfPaddingValues) * difference);
      _paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndFloatingLabel +
                                                  floatingLabelHeight +
                                                  _paddingBetweenFloatingLabelAndEditingText;
    }
  } else {
    _containerHeightWithFloatingLabel = defaultContainerHeightForFloatingLabel;
  }

  _paddingAroundTextWhenNoFloatingLabel = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingAroundTextWhenNoFloatingLabel, kMaxPaddingAroundTextWhenNoFloatingLabel,
      clampedDensity);

  CGFloat defaultContainerHeightForNoFloatingLabel =
      MDCTextControlCalculateContainerHeightWhenNoFloatingLabelWithTextRowHeight(
          textRowHeight, numberOfTextRows, _paddingAroundTextWhenNoFloatingLabel);
  BOOL preferredContainerHeightIsValidForNoFloatingLabel =
      preferredContainerHeight > defaultContainerHeightForNoFloatingLabel;
  if (preferredContainerHeightIsValidForNoFloatingLabel) {
    _containerHeightWithoutFloatingLabel = preferredContainerHeight;
    BOOL shouldUpdatePaddingValuesToMeetMinimumHeight = !isMultilineTextControl;
    if (shouldUpdatePaddingValuesToMeetMinimumHeight) {
      CGFloat difference = preferredContainerHeight - defaultContainerHeightForNoFloatingLabel;
      CGFloat sumOfPaddingValues = _paddingAroundTextWhenNoFloatingLabel * 2.0f;
      _paddingAroundTextWhenNoFloatingLabel =
          _paddingAroundTextWhenNoFloatingLabel +
          ((_paddingAroundTextWhenNoFloatingLabel / sumOfPaddingValues) * difference);
    }
  } else {
    _containerHeightWithoutFloatingLabel = defaultContainerHeightForNoFloatingLabel;
  }

  if (isMultilineTextControl) {
    CGFloat heightWithOneRow = MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
        floatingLabelHeight, textRowHeight, 1, _paddingBetweenContainerTopAndFloatingLabel,
        _paddingBetweenFloatingLabelAndEditingText, _paddingBetweenEditingTextAndContainerBottom);
    CGFloat halfOfHeightWithOneRow = (CGFloat)0.5 * heightWithOneRow;
    CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
    _paddingBetweenContainerTopAndNormalLabel = halfOfHeightWithOneRow - halfOfNormalFontLineHeight;
  }
}

- (CGFloat)paddingBetweenContainerTopAndFloatingLabel {
  return _paddingBetweenContainerTopAndFloatingLabel;
}

- (CGFloat)paddingBetweenContainerTopAndNormalLabel {
  return _paddingBetweenContainerTopAndNormalLabel;
}

- (CGFloat)paddingBetweenFloatingLabelAndEditingText {
  return _paddingBetweenFloatingLabelAndEditingText;
}

- (CGFloat)paddingBetweenEditingTextAndContainerBottom {
  return _paddingBetweenEditingTextAndContainerBottom;
}

- (CGFloat)paddingAboveAssistiveLabels {
  return _paddingAboveAssistiveLabels;
}

- (CGFloat)paddingBelowAssistiveLabels {
  return _paddingBelowAssistiveLabels;
}

- (CGFloat)containerHeightWithFloatingLabel {
  return _containerHeightWithFloatingLabel;
}

- (CGFloat)containerHeightWithoutFloatingLabel {
  return _containerHeightWithoutFloatingLabel;
}

- (CGFloat)paddingAroundTextWhenNoFloatingLabel {
  return _paddingAroundTextWhenNoFloatingLabel;
}

@end
